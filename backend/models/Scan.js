
const mongoose = require("mongoose");

const scanSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
      index: true,
    },

    imageUrl: {
      type: String,
      required: true,
    },

    imagePublicId: {
      type: String,
      required: true,
    },

    category: {
      type: String,
      default: null,
    },

    confidence: {
      type: Number,
      required: true,
      min: 0,
      max: 1,
    },

    status: {
      type: String,
      enum: ["classified", "uncertain"],
      required: true,
    },

    guidance: {
      type: mongoose.Schema.Types.Mixed,
      default: null,
    },
  },
  { timestamps: true }
);

scanSchema.index({ userId: 1, createdAt: -1 });

module.exports = mongoose.model("Scan", scanSchema);
