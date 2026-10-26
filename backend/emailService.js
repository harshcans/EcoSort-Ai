
const { Resend } = require("resend");

if (!process.env.RESEND_API_KEY) {
  throw new Error("RESEND_API_KEY is missing from environment variables.");
}

const resend = new Resend(process.env.RESEND_API_KEY);

async function sendEmail({ to, subject, html, text }) {
  const { data, error } = await resend.emails.send({
    from: process.env.EMAIL_FROM || "onboarding@resend.dev",
    to: [to],
    subject,
    html,
    text,
  });

  if (error) {
    console.error("Resend email error:", error.message);
    throw new Error("Email could not be sent.");
  }

  return data;
}

module.exports = { sendEmail };
