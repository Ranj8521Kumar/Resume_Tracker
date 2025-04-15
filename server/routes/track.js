const express = require("express");
const path = require("path");
const router = express.Router();
const View = require("../models/View");

// Route to log view and serve the resume
router.get("/:recipient", async (req, res) => {
  const ip = req.headers["x-forwarded-for"] || req.socket.remoteAddress;
  const userAgent = req.get("User-Agent");
  const recipient = req.params.recipient;

  try {
    await View.create({ recipient, ip, userAgent });

    const filePath = path.join(__dirname, "../public/resumes", `${recipient}.pdf`);
    res.sendFile(filePath, (err) => {
      if (err) {
        console.error("Error sending file:", err.message);
        res.status(404).send("Resume not found");
      }
    });
  } catch (err) {
    console.error("Error in view tracking:", err.message);
    res.status(500).send("Internal server error");
  }
});

// Dashboard API route
router.get("/", async (req, res) => {
  try {
    const data = await View.aggregate([
      {
        $group: {
          _id: "$recipient",
          viewCount: { $sum: 1 },
          firstViewedAt: { $min: "$viewedAt" },
          lastViewedAt: { $max: "$viewedAt" }
        }
      },
      {
        $project: {
          recipient: "$_id",
          _id: 0,
          viewCount: 1,
          firstViewedAt: 1,
          lastViewedAt: 1
        }
      },
      { $sort: { lastViewedAt: -1 } }
    ]);

    res.json(data);
  } catch (err) {
    console.error("Error fetching dashboard data:", err.message);
    res.status(500).send("Internal server error");
  }
});

module.exports = router;
