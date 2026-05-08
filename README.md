# GhostStrings iOS Showcase 👻📱

This project demonstrates the powerful "Zero-Code" integration of the GhostStrings SDK on iOS using Swift Package Manager.

## 🚀 Features
- **Zero-Code Change**: Uses standard `NSLocalizedString` and `Text("...")`.
- **SwiftUI Support**: Seamless integration with SwiftUI for reactive updates.
- **Automatic Refresh**: UI updates instantly when cloud strings are fetched.

## 🛠️ How to Run

1. Open `GhostStringsShowcase.xcodeproj` in Xcode.
2. Xcode will automatically resolve the GhostStrings SDK via Swift Package Manager.
3. Select any iOS Simulator.
4. Hit **Run** (Cmd + R).

## 🧪 Testing the OTA Effect

1. Open the app on your simulator.
2. Go to your [GhostStrings Dashboard](https://ghoststrings.ai).
3. Select your project and edit any string value (e.g., `hero_title`).
4. Click Save.
5. Re-launch the app (or trigger a sync) and watch the text update instantly without an App Store update! 🪄

## 📦 Integration Details
This demo application relies on the public [GhostStrings iOS SDK Repository](https://github.com/shahwaiz90/ghoststrings-ios) which distributes the pre-compiled XCFramework.
