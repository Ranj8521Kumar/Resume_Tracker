# Smart Resume Tracker

Track resume views effortlessly. Know who saw it, when they saw it — no accounts, just answers.

## Overview

Smart Resume Tracker is a Chrome extension and web application that allows you to track when your resume is viewed by potential employers. Simply upload your resume, generate a tracking link, and share it with recruiters or in job applications. The dashboard provides insights into who viewed your resume and when.

## Features

- **Easy Resume Upload**: Upload your resume (PDF) and generate a unique tracking link
- **Real-time Tracking**: Monitor when your resume is viewed
- **Detailed Analytics**: See first view, last view, and total view count for each recipient
- **Dashboard**: View all tracking data in one place
- **Export Data**: Download tracking data as CSV
- **No Recipient Account Required**: Recipients don't need to create accounts to view your resume

## Technologies Used

### Frontend
- HTML/CSS/JavaScript
- Chrome Extension API

### Backend
- Node.js
- Express.js
- MongoDB (with Mongoose)
- Multer (for file uploads)
- Nodemailer (for notifications)

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
├── server/                  # Backend server
│   ├── models/              # Database models
│   │   └── View.js          # View tracking model
│   ├── routes/              # API routes
│   │   └── track.js         # Tracking routes
│   ├── public/              # Static files
│   │   ├── dashboard.html   # Dashboard interface
│   │   └── resumes/         # Uploaded resumes
│   ├── server.js            # Main server file
│   └── .env                 # Environment variables
│
└── README.md                # Project documentation
```

## Installation

### Prerequisites
- Node.js (v14 or higher)
- MongoDB account
- Chrome browser (for extension)

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

3. Create a `.env` file in the server directory with your MongoDB connection string:
   ```
   MONGO_URI="your_mongodb_connection_string"
   ```

4. Start the server:
   ```
   cd server
   npx nodemon server.js
   ```
   The server will run on http://localhost:5000

### Chrome Extension Setup

1. Open Chrome and navigate to `chrome://extensions/`
2. Enable "Developer mode" (toggle in the top-right corner)
3. Click "Load unpacked" and select the `client` folder from the project
4. The extension should now appear in your Chrome toolbar

## Usage

### Uploading and Tracking a Resume

1. Click on the Smart Resume Tracker extension icon in your Chrome toolbar
2. Enter the recipient's name (e.g., company or recruiter name)
3. Upload your resume (PDF format)
4. Click "Generate Link"
5. The tracking link will be automatically copied to your clipboard
6. Share this link with the recipient

### Viewing Analytics

1. Click on the Smart Resume Tracker extension icon
2. Click "Go to Dashboard"
3. View detailed analytics for all your resume links
4. Download data as CSV using the "Download CSV" button

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
