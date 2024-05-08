# bengkelly_apps

<img src="https://github.com/techthinkhub/bengkelly_apps/assets/45384894/a32bc61a-2735-42ca-973b-a57469e6d2a5" alt="login" width="200" height="300">
<img src="https://github.com/techthinkhub/bengkelly_apps/assets/45384894/6d819b86-dd82-44af-9f39-5d5787da7afd" alt="home" width="200" height="300">
<img src="https://github.com/techthinkhub/bengkelly_apps/assets/45384894/f72585d7-2c5e-4fff-b7e6-a2eaeb0ee020" alt="detail" width="200" height="300">

Bengkelly application for customers:

package: `com.bengkelly.customer.co.id`
Flutter `v3.7.7 • channel stable` • [https://github.com/flutter/flutter.git](https://github.com/flutter/flutter.git)
Dart `• version 2.19.4`
Android Studio `• version Android Studio Hedgehog | 2023.1.1 Patch 1`

## ATTACHMENT REQUIRED

`Need to implement PROGUARD on this project for the next release or update.`

## How to Run

- Clone this repository
- Change into root directory
- `flutter packages get` (get packages)
- `flutter run` (I assume your system is Flutter-ready)

## Versioning

When you want to update release version, please do the following:

- Edit `version` in file ./pubspec.yaml, set the value as combination of `flutterVersionName`, `+`,
  and `flutterVersionCode` e.g. `1.2.0+2`
- Run `flutter build appbundle` to build app bundle

Please [see here](https://stackoverflow.com/questions/53570575/flutter-upgrade-the-version-code-for-play-store/55443605)
for details about versioning.
Please [see here](https://flutter.dev/docs/deployment/android) for details about Android deployment.

## Build Apk Release or Debug

- `flutter build apk --split-per-abi`
- `flutter build apk --debug`

## Make Branch

- `git branch checkout -b <branch_name>`