# Smart Resume Tracker Mobile App

A Flutter mobile application for the Smart Resume Tracker project. This app allows users to upload resumes, generate tracking links, and view analytics for resume views.

## Features

- Upload PDF resumes and generate tracking links
- Copy and share tracking links directly from the app
- View detailed analytics including view counts and timestamps
- Receive notifications when your resume is viewed (via email)
- User-friendly interface with Material Design

## Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (2.10.0 or higher)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter extensions
- [Git](https://git-scm.com/)
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/Resume-Tracker.git
cd Resume-Tracker/Mobile\ App
```

### 2. Set Up Environment Variables

Copy the example environment file and update it with your configuration:

```bash
cp .env.example .env
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

#### For Development

```bash
# Run in debug mode
flutter run

# Specify a device if you have multiple connected
flutter run -d <device_id>
```

To get a list of available devices:
```bash
flutter devices
```

## Building for Production

### Android

1. Generate a keystore file (if you don't have one):
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. Create a `key.properties` file in the `android` folder:
   ```
   storePassword=<password from previous step>
   keyPassword=<password from previous step>
   keyAlias=upload
   storeFile=<location of the key store file, e.g., /Users/username/upload-keystore.jks>
   ```

3. Build the APK:
   ```bash
   flutter build apk --release
   ```
   The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`

4. Build App Bundle (for Google Play Store):
   ```bash
   flutter build appbundle --release
   ```
   The bundle will be available at `build/app/outputs/bundle/release/app-release.aab`

### iOS (macOS only)

1. Open the iOS project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. Configure signing in Xcode under the "Signing & Capabilities" tab

3. Build the app:
   ```bash
   flutter build ios --release
   ```

4. Archive the app in Xcode for App Store submission

## Deployment

### Google Play Store

1. Create a developer account on the [Google Play Console](https://play.google.com/console/signup)
2. Create a new application
3. Upload your signed AAB file
4. Fill in the store listing details
5. Set up pricing and distribution
6. Submit for review

### Apple App Store (iOS)

1. Create a developer account on [Apple Developer](https://developer.apple.com/)
2. Register your app identifier in the Apple Developer Console
3. Create a distribution certificate and provisioning profile
4. Archive your app in Xcode
5. Upload to App Store Connect
6. Fill in the store listing details
7. Submit for review

## Troubleshooting

### Common Issues

1. **Build Failures**
   - Ensure you have the latest Flutter SDK: `flutter upgrade`
   - Clean the build: `flutter clean` then `flutter pub get`

2. **Permission Issues**
   - Make sure the app has proper permissions in the AndroidManifest.xml file
   - For iOS, check the Info.plist file for required permissions

3. **API Connection Issues**
   - Verify the backend URL in the .env file
   - Check if the backend server is running and accessible

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
