import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class ChannelMessageCopyRequest extends WsRequest {
  ChannelMessageCopyRequest({
    required BaseMessage message,
    required BaseChannel channel,
    OnMessageCallback? onCompleted,
  }) : super();

  /// Copies [message] to [targetChannel].
  ///
  /// It returns either [UserMessage] or [FileMessage] with
  /// [MessageSendingStatus.pending] and [onCompleted] will be invoked once the
  /// message has been sent completely. Channel event
  /// [ChannelEventHandler.onMessageReceived] will be invoked on all
  /// other members' end.
// BaseMessage copyMessage(
//   BaseMessage message,
//   BaseChannel targetChannel, {
//   OnMessageCallback? onCompleted,
// }) {
//   if (message.channelUrl != channelUrl) {
//     throw InvalidParameterError();
//   }

//   if (message is UserMessage) {
//     final params = UserMessageParams.withMessage(message, deepCopy: false);
//     return targetChannel.sendUserMessage(
//       params,
//       onCompleted: onCompleted,
//     );
//   } else if (message is FileMessage) {
//     final params = FileMessageParams.withMessage(message, deepCopy: false);
//     return targetChannel.sendFileMessage(
//       params,
//       onCompleted: onCompleted,
//     );
//   } else {
//     throw InvalidParameterError();
//   }
// }
}
