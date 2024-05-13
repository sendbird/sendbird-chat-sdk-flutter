# [Sendbird](https://sendbird.com) Chat SDK for Flutter

[![Platform](https://img.shields.io/badge/platform-flutter-blue)](https://flutter.dev/)
[![Language](https://img.shields.io/badge/language-dart-blue)](https://dart.dev/)

> **Warning**
> Sendbird Chat SDK v3 for Flutter is no longer supported as a new version is released. Check out our latest Chat SDK v4 [here](https://pub.dev/packages/sendbird_chat_sdk)

## Table of contents

1. [Introduction](#introduction)
1. [Requirements](#requirements)
1. [Getting started](#getting-started)
1. [Sending your first message](#sending-your-first-message)
1. [Getting help](#getting-help)
1. [Hiring](#we-are-hiring)

<br />

## 🔒 Security tip

When a new Sendbird application is created in the dashboard the default security settings are set permissive to simplify running samples and implementing your first code.

Before launching make sure to review the security tab under ⚙️ Settings -> Security, and set Access token permission to Read Only or Disabled so that unauthenticated users can not login as someone else. And review the Access Control lists. Most apps will want to disable "Allow retrieving user list" as that could expose usage numbers and other information.

## Introduction

Through Chat SDK for flutter, you can efficiently integrate real-time chat into your client app. On the client-side implementation, you can initialize, configure and build the chat with minimal effort. On the server-side, Sendbird ensures reliable infra-management services for your chat within the app. This **readme** provides essential information on the Chat SDK’s structure, supplementary features, and the installation steps.

### How it works

1. A user logs in
2. User sees a list of channels
3. Select or create an [open channel](https://sendbird.com/docs/chat/v3/flutter/guides/open-channel?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk) or a [group channel](https://sendbird.com/docs/chat/v3/flutter/guides/group-channel?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk)
4. Through the use of the [channel event handler](https://sendbird.com/docs/chat/v3/flutter/guides/event-handler?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk), sends and receives messages to other users in that channel.

<br />

## Requirements

The minimum requirements for Chat SDK for Flutter are:

- Xcode or Android studio
- Dart 2.18.0 or above
- Flutter 3.3.0 or higher

## Getting started

This section gives you information you need to get started with Sendbird Chat SDK for Flutter. Follow the simple steps below to build the Chat SDK into your client app.

### Try the sample app

The fastest way to test Sendbird Chat SDK for Flutter is to build your chat app on top of our sample app. To create a project for the sample app, download the app from our GitHub repository. The link is down below.

- https://github.com/sendbird/Sendbird-Flutter

### Step 1: Create a Sendbird application from your dashboard

A Sendbird application comprises everything required in a chat service including users, message, and channels. To create an application:

1. Go to the [Sendbird Dashboard](https://dashboard.sendbird.com/auth/signup?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk) and enter your email and password, and create a new account. You can also sign up with a Google account.
2. When prompted by the setup wizard, enter your organization information to manage Sendbird applications.
3. Lastly, when your dashboard home appears after completing setup, click **Create +** at the top-right corner.

Only one Sendbird application can be integrated per app for your service regardless of the platform. All users within your Sendbird application can communicate with each other across all platforms. This means that your iOS, Android, and web client app users can all send and receive messages with one another without any further setup.

> **Note**: All data is limited to the scope of a single application, and users in different Sendbird applications can't chat with one other.

### Step 2: Install packages

Installing the Chat SDK is a simple process if you’re familiar with using external packages or SDK’s in your projects. Follow the steps below via `pub`.

- Add following dependency in `pubspec.yaml`.

```yaml
dependencies:
  sendbird_sdk: ^3.2.20
```

- Run `flutter pub get` command in your project directory.

### Step 3: Use the Chat SDK in Flutter

You can use all classes and methods just with the one import statement as shown below.

```dart
import 'package:sendbird_sdk/sendbird_sdk.dart'
```

<br />

## Sending your first message

Follow the step-by-step instructions below to authenticate and send your first message.

### Authentication

In order to use the features of Sendbird Chat SDK for Flutter, you should initiate the `Sendbirdsdk` instance through user authentication with Sendbird server. This instance communicates and interacts with the server based on an authenticated user account, allowing the client app to use the Chat SDK's features.

Here are the steps to sending your first message using the Chat SDK:

### Step 1: Initialize the Chat SDK

Initializing the Chat SDK allows it to respond to the connection and state changes in your client app. Pass the `APP_ID` of your Sendbird application as an argument to the `appId` parameter in the constructor of `SendbirdSdk`. The constructor of `SendbirdSdk` creates an instance, thus should be called a single time across your client app. It is recommended that the code for initialization be implemented in the user login view.

```dart
final sendbird = SendbirdSdk(appId: APP_ID);
```

### Step 2: Connect to Sendbird server

A user can log in and connect a user to Sendbird server by using a unique user ID or with a user ID and an access token.

#### A. Using a unique user ID

To connect to Sendbird server, a user is required to log in with a unique ID. A new user can authenticate with any untaken user ID, which gets automatically registered to the Sendbird system. An existing ID can log in directly. The ID must be unique within a Sendbird application to be distinguished from others, such as a hashed email address or phone number in your service.

```dart
try {
  final user = await sendbird.connect(userId: USER_ID);
} catch (e) {
  // error
}
```

#### B. Using a unique user ID and an access token

By using Chat Platform API, you can [create a user](https://sendbird.com/docs/chat/v3/platform-api/guides/user#2-create-a-user) and issue a unique access token to each user, or [issue an access token](https://sendbird.com/docs/chat/v3/platform-api/guides/user#2-update-a-user?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk) for an existing user. Once an access token is issued, a user is required to provide the access token to log in to your Sendbird application.

1. Using the [Chat Platform API](https://sendbird.com/docs/chat/v3/platform-api/guides/user#2-create-a-user?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk), create a Sendbird user account with the information submitted when a user signs up or signs in to your service.
2. Save the user ID along with the issued access token to your securely managed persistent storage.
3. When a user attempts to log in to the application, load the user ID and access token from the storage, and then pass them to `connect()` method.
4. Periodically replacing the user's access token is recommended for account security.

```dart
try {
  final user = await sendbird.connect(userId: USER_ID, accessToken: ACCESS_TOKEN);
} catch (e) {
  // error
}
```

#### - Tips for secure user login

To manage user access to your Sendbird application, go to **Settings** > **Application** > **Security** > **Access token permission** setting on your Sendbird dashboard. You can change settings to prevent the users without an access token from logging in to your application or restrict their access to read and write messages.

For security reasons, you can also use a session token when a user logs in to Sendbird server instead of an access token. Learn more about [Access token vs. Session token](https://sendbird.com/docs/chat/v3/platform-api/guides/user#2-create-a-user-3-access-token-vs-session-token?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk) from the Chat Platform API guide.

### Step 3: Create a new open channel

Create an [open channel](https://sendbird.com/docs/chat/v3/flutter/guides/open-channel#2-create-a-channel?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk). Once created, all users in your Sendbird application can easily participate in the channel.

```dart
try {
  final channel = await OpenChannel.createChannel();
} catch (e) {
  // error
}
```

You can also create a [group channel](https://sendbird.com/docs/chat/v3/flutter/guides/group-channel#2-create-a-channel?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk) by [inviting users as new members](https://sendbird.com/docs/chat/v3/flutter/guides/group-channel#2-invite-users-as-members?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk) to the channel.

> Note: The majority of the methods used in the following steps are all asynchronous. This means, with asynchronous methods, your client app must receive a result via `await` or `then()` callbacks from Sendbird server through completion handlers before moving on to the next step.

### Step 4: Enter the channel

Enter the channel to send and receive messages.

```dart
try {
  final channel = await OpenChannel.getChannel(CHANNEL_URL);
  await channel.enter();
} catch (e) {
  // error
}
```

### Step 5: Send a message to the channel

Finally, send a message to the channel. There are three types of [messages](https://sendbird.com/docs/chat/v3/platform-api/guides/messages#-3-resource-representation?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk): a user message in a plain text, a file message in a binary file, such as an image or PDF, and an admin message in a plain text sent through the [dashboard](https://dashboard.sendbird.com/auth/signin?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk) or [Chat Platform API](https://sendbird.com/docs/chat/v3/platform-api/guides/messages#2-send-a-message?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk).

```dart
try {
  final params = UserMessageParams()
    ..message = MESSAGE
    ..data = DATA
    ..customType = CUSTOM_TYPE;

  final preMessage = openChannel.sendUserMessage(params, onCompleted:(message, error){
      if (error != null) {
        // error
      } else {
        // message is sent successfully
      }
  });
  // use preMessage to populate your chat messages early
} catch (e) {
  // error
}
```

## Getting Help

Check out the Official Sendbird [Flutter docs](https://sendbird.com/docs/chat/v3/flutter/quickstart/send-first-message?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk) and Sendbird's [Developer Portal](https://sendbird.com/developer?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk) for tutorials and videos. If you need any help in resolving any issues or have questions, visit our [community forums](https://community.sendbird.com?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk).

<br />

## We are Hiring!

Sendbird is made up of a diverse group of humble, friendly, and hardworking individuals united by a shared purpose to build the next generation of mobile & social technologies. Join our team remotely or at one of our locations in San Mateo, Seoul, New York, London, and Singapore. More information on a [careers page](https://sendbird.com/careers?&utm_source=github&utm_medium=referral&utm_campaign=repo&utm_content=sendbird-chat-flutter-sdk).
