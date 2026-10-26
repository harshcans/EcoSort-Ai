const jwt = require("jsonwebtoken");

function authMiddleware(req, res, next) {
  const authorization = req.headers.authorization;

  if (!authorization || !authorization.startsWith("Bearer ")) {
    return res.status(401).json({
      success: false,
      message: "Access token is required.",
    });
  }

  const accessToken = authorization.split(" ")[1];

  try {
    const decoded = jwt.verify(accessToken, process.env.JWT_ACCESS_SECRET);

    req.user = {
      id: decoded.sub,
      email: decoded.email,
    };

    next();
  } catch (error) {
    return res.status(401).json({
      success: false,
      message:
        error.name === "TokenExpiredError"
          ? "Access token expired. Refresh your session."
          : "Invalid access token.",
    });
  }
}

module.exports = authMiddleware;
