# ♻️ EcoSort AI

**AI-Powered Waste Classification and Recycling Assistant**

EcoSort AI is an intelligent waste classification system that uses machine learning to identify waste from images and provide guidance on how to dispose of it responsibly. The goal is to make waste segregation easier, encourage recycling, and promote environmentally responsible habits.

## 🌍 Project Overview

Proper waste segregation is essential for effective recycling and waste management. However, people often struggle to identify the correct category for different waste materials.

EcoSort AI addresses this problem by allowing users to upload an image of waste, receive an AI-generated classification, and access relevant disposal guidance.

## ✨ Key Features

- **AI-Based Classification:** Analyze uploaded waste images using a machine learning service.
- **Waste Disposal Guidance:** Provide disposal and recycling recommendations based on the predicted category.
- **Confidence-Based Results:** Communicate classification confidence and handle uncertain predictions appropriately.
- **User Authentication:** Register, verify email using OTP, and log in securely.
- **Protected API:** Require authentication for waste classification requests.
- **Input Validation:** Validate image uploads and enforce file-size limits.
- **API Rate Limiting:** Limit repeated classification requests to reduce abuse.
- **REST API:** Provide endpoints for authentication, classification, categories, and health checks.

## 🗂️ Waste Categories

The intended scope includes common waste categories such as:

- Plastic
- Paper
- Glass
- Metal
- Organic waste
- Electronic waste (e-waste)

**Note:** Actual classification support depends on the categories trained and returned by the connected ML model. Not every listed category is necessarily supported by the current model.

## 🛠️ Technology Stack

### Backend
- Node.js
- Express.js
- MongoDB
- Mongoose
- JSON Web Tokens (JWT)
- bcryptjs
- Multer
- Helmet
- CORS
- express-rate-limit

### Machine Learning
- Python-based ML service
- Image classification model
- HTTP API integration between the backend and ML service

### Frontend
- React
- Vite
- JavaScript
- HTML and CSS

### Deployment
- Render for hosted services
- MongoDB Atlas for cloud database hosting, if configured

## 🏗️ System Architecture

```text
User
  |
  v
React + Vite Frontend
  |
  | Authentication / Image Upload
  v
Node.js + Express Backend
  |
  +----> MongoDB
  |       User Accounts
  |
  +----> ML Classification Service
  |       Image Prediction
  |
  v
Classification Result
  |
  v
Waste Category + Confidence
+ Disposal Guidance
  |
  v
Frontend Result Display
```

The frontend communicates with the backend through HTTP requests. The backend handles authentication, validates uploaded images, and communicates with the machine learning service to obtain predictions.

## 🔗 Live Services

- **GitHub Repository:** https://github.com/harshcans/EcoSort-Ai
- **Backend API:** https://ecosort-ai-u1ln.onrender.com
- **ML Service Documentation:** https://ecosort-ai-q5i2.onrender.com/docs

## 🚀 Getting Started

### Prerequisites

Install the following before running the project locally:

- Node.js and npm
- Git
- MongoDB Atlas account or a local MongoDB instance
- Access to the deployed ML service or a locally running ML service

### 1. Clone the Repository

```bash
git clone https://github.com/harshcans/EcoSort-Ai.git
cd EcoSort-Ai
```

### 2. Set Up the Backend

```bash
cd backend
npm install
```

### 3. Configure Environment Variables

Create a `.env` file inside the `backend` directory.

```env
PORT=5000
MONGODB_URI=your_mongodb_connection_string

JWT_ACCESS_SECRET=your_access_token_secret
JWT_REFRESH_SECRET=your_refresh_token_secret

FRONTEND_ORIGIN=http://localhost:5173

RESEND_API_KEY=your_resend_api_key
EMAIL_FROM=your_verified_sender_address

MAX_FILE_SIZE_MB=5
```

Replace the placeholder values with your actual configuration. Use a sender address permitted by your email provider.

If the backend requires a separate ML service URL, configure it using the environment variable expected by your current ML integration code.

**Security:** Never commit `.env` files, database credentials, JWT secrets, or API keys to GitHub.

