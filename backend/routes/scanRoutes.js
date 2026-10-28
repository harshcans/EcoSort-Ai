
const express = require("express");
const authMiddleware = require("../middleware/authMiddleware");

const {
  getScanHistory,
  getScanById,
  deleteScan,
} = require("../controllers/scanController");

const router = express.Router();

router.use(authMiddleware);

router.get("/history", getScanHistory);
router.get("/history/:id", getScanById);
router.delete("/history/:id", deleteScan);

module.exports = router;
