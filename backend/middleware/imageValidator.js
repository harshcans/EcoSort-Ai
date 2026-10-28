
const { fileTypeFromBuffer } = require("file-type");

const ALLOWED_IMAGE_TYPES = [
  "image/jpeg",
  "image/png",
  "image/webp",
];

async function imageValidator(req, res, next) {
  try {
    if (!req.file) {
      return res.status(400).json({
        success: false,
        message: "Please upload an image using the 'image' field.",
      });
    }

    const detectedType = await fileTypeFromBuffer(req.file.buffer);

    if (
      !detectedType ||
      !ALLOWED_IMAGE_TYPES.includes(detectedType.mime)
    ) {
      return res.status(400).json({
        success: false,
        message: "Unsupported or invalid image. Use JPEG, PNG, or WebP.",
      });
    }

    next();
  } catch (error) {
    console.error("Image validation error:", error.message);

    return res.status(400).json({
      success: false,
      message: "Unable to validate the uploaded image.",
    });
  }
}

module.exports = imageValidator;
