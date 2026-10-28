
async function sendEmail({ to, subject, html, text }) {
  if (!process.env.BREVO_API_KEY || !process.env.EMAIL_FROM) {
    throw new Error("Brevo email configuration is missing.");
  }

  const response = await fetch(
    "https://api.brevo.com/v3/smtp/email",
    {
      method: "POST",
      headers: {
        accept: "application/json",
        "api-key": process.env.BREVO_API_KEY,
        "content-type": "application/json",
      },
      body: JSON.stringify({
        sender: {
          name: process.env.EMAIL_FROM_NAME || "EcoSort AI",
          email: process.env.EMAIL_FROM,
        },
        to: [{ email: to }],
        subject,
        htmlContent: html,
        textContent: text,
      }),
    }
  );

  const result = await response.json().catch(() => ({}));

  if (!response.ok) {
    console.error("Brevo email error:", result);
    throw new Error("Email could not be sent.");
  }

  return result;
}

module.exports = { sendEmail };
