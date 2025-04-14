const mongoose = require("mongoose");

const viewSchema = new mongoose.Schema({
  recipient: String,
  timestamp: { type: Date, default: Date.now },
  ip: String,
  userAgent: String
});

module.exports = mongoose.model("View", viewSchema);
