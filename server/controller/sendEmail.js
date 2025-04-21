const nodemailer = require("nodemailer");
require("dotenv").config();
const View = require("../models/View");


const transporter = nodemailer.createTransport({
  host: process.env.EMAIL_HOST,
  port: process.env.EMAIL_PORT,
  //secure: process.env.EMAIL_SECURE === "true", // true for 465, false for other ports
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

const sendEmail = async (recipientName, userAgent, ip) => {
    try{
       // Find the email associated with this recipient
       const viewData = await View.findOne({ recipient: recipientName });
       if (!viewData || !viewData.email) {
         console.log("No view data or Email found for recipient:", recipientName);
         return;
       }

       const mailOptions = {
         from: {
           name: "Smart Resume Tracker",
           address: process.env.SENDER_EMAIL,
         },
         to: viewData.email,
         subject: 'Your Resume Was Viewed!',
         html: `
         <h2>Your resume was just viewed!</h2>
         <p>Hello ${viewData.email},</p>
         <p>Your resume was viewed with the following details:</p>
         <ul>
             <li>Time: ${new Date().toLocaleString()}</li>
             <li>Browser: ${userAgent}</li>
             <li>IP Address: ${ip}</li>
         </ul>
         <p>Best regards,<br>Smart Resume Tracker</p>
         `
       };

       await transporter.sendMail(mailOptions);
       console.log('View notification email sent to:', viewData.email);

    }catch(error){
        console.log('Error sending email:', error.message);
    }
}

module.exports = sendEmail;


