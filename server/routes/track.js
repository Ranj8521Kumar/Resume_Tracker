const express = require("express");
const router = express.Router();
const View = require("../models/View");

router.get("/:recipient", async (req, res) => {
  const ip = req.headers["x-forwarded-for"] || req.socket.remoteAddress;
  const userAgent = req.get("User-Agent");
  const recipient = req.params.recipient;

  await View.create({
    recipient,
    ip,
    userAgent
  });

  const filePath = `public/resumes/${recipient}.pdf`;
  res.sendFile(filePath, { root: "." }, (err) => {
    if (err) {
      res.status(404).send("Resume not found");
    }
  });
});

module.exports = router;
