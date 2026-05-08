# GhostStrings Showcase 👻🎬

This project demonstrates the powerful "Zero-Code" integration of GhostStrings across Android and iOS.

## 📱 iOS Showcase (SwiftUI)
- Uses standard `NSLocalizedString`.
- Features `GhostStringsKeys.swift` for clean key management.
- Implements `GhostStringsProvider` for instant UI updates.
- **To Run**: Open `GhostStringsShowcase.xcodeproj` in Xcode and run on any simulator.

## 🤖 Android Showcase (Compose)
- Located in `/GhostStrings-Android/app`.
- Uses native `stringResource(R.string...)`.
- Demonstrates seamless background sync and refresh.
- **To Run**: Open the `/GhostStrings-Android` folder in Android Studio.

## 🧪 Testing the OTA Effect
1. Open the app on your simulator/device.
2. Go to the GhostStrings Dashboard (`/public/projectdetail.html`).
3. Find the key `hero_title`.
4. Change the text and click Save.
5. Watch the app UI update **instantly** without any interaction! 🪄

## 📦 SDK Versions Used
- Android SDK: `1.1.2`
- iOS SDK: `1.1.3`
