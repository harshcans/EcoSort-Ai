
const Scan = require("../models/Scan");
const { deleteImage } = require("../services/imageService");

// GET /api/scans/history
async function getScanHistory(req, res) {
  try {
    const page = Math.max(1, Number.parseInt(req.query.page, 10) || 1);
    const limit = Math.min(
      50,
      Math.max(1, Number.parseInt(req.query.limit, 10) || 10)
    );

    const filter = { userId: req.user.id };

    const [scans, total] = await Promise.all([
      Scan.find(filter)
        .sort({ createdAt: -1 })
        .skip((page - 1) * limit)
        .limit(limit)
        .select("-imagePublicId"),
      Scan.countDocuments(filter),
    ]);

    return res.status(200).json({
      success: true,
      scans,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    });
  } catch (error) {
    console.error("Get scan history error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Could not fetch scan history.",
    });
  }
}

// GET /api/scans/history/:id
async function getScanById(req, res) {
  try {
    const scan = await Scan.findOne({
      _id: req.params.id,
      userId: req.user.id,
    }).select("-imagePublicId");

    if (!scan) {
      return res.status(404).json({
        success: false,
        message: "Scan not found.",
      });
    }

    return res.status(200).json({
      success: true,
      scan,
    });
  } catch (error) {
    if (error.name === "CastError") {
      return res.status(400).json({
        success: false,
        message: "Invalid scan ID.",
      });
    }

    console.error("Get scan error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Could not fetch scan details.",
    });
  }
}

// DELETE /api/scans/history/:id
async function deleteScan(req, res) {
  try {
    const scan = await Scan.findOne({
      _id: req.params.id,
      userId: req.user.id,
    });

    if (!scan) {
      return res.status(404).json({
        success: false,
        message: "Scan not found.",
      });
    }

    // Delete the database record first so history updates immediately.
    await Scan.deleteOne({ _id: scan._id });

    try {
      await deleteImage(scan.imagePublicId);
    } catch (error) {
      // The scan is already deleted; a failed image cleanup can be retried.
      console.error("Cloudinary image deletion failed:", error.message);

      return res.status(200).json({
        success: true,
        message: "Scan deleted, but image cleanup failed.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Scan and image deleted successfully.",
    });
  } catch (error) {
    if (error.name === "CastError") {
      return res.status(400).json({
        success: false,
        message: "Invalid scan ID.",
      });
    }

    console.error("Delete scan error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Could not delete scan.",
    });
  }
}

module.exports = {
  getScanHistory,
  getScanById,
  deleteScan,
};
