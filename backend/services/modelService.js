
const axios = require("axios");
const FormData = require("form-data");

async function classifyImage(file) {
  const modelUrl = process.env.MODEL_API_URL;

  if (!modelUrl) {
    throw new Error("MODEL_API_URL is not configured");
  }

  const form = new FormData();

  form.append("file", file.buffer, {
    filename: file.originalname,
    contentType: file.mimetype
  });

  const response = await axios.post(modelUrl, form, {
    headers: form.getHeaders(),
    timeout: 30000,
    maxBodyLength: 5 * 1024 * 1024
  });

  const { category, confidence } = response.data;

  if (
    typeof category !== "string" ||
    typeof confidence !== "number" ||
    !Number.isFinite(confidence) ||
    confidence < 0 ||
    confidence > 1
  ) {
    throw new Error("The ML service returned an invalid prediction");
  }

  return { category, confidence };
}

module.exports = { classifyImage };
