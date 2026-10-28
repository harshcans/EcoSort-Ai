
const express = require("express");

const authMiddleware = require("../middleware/authMiddleware");

const {
  register,
  verifyOTP,
  login,
  refreshToken,
  logout,
  getMe,
} = require("../controllers/authController");

const router = express.Router();

router.post("/register", register);
router.post("/verify-otp", verifyOTP);
router.post("/login", login);
router.post("/refresh-token", refreshToken);
router.post("/logout", logout);
router.get("/me", authMiddleware, getMe);

module.exports = router;
