import 'package:sendbird_sdk/sendbird_sdk.dart';

void main(List<String> arguments) async {
  // create sendbird sdk instance with application id
  final sendbird = SendbirdSdk(appId: 'YOUR-APP-ID');

  try {
    // connect sendbird server with user id
    final user = await sendbird.connect('UNIQUE-USER-ID');

    // generate group channel parameters
    final params = GroupChannelParams()
      ..userIds = [user.userId]
      ..operatorUserIds = [user.userId]
      ..name = 'YOUR_GROUP_NAME'
      ..customType = 'CUSTOM_TYPE'
      ..isPublic = true;

    // create group channel
    final channel = await GroupChannel.createChannel(params);

    // send user message to the group channel
    channel.sendUserMessageWithText('Hello World',
        onCompleted: (message, error) {
      // message has been sent successfully
      print('${message.message} has been sent!');
    });
  } catch (e) {
    // handle error
  }
}
