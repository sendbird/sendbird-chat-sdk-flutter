# Sendbird Chat SDK for flutter

## Getting started

### Add dependency
Add this to your package's pubspec.yaml file, use the latest version

```yaml
dependencies:
  hosted:
    name: sendbirdsdk
    url: https://dl.cloudsmith.io/public/sendbird/sendbird-sdk-flutter/dart/
    version: ^3.0.0
```

You should then run `flutter pub get`

## Example Project

There is a detailed [Flutter example](https://github.com/sendbird/Sendbird-Flutter). You can directly run and play on it. 

## Setup SDK

You first need to initantiate sendbird class with your application id. SendbirdSdk class is singleton but create it once and re-use it across your application.

```dart
import 'package:sendbirdsdk/sendbirdsdk.dart';
final sdk = SendbirdSdk(appId: "app-id");
```

## Connect to the Sendbird Server

Once you initiated `SendbirdSdk` with application id, connect to the Sendbird server

```dart
try {
  final user = await sdk.connect(userId: 'john');
}
```
### Changelog

Check out the [changelog](https://raw.githubusercontent.com/sendbird/sendbird-sdk-flutter/master/CHANGELOG.md) to see the latest changes in the package.