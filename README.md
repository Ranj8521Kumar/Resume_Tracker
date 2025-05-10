# Smart Resume Tracker

Track resume views effortlessly. Know who saw it, when they saw it — no accounts, just answers.

## Overview

Smart Resume Tracker is a Chrome extension and web application that allows you to track when your resume is viewed by potential employers. Simply upload your resume, generate a tracking link, and share it with recruiters or in job applications. The system will notify you by email when your resume is viewed and provide details about the viewer.

## Features

- **Easy Resume Upload**: Upload your resume (PDF) and generate a unique tracking link
- **Real-time Tracking**: Monitor when your resume is viewed
- **Email Notifications**: Receive email alerts when someone views your resume
- **Detailed Analytics**: See first view, last view, and total view count for each recipient
- **Dashboard**: View all tracking data in one place
- **No Recipient Account Required**: Recipients don't need to create accounts to view your resume

## Live Demo

The application is deployed and available at:
- Backend API: https://my-resume-32bl.onrender.com
- Dashboard: https://my-resume-32bl.onrender.com/dashboard.html

## Technologies Used

### Frontend
- **HTML/CSS/JavaScript**: Core web technologies for building the user interface
- **Chrome Extension API**: For creating the browser extension functionality
- **Clipboard API**: For automatically copying tracking links
- **Flutter**: Cross-platform UI toolkit for building the mobile application
- **Dart**: Programming language used with Flutter

### Backend
- **Node.js**: JavaScript runtime environment for server-side code
- **Express.js**: Web application framework for handling HTTP requests
- **MongoDB**: NoSQL database for storing tracking data
- **Mongoose**: MongoDB object modeling for Node.js
- **Multer**: Middleware for handling file uploads (PDF resumes)
- **Nodemailer**: Module for sending email notifications
- **Cors**: Middleware for enabling Cross-Origin Resource Sharing

### DevOps & Tools
- **dotenv**: For managing environment variables
- **SMTP Email Service**: For sending email notifications
- **MongoDB Atlas**: Cloud database service for MongoDB
- **Nodemon**: Utility for automatically restarting the server during development
- **Render**: Cloud platform for hosting the backend service
- **Android Studio**: IDE for Android app development

## Project Structure

```
Resume-Tracker/
├── client/                  # Chrome extension files
│   ├── popup.html           # Extension popup interface
│   ├── popup.js             # Extension functionality
│   ├── style.css            # Extension styling
│   ├── manifest.json        # Extension configuration
│   └── icon.jpeg            # Extension icon
│
├── Mobile App/              # Flutter mobile application
│   ├── lib/                 # Flutter source code
│   │   ├── main.dart        # App entry point
│   │   ├── screens/         # App screens
│   │   └── services/        # API services
│   ├── android/             # Android-specific configuration
│   ├── pubspec.yaml         # Flutter dependencies
│   └── README.md            # Mobile app documentation
│
├── server/                  # Backend server
│   ├── controller/          # Controller logic
│   │   └── sendEmail.js     # Email notification controller
│   ├── models/              # Database models
│   │   └── View.js          # View tracking model
│   ├── routes/              # API routes
│   │   └── track.js         # Tracking routes
│   ├── public/              # Static files
│   │   └── resumes/         # Uploaded resumes
│   ├── server.js            # Main server file
│   └── package.json         # Server dependencies
│
├── package.json             # Root dependencies
└── README.md                # Project documentation
```

## Installation

### Prerequisites
- Node.js (v14 or higher)
- MongoDB account
- Chrome browser (for extension)
- SMTP email service (for notifications)

### Server Setup

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/Resume-Tracker.git
   cd Resume-Tracker
   ```

2. Install dependencies:
   ```
   npm install
   cd server
   npm install
   ```

3. Create a `.env` file in the server directory with your configuration:
   ```
   MONGO_URI="your_mongodb_connection_string"
   EMAIL_HOST="your_smtp_host"
   EMAIL_PORT=your_smtp_port
   EMAIL_USER="your_smtp_username"
   EMAIL_PASS="your_smtp_password"
   SENDER_EMAIL="your_sender_email"
   PORT=5000
   ```

4. Start the server:
   ```
   cd server
   npx nodemon server.js
   ```

### Chrome Extension Setup

1. Open Chrome and navigate to `chrome://extensions/`
2. Enable "Developer mode" (toggle in the top-right corner)
3. Click "Load unpacked" and select the `client` folder from the project
4. The extension should now appear in your Chrome toolbar

### Mobile App Setup

1. Make sure you have Flutter installed (see [Flutter installation guide](https://flutter.dev/docs/get-started/install))
2. Navigate to the Mobile App directory:
   ```
   cd "Mobile App"
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Create a `.env` file from the example:
   ```
   ```
5. Run the app:
   ```
   flutter run
   ```

For detailed instructions on building and deploying the mobile app, see the [Mobile App README](Mobile%20App/README.md).

## Usage

### Uploading and Tracking a Resume

#### Using Chrome Extension
1. Click on the Smart Resume Tracker extension icon in your Chrome toolbar
2. Enter the recipient's name (e.g., company or recruiter name)
3. Enter your email address to receive notifications
4. Upload your resume (PDF format)
5. Click "Generate Link"
6. The tracking link will be automatically copied to your clipboard
7. Share this link with the recipient

#### Using Mobile App
1. Open the Smart Resume Tracker mobile app
2. Tap on "Upload Resume" on the home screen
3. Enter the recipient's name and your email address
4. Select your resume PDF file
5. Tap "Generate Tracking Link"
6. Use the "Copy Link" button to copy the link or "Open Link" to preview it
7. Share the link with the recipient

### Receiving Notifications

When someone views your resume:
1. You'll receive an email notification with details about the viewer
2. The notification includes the time of view, browser information, and IP address

### Viewing Analytics

#### Using Chrome Extension
1. Click on the Smart Resume Tracker extension icon
2. Click "Go to Dashboard"
3. View detailed analytics for all your resume links

#### Using Mobile App
1. Open the Smart Resume Tracker mobile app
2. Tap on "View Dashboard" on the home screen
3. View detailed analytics including view counts and timestamps for all your resume links

## Deployment

### Backend Deployment

The backend is deployed on Render.com. To deploy your own instance:

1. Create a new Web Service on Render
2. Connect your GitHub repository
3. Set the build command: `npm install && cd server && npm install`
4. Set the start command: `cd server && node server.js`
5. Add all environment variables from your `.env` file
6. Deploy the service

### Chrome Extension Deployment

To publish the Chrome extension to the Chrome Web Store:

1. Create a ZIP file of the `client` directory
2. Create a developer account on the [Chrome Web Store](https://chrome.google.com/webstore/devconsole/)
3. Pay the one-time developer fee
4. Create a new item and upload the ZIP file
5. Fill in the store listing information
6. Submit for review

### Mobile App Deployment

#### Android

1. Build a release APK or App Bundle:
   ```
   cd "Mobile App"
   flutter build apk --release
   # OR
   flutter build appbundle --release
   ```

2. Publish to Google Play Store:
   - Create a developer account on the [Google Play Console](https://play.google.com/console/signup)
   - Create a new application
   - Upload your signed APK or AAB file
   - Fill in the store listing details
   - Set up pricing and distribution
   - Submit for review

For detailed instructions on mobile app deployment, see the [Mobile App README](Mobile%20App/README.md).

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
