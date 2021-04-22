import 'package:sendbird_sdk/sendbird_sdk.dart';

void main(List<String> arguments) async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview

  final sendbird = SendbirdSdk(appId: 'YOUR-APP-ID');

  try {
    final user = await sendbird.connect('UNIQUE-USER-ID');
    final params = GroupChannelParams()
      ..userIds = [user.userId]
      ..operatorUserIds = [user.userId]
      ..name = 'YOUR_GROUP_NAME'
      ..customType = 'CUSTOM_TYPE'
      ..isPublic = true;

    // create group channel
    final channel = await GroupChannel.createChannel(params);

    channel.sendUserMessageWithText('Hello World',
        onCompleted: (message, error) {
      // message has been sent successfully
      print('${message.message} has been sent!');
    });
  } catch (e) {
    // handle error
  }
}
