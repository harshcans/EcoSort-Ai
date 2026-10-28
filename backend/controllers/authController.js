
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const crypto = require("crypto");
const { randomInt } = require("crypto");

const User = require("../models/User");
const { sendEmail } = require("../services/emailService");

function hashOtp(otp) {
  return crypto.createHash("sha256").update(otp).digest("hex");
}

function createAccessToken(user) {
  return jwt.sign(
    { sub: user._id.toString(), email: user.email },
    process.env.JWT_ACCESS_SECRET,
    { expiresIn: process.env.ACCESS_TOKEN_EXPIRES || "15m" }
  );
}

function createRefreshToken(user) {
  return jwt.sign(
    { sub: user._id.toString(), type: "refresh" },
    process.env.JWT_REFRESH_SECRET,
    { expiresIn: process.env.REFRESH_TOKEN_EXPIRES || "7d" }
  );
}

async function sendOtpEmail(email, otp) {
  await sendEmail({
    to: email,
    subject: "Verify your EcoSort AI account",
    text: `Your EcoSort AI verification OTP is ${otp}. It expires in 5 minutes.`,
    html: `
      <div style="font-family: Arial, sans-serif; line-height: 1.6;">
        <h2>Welcome to EcoSort AI</h2>
        <p>Use the following OTP to verify your account:</p>
        <h1 style="letter-spacing: 6px;">${otp}</h1>
        <p>This OTP expires in 5 minutes.</p>
        <p>If you did not request this, you can ignore this email.</p>
      </div>
    `,
  });
}

async function register(req, res) {
  try {
    const { name, email, password } = req.body;

    if (
      typeof name !== "string" ||
      typeof email !== "string" ||
      typeof password !== "string" ||
      !name.trim() ||
      !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim()) ||
      password.length < 8
    ) {
      return res.status(400).json({
        success: false,
        message:
          "Provide a valid name, email, and password of at least 8 characters.",
      });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const existingUser = await User.findOne({
      email: normalizedEmail,
    });

    if (existingUser) {
      return res.status(409).json({
        success: false,
        message: "An account with this email already exists.",
      });
    }

    const hashedPassword = await bcrypt.hash(password, 12);
    const otp = String(randomInt(100000, 1000000));

    const user = await User.create({
      name: name.trim(),
      email: normalizedEmail,
      password: hashedPassword,
      isVerified: false,
      otpHash: hashOtp(otp),
      otpExpiresAt: new Date(Date.now() + 5 * 60 * 1000),
    });

    try {
      await sendOtpEmail(normalizedEmail, otp);
    } catch (emailError) {
      await User.deleteOne({ _id: user._id });
      console.error("OTP email error:", emailError.message);

      return res.status(503).json({
        success: false,
        message: "Could not send verification email. Please try again.",
      });
    }

    return res.status(201).json({
      success: true,
      message: "Registration successful. Check your email for the OTP.",
    });
  } catch (error) {
    if (error.code === 11000) {
      return res.status(409).json({
        success: false,
        message: "An account with this email already exists.",
      });
    }

    console.error("Register error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Registration failed.",
    });
  }
}

async function verifyOTP(req, res) {
  try {
    const { email, otp } = req.body;

    if (
      typeof email !== "string" ||
      typeof otp !== "string" ||
      !/^\d{6}$/.test(otp)
    ) {
      return res.status(400).json({
        success: false,
        message: "Provide a valid email and 6-digit OTP.",
      });
    }

    const user = await User.findOne({
      email: email.trim().toLowerCase(),
      isVerified: false,
    }).select("+otpHash +otpExpiresAt");

    if (!user || !user.otpHash || !user.otpExpiresAt) {
      return res.status(400).json({
        success: false,
        message: "Invalid OTP or account.",
      });
    }

    if (user.otpExpiresAt.getTime() < Date.now()) {
      return res.status(400).json({
        success: false,
        message: "OTP has expired. Please register again.",
      });
    }

    if (user.otpHash !== hashOtp(otp)) {
      return res.status(400).json({
        success: false,
        message: "Incorrect OTP.",
      });
    }

    user.isVerified = true;
    user.otpHash = undefined;
    user.otpExpiresAt = undefined;
    await user.save();

    return res.status(200).json({
      success: true,
      message: "Email verified successfully. You can now log in.",
    });
  } catch (error) {
    console.error("OTP verification error:", error.message);
    return res.status(500).json({
      success: false,
      message: "OTP verification failed.",
    });
  }
}

async function login(req, res) {
  try {
    const { email, password } = req.body;

    if (
      typeof email !== "string" ||
      typeof password !== "string" ||
      !email.trim() ||
      !password
    ) {
      return res.status(400).json({
        success: false,
        message: "Email and password are required.",
      });
    }

    const user = await User.findOne({
      email: email.trim().toLowerCase(),
    }).select("+password +refreshTokenHash");

    if (!user) {
      return res.status(401).json({
        success: false,
        message: "Invalid email or password.",
      });
    }

    const passwordMatches = await bcrypt.compare(
      password,
      user.password
    );

    if (!passwordMatches) {
      return res.status(401).json({
        success: false,
        message: "Invalid email or password.",
      });
    }

    if (!user.isVerified) {
      return res.status(403).json({
        success: false,
        message: "Please verify your email before logging in.",
      });
    }

    const accessToken = createAccessToken(user);
    const refreshToken = createRefreshToken(user);

    user.refreshTokenHash = await bcrypt.hash(refreshToken, 12);
    await user.save();

    return res.status(200).json({
      success: true,
      message: "Login successful.",
      accessToken,
      refreshToken,
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
      },
    });
  } catch (error) {
    console.error("Login error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Login failed.",
    });
  }
}

async function refreshToken(req, res) {
  try {
    const { refreshToken: token } = req.body;

    if (typeof token !== "string" || !token) {
      return res.status(400).json({
        success: false,
        message: "Refresh token is required.",
      });
    }

    let decoded;

    try {
      decoded = jwt.verify(token, process.env.JWT_REFRESH_SECRET);
    } catch {
      return res.status(401).json({
        success: false,
        message: "Refresh token is invalid or expired. Please log in again.",
      });
    }

    if (decoded.type !== "refresh" || !decoded.sub) {
      return res.status(401).json({
        success: false,
        message: "Invalid refresh token.",
      });
    }

    const user = await User.findById(decoded.sub).select(
      "+refreshTokenHash"
    );

    if (
      !user ||
      !user.refreshTokenHash ||
      !(await bcrypt.compare(token, user.refreshTokenHash))
    ) {
      return res.status(401).json({
        success: false,
        message: "Refresh token has been revoked. Please log in again.",
      });
    }

    const accessToken = createAccessToken(user);
    const newRefreshToken = createRefreshToken(user);

    user.refreshTokenHash = await bcrypt.hash(newRefreshToken, 12);
    await user.save();

    return res.status(200).json({
      success: true,
      accessToken,
      refreshToken: newRefreshToken,
    });
  } catch (error) {
    console.error("Refresh token error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Could not refresh session.",
    });
  }
}

async function logout(req, res) {
  try {
    const { refreshToken: token } = req.body;

    if (typeof token !== "string" || !token) {
      return res.status(400).json({
        success: false,
        message: "Refresh token is required.",
      });
    }

    let decoded;

    try {
      decoded = jwt.verify(token, process.env.JWT_REFRESH_SECRET);
    } catch {
      return res.status(200).json({
        success: true,
        message: "Logged out.",
      });
    }

    if (decoded.type !== "refresh" || !decoded.sub) {
      return res.status(400).json({
        success: false,
        message: "Invalid refresh token.",
      });
    }

    const user = await User.findById(decoded.sub).select(
      "+refreshTokenHash"
    );

    if (
      user?.refreshTokenHash &&
      await bcrypt.compare(token, user.refreshTokenHash)
    ) {
      user.refreshTokenHash = undefined;
      await user.save();
    }

    return res.status(200).json({
      success: true,
      message: "Logged out successfully.",
    });
  } catch (error) {
    console.error("Logout error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Logout failed.",
    });
  }
}

async function getMe(req, res) {
  try {
    const user = await User.findById(req.user.id).select(
      "name email isVerified createdAt"
    );

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found.",
      });
    }

    return res.status(200).json({
      success: true,
      user,
    });
  } catch (error) {
    console.error("Get user error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Could not fetch user.",
    });
  }
}

module.exports = {
  register,
  verifyOTP,
  login,
  refreshToken,
  logout,
  getMe,
};
