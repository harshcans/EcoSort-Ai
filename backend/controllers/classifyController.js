
const { classifyImage } = require("../services/modelService");
const { getGuidance } = require("../services/guidanceService");
const Scan = require("../models/Scan");
const {
  uploadImage,
  deleteImage,
} = require("../services/imageService");

async function classifyController(req, res) {
  let uploadedImage;

  try {
    let prediction;

    try {
      prediction = await classifyImage(req.file);
    } catch (error) {
      console.error("ML service error:", error.message);

      return res.status(503).json({
        success: false,
        status: "model_unavailable",
        message: "The classification service is temporarily unavailable.",
      });
    }

    const { category, confidence } = prediction;

    if (
      typeof confidence !== "number" ||
      !Number.isFinite(confidence) ||
      confidence < 0 ||
      confidence > 1
    ) {
      return res.status(502).json({
        success: false,
        message: "The classification service returned an invalid result.",
      });
    }

    const threshold = Number(
      process.env.CONFIDENCE_THRESHOLD || 0.70
    );

    if (!Number.isFinite(threshold) || threshold < 0 || threshold > 1) {
      throw new Error("CONFIDENCE_THRESHOLD must be between 0 and 1.");
    }

    const guidance = getGuidance(category);
    const isClassified = Boolean(guidance) && confidence >= threshold;

    const status = isClassified ? "classified" : "uncertain";
    const savedCategory = isClassified ? category : null;
    const savedGuidance = isClassified ? guidance : null;

    // Upload the image to Cloudinary.
    uploadedImage = await uploadImage(req.file.buffer);

    // Save the classification result in MongoDB.
    let scan;

    try {
      scan = await Scan.create({
        userId: req.user.id,
        imageUrl: uploadedImage.imageUrl,
        imagePublicId: uploadedImage.imagePublicId,
        category: savedCategory,
        confidence,
        status,
        guidance: savedGuidance,
      });
    } catch (error) {
      // Remove the uploaded image if saving the scan fails.
      try {
        await deleteImage(uploadedImage.imagePublicId);
      } catch (cleanupError) {
        console.error(
          "Image cleanup failed:",
          cleanupError.message
        );
      }

      uploadedImage = null;
      throw error;
    }

    const result = {
      success: true,
      status,
      category: savedCategory,
      confidence,
      guidance: savedGuidance,
      imageUrl: scan.imageUrl,
      scanId: scan._id,
      createdAt: scan.createdAt,
    };

    if (!isClassified) {
      result.message = guidance
        ? "We could not identify this item reliably. Try a clearer photo."
        : "This item could not be assigned to a supported category.";
    }

    return res.status(200).json(result);
  } catch (error) {
    console.error("Classification error:", error);

    return res.status(500).json({
      success: false,
      message: "An unexpected error occurred during classification.",
    });
  }
}

module.exports = { classifyController };
