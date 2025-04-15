require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const path = require("path");
const fs = require("fs");
const multer = require("multer");
const trackRoutes = require("./routes/track.js");

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static("public"));
app.use("/track", trackRoutes);
app.use("/resumes", express.static("public/resumes"));

// Ensure resumes directory exists
const resumeDir = path.join(__dirname, "public", "resumes");
if (!fs.existsSync(resumeDir)) {
  fs.mkdirSync(resumeDir, { recursive: true });
}

// Use memory storage for multer
const upload = multer({ storage: multer.memoryStorage() });

app.post("/upload", upload.single("resume"), (req, res) => {
  const { recipient } = req.body;
  const file = req.file;

  if (!recipient || !file) {
    return res.status(400).json({ success: false, message: "Missing recipient or file." });
  }

  const ext = path.extname(file.originalname) || ".pdf";
  const filename = `${recipient}${ext}`;
  const savePath = path.join(resumeDir, filename);

  fs.writeFile(savePath, file.buffer, (err) => {
    if (err) {
      console.error("Error saving file:", err);
      return res.status(500).json({ success: false, message: "File save error" });
    }

    return res.json({ success: true, filename: filename });
  });
});

// MongoDB connection
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => console.log("MongoDB connected"))
  .catch((err) => console.error("MongoDB connection error:", err));

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
