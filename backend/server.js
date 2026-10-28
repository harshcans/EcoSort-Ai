
require("dotenv").config();

const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const multer = require("multer");
const rateLimit = require("express-rate-limit");

const connectDB = require("./config/db");
const { getCategories } = require("./services/guidanceService");

const authRoutes = require("./routes/authRoutes");
const scanRoutes = require("./routes/scanRoutes");

const authMiddleware = require("./middleware/authMiddleware");
const imageValidator = require("./middleware/imageValidator");
const { classifyController } = require("./controllers/classifyController");

const app = express();

app.set("trust proxy", 1);
app.use(helmet());

const allowedOrigins = [
  "https://eco-sort-fend-a52x.vercel.app",
  "http://localhost:5173",
];

app.use(
  cors({
    origin(origin, callback) {
      if (!origin || allowedOrigins.includes(origin)) {
        return callback(null, true);
      }

      return callback(new Error("Not allowed by CORS"));
    },
  })
);

app.use(express.json({ limit: "100kb" }));

// Health check
app.get("/api/health", (req, res) => {
  res.status(200).json({
    success: true,
    message: "EcoSort AI backend is running",
  });
});

// Supported waste categories
app.get("/api/categories", (req, res) => {
  res.status(200).json({
    success: true,
    categories: getCategories(),
  });
});

// Authentication and scan history
app.use("/api/auth", authRoutes);
app.use("/api/scans", scanRoutes);

// Image upload configuration
const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: Number(process.env.MAX_FILE_SIZE_MB || 5) * 1024 * 1024,
    files: 1,
  },
});

// Limit classification requests
const classifyLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  limit: 30,
  standardHeaders: "draft-8",
  legacyHeaders: false,
  message: {
    success: false,
    message: "Too many classification requests. Please try again later.",
  },
});

// Classification pipeline
app.post(
  "/api/classify",
  authMiddleware,
  classifyLimiter,
  upload.single("image"),
  imageValidator,
  classifyController
);

// Central error handler
app.use((err, req, res, next) => {
  if (res.headersSent) {
    return next(err);
  }

  if (err instanceof multer.MulterError) {
    const tooLarge = err.code === "LIMIT_FILE_SIZE";

    return res.status(tooLarge ? 413 : 400).json({
      success: false,
      message: tooLarge
        ? "Image exceeds the allowed upload size."
        : "Invalid image upload.",
    });
  }

  console.error("Server error:", err.message);

  return res.status(500).json({
    success: false,
    message: "An internal server error occurred.",
  });
});

const PORT = process.env.PORT || 5000;

async function startServer() {
  await connectDB();

  app.listen(PORT, () => {
    console.log(`EcoSort AI backend running on port ${PORT}`);
  });
}

if (require.main === module) {
  startServer().catch((error) => {
    console.error("Server startup failed:", error.message);
    process.exit(1);
  });
}

module.exports = app;
