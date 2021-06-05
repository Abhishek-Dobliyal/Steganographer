## Stegnographer

A responsive and material design inspired mobile app to implements Steganography.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Installation and Dependencies

- [Flutter SDK](https://flutter.dev/docs/get-started/install)

- Any IDE or Code Editor that supports Dart and Flutter plugins.

- [Android SDK Tools](https://developer.android.com/studio?gclsrc=ds&gclsrc=ds&gclid=CLvmq66NgfECFQXojgod9UoGaA) (If not using Android Studio).

- [Python](https://www.python.org/)

## Usage 

- Open up Terminal/CMD and type in:
```bash
[✓] Flutter (Channel stable, 2.2.1, on macOS 11.4 20F71 darwin-x64, locale
    en-GB)
[✓] Android toolchain - develop for Android devices (Android SDK version
    30.0.3)
[✗] Xcode - develop for iOS and macOS
    ✗ Xcode installation is incomplete; a full installation is necessary for
      iOS development.
      Download at: https://developer.apple.com/xcode/download/
      Or install Xcode via the App Store.
      Once installed, run:
        sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
        sudo xcodebuild -runFirstLaunch
    ✗ CocoaPods not installed.
        CocoaPods is used to retrieve the iOS and macOS platform side's plugin
        code that responds to your plugin usage on the Dart side.
        Without CocoaPods, plugins will not work on iOS or macOS.
        For more info, see https://flutter.dev/platform-plugins
      To install see
      https://guides.cocoapods.org/using/getting-started.html#installation for
      instructions.
[✗] Chrome - develop for the web (Cannot find Chrome executable at
    /Applications/Google Chrome.app/Contents/MacOS/Google Chrome)
    ! Cannot find Chrome. Try setting CHROME_EXECUTABLE to a Chrome executable.
[✓] Android Studio (version 4.2)
[✓] VS Code (version 1.56.2)
```
(Make sure that a tick mark appears in front of Flutter, Android Toolchain and Android Studio/ VS Code. XCode is meant for iOS development so it is optional)

- If everything is set up correctly then navigate to project's directory. Open up Terminal/CMD and type in:
```bash
flutter pub get
```
```bash
flutter run
```
- The above commands will install all the dependencies required by the app and Install the app on emulator/physical device. (whichever is available)

- Now navigate to the 'backend' directory and type in:
-
```bash
pip install -r requirements.txt
```
```bash
python app.py
```

- The above commands will install all the dependencies required by the backend and run a Flask server.

- Voila! Your app is ready to serve you.

## Note

- Kindly do not delete, rename or modify any file. (unless you know what you are doing)

- The Flask server can be deployed to hosting platforms so that the backend can be accessed over the internet.

- As of now the app only supports .PNG file format.
