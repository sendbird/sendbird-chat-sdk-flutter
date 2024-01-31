import 'dart:async';

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

void main() async {
  runZonedGuarded(() async {
    // Initialize the SendbirdChat SDK with your Application ID.
    await SendbirdChat.init(appId: 'APP-ID');

    // Connect to the Sendbird server with a User ID.
    await SendbirdChat.connect('USER-ID');

    // Create a new open channel.
    final openChannel =
        await OpenChannel.createChannel(OpenChannelCreateParams());

    // Enter the channel.
    await openChannel.enter();

    // Send a message to the channel.
    openChannel.sendUserMessage(UserMessageCreateParams(message: 'MESSAGE'));
  }, (e, s) {
    // Handle error.
  });
}
