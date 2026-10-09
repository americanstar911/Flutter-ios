# Lab 4 — Interactive profile card

Follow/Following changes the follower count. Like and Dislike change the like count by one. Reset restores the initial values. State is updated with `setState()`.

## Run on macOS

From the repository root (the `Tasks ` directory has a trailing space):

```sh
cd "Tasks /LW4"
flutter pub get
flutter run -d macos
```

## Run in the iOS Simulator

```sh
open -a Simulator
flutter devices
flutter run -d <SIMULATOR_DEVICE_ID>
```

Use the simulator ID listed by `flutter devices`. With Xcode 27, the simulator app is called DeviceHub. If no iOS runtime is installed, install it through Xcode Settings → Components.

## Check the project

```sh
flutter analyze
flutter test
```

The widget test checks Follow/Following, Like, Dislike and Reset at a 375-pixel screen width. Build outputs, local SDK paths, IDE files and nested Git metadata are excluded from version control. Flutter includes its own Dart SDK; the version required by `pubspec.yaml` must be available.
