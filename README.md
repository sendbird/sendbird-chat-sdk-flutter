# [Sendbird](https://sendbird.com) Chat SDK for Flutter

[![Platform](https://img.shields.io/badge/platform-flutter-blue)](https://flutter.dev/)
[![Language](https://img.shields.io/badge/language-dart-blue)](https://dart.dev/)

## Table of contents

1. [Introduction](#introduction)
2. [Requirements](#requirements)
3. [Getting started](#getting-started)
4. [Sending your first message](#sending-your-first-message)
5. [Hiring](#we-are-hiring)

## Introduction

The Sendbird Chat SDK for Flutter allows you to add real-time chat into your client app with minimal effort. Sendbird offers a feature rich, scalable, and proven chat solution depended on by companies like Reddit, Hinge, PubG and Paytm.

### How it works

The Chat SDK provides the full functionality to provide a rich chat experience, implementing it begins by adding a user login, listing the available channels, selecting or creating an `open channel` or `group channel`, and receive messages and other events through `channel event handlers` and the ability to send a message. Once this basic functionality is in place, congratulations, you now have a chat app!

Once this is in place, take a look at [all the other features](https://sendbird.com/products/chat-messaging/features) that Sendbird supports and add what works best for your users.

### Documentation

Find out more about Sendbird Chat for Flutter on [the documentation](https://st.sendbird.com/docs/chat/v4/flutter/overview). If you have any comments, questions or feature requests, let us know in the [Sendbird community](https://community.sendbird.com).

## Requirements

The minimum requirements for the Chat SDK for Flutter are:
- Dart 2.19.0 or later
- Flutter 3.7.0 or later

> **Note**: Sendbird server supports Transport Layer Security (TLS) from version 1.0 up to 1.3. For example, in the server regions where TLS 1.3 isn’t available, lower versions, sequentially from 1.2 to 1.0, will be supported for secure data transmission.

## Getting started

The quickest way to get started is by using one of the sample apps from the [samples repo](https://github.com/sendbird/sendbird-chat-sample-flutter), create an application in the [Sendbird Dashboard](https://dashboard.sendbird.com) and copy the App ID to the sample app and you’re ready to go.

### Step 1: Create a Sendbird application from your dashboard

Before installing Sendbird Chat SDK, you need to create a Sendbird application on the [Sendbird Dashboard](https://dashboard.sendbird.com). You will need the App ID of your Sendbird application when initializing the Chat SDK.

> **Note**: Each Sendbird application can be integrated with a single client app. Within the same application, users can communicate with each other across all platforms, whether they are on mobile devices or on the web.

### Step 2: Install packages
- Add following dependency in `pubspec.yaml`.

```yaml
dependencies:
  sendbird_chat_sdk: ^4.2.7
```

- Run `flutter pub get` command in your project directory.

### Step 3: Use the Chat SDK in Flutter

You can use all classes and methods just with the one import statement as shown below.

```dart
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
```

## Sending your first message

Now that the Chat SDK has been imported, we're ready to start sending a message.

### Authentication

In order to use the features of Sendbird Chat SDK for Flutter, you should initiate the `SendbirdChat` instance through user authentication with Sendbird server. This instance communicates and interacts with the server based on an authenticated user account, allowing the client app to use the Chat SDK's features.

Here are the steps to sending your first message using the Chat SDK:

### Step 1: Initialize the Chat SDK

Now, initialize the Chat SDK in the app to allow the SDK to respond to changes in the connection status of Flutter client apps. Initialization requires your Sendbird application's Application ID, which can be found on [Sendbird Dashboard](https://dashboard.sendbird.com).

```dart
SendbirdChat.init(appId: 'APP_ID');
```

### Step 2: Connect to Sendbird server

You need a user in order to send a message to a channel. You can either create a user on our dashboard or you can use a unique ID that hasn't been taken by any of your Sendbird application users. In the latter case, a new user is automatically created in your Sendbird application before being connected.

```dart
final user = await SendbirdChat.connect('USER_ID');
```

### Step 3: Create a new open channel

Create an open channel using the following code. Open channels are where all users in your Sendbird application can easily participate without an invitation. When creating an open channel, you should pass the `OpenChannelCreateParams` class as a parameter.

```dart
final openChannel = await OpenChannel.createChannel(OpenChannelCreateParams());
```

### Step 4: Enter the channel

Enter the open channel to send and receive messages.

```dart
final openChannel = await OpenChannel.getChannel('CHANNEL_URL');
await openChannel.enter();
```

### Step 5: Send a message to the channel

Finally, send a message to the channel. To learn more about the types of messages you can send, see the message page.

```dart
final message = openChannel.sendUserMessage(UserMessageCreateParams(message: 'MESSAGE'));
```

### Step 6: Receive a message

Add the `onMessageReceived()` channel event handler using the addChannelHandler() method so that you can receive the message you just sent to the channel. You can also see the message on the dashboard.

```dart
class MyOpenChannelHandler extends OpenChannelHandler {
  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    // Received a new message.
  }
}

SendbirdChat.addChannelHandler('UNIQUE_HANDLER_ID', MyOpenChannelHandler());
```

## We are hiring

At Sendbird, we are a diverse group of humble, friendly, and hardworking individuals united by a shared purpose to build the next generation of mobile & social technologies, across chat, voice, and video, that are changing the way we work and live. We're always looking for great people to join our team. [Check out our careers page](https://sendbird.com/careers) for more information.