
const { fileTypeFromBuffer } = require("file-type");
const { classifyImage } = require("./modelService");
const { getGuidance } = require("./guidanceService");

const ALLOWED_IMAGE_TYPES = [
  "image/jpeg",
  "image/png",
  "image/webp"
];

async function classifyController(req, res) {
  try {
    if (!req.file) {
      return res.status(400).json({
        success: false,
        message: "Please upload an image using the 'image' field."
      });
    }

    const detectedType = await fileTypeFromBuffer(req.file.buffer);

    if (!detectedType || !ALLOWED_IMAGE_TYPES.includes(detectedType.mime)) {
      return res.status(400).json({
        success: false,
        message: "Unsupported or invalid image. Use JPEG, PNG, or WebP."
      });
    }

    let prediction;

    try {
      prediction = await classifyImage(req.file);
    } catch (error) {
      console.error("ML service error:", error.message);

      return res.status(503).json({
        success: false,
        status: "model_unavailable",
        message: "The classification service is temporarily unavailable."
      });
    }

    const { category, confidence } = prediction;
    const guidance = getGuidance(category);

    // Do not return a category the application does not support.
    if (!guidance) {
      return res.status(200).json({
        success: true,
        status: "uncertain",
        category: null,
        confidence,
        message: "This item could not be assigned to a supported category."
      });
    }

    const threshold = Number(
      process.env.CONFIDENCE_THRESHOLD || 0.70
    );

    if (confidence < threshold) {
      return res.status(200).json({
        success: true,
        status: "uncertain",
        category: null,
        confidence,
        message: "We could not identify this item reliably. Try a clearer photo."
      });
    }

    return res.status(200).json({
      success: true,
      status: "classified",
      category,
      confidence,
      guidance
    });
  } catch (error) {
    console.error("Classification error:", error.message);

    return res.status(500).json({
      success: false,
      message: "An unexpected error occurred during classification."
    });
  }
}

module.exports = { classifyController };