### 4. Start the Backend

From the `backend` directory, run:

```bash
npm start
```

If the project does not define a start script, run:

```bash
node server.js
```

The backend uses the configured port, or port `5000` by default.

### 5. Set Up the Frontend

Open another terminal and navigate to the directory containing the React/Vite application's `package.json`.

Install dependencies:

```bash
npm install
```

Configure the frontend API base URL to point to the backend:

```text
https://ecosort-ai-u1ln.onrender.com
```

For local development, use your local backend URL instead.

Start the frontend:

```bash
npm run dev
```

Vite will display the local URL, usually `http://localhost:5173`.

## 📡 API Endpoints

Base URL:

```text
https://ecosort-ai-u1ln.onrender.com
```

### General

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/health` | Check backend status |
| GET | `/api/categories` | Retrieve available waste categories |

### Authentication

| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/auth/register` | Register a new user |
| POST | `/api/auth/verify-otp` | Verify the email OTP |
| POST | `/api/auth/login` | Authenticate a user |
| POST | `/api/auth/refresh` | Obtain a refreshed access token |
| POST | `/api/auth/logout` | Log out a user |
| GET | `/api/auth/me` | Retrieve the authenticated user's details |

### Waste Classification

| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/classify` | Classify an uploaded waste image |

The classification endpoint requires authentication and accepts a multipart form-data upload with the field name `image`.

### Example: Health Check

Request:

```http
GET /api/health
```

Example response:

```json
{
  "success": true,
  "message": "EcoSort AI backend is running"
}
```

### Example: Classification Request

Request:

```http
POST /api/classify
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: multipart/form-data
```

Form data:

```text
image: <your-image-file>
```

The exact classification response fields depend on the current backend and ML service implementation.

## 🧪 Testing

You can test the backend using Postman or another API client.

1. Check `GET /api/health`.
2. Retrieve supported categories using `GET /api/categories`.
3. Register a user using `POST /api/auth/register`.
4. Verify the email using the OTP endpoint.
5. Log in and obtain an access token.
6. Send an authenticated image upload to `POST /api/classify`.
7. Test invalid uploads, unsupported images, low-confidence predictions, and ML service failures.

## 🔐 Security and Error Handling

The backend includes security measures such as:

- Password hashing with bcryptjs.
- JWT-based authentication.
- Email OTP verification.
- Protected classification endpoints.
- HTTP security headers using Helmet.
- CORS configuration.
- Image upload size and file-count limits.
- Rate limiting for classification requests.
- Error handling for invalid uploads and internal failures.

Never expose private credentials in frontend code or public repositories.

## ⚠️ Limitations

- Predictions depend on the accuracy and supported classes of the trained ML model.
- Mixed-material or multi-object images may produce uncertain or incomplete classifications.
- Poor lighting, unusual angles, cluttered backgrounds, and visually similar materials can affect predictions.
- Recycling rules vary by location, so disposal recommendations should be adapted to local waste-management guidelines.
- The system should communicate uncertainty instead of presenting every prediction as guaranteed.

## 🔮 Future Improvements

- Support detection of multiple waste objects in a single image.
- Add scan history and previous-result access.
- Improve classification confidence handling.
- Expand supported waste categories.
- Provide location-specific disposal guidance.
- Add analytics to understand classification patterns and usage.
- Improve accessibility and mobile usability.

These are proposed improvements and should not be considered implemented unless they are available in the current codebase.

## 👥 Team Contributions

EcoSort AI is a collaborative project with separate responsibilities for backend development, machine learning, frontend development, application development, and UI/UX design.

- **Backend:** APIs, authentication, database integration, validation, and ML service integration.
- **Machine Learning:** Dataset preparation, model training, image classification, and prediction output.
- **Frontend:** User interface and communication with the backend APIs.
- **Application Development:** Application integration and user-facing functionality.
- **UI/UX Design:** User experience, interface design, and usability.

## 📄 License

Choose and add an appropriate open-source license before distributing the project under one. Until then, no specific license is declared here.
