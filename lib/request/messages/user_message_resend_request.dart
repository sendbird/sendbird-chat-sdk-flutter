import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class ChannelUserMessageResendRequest extends WsRequest {
  @override
  final cmd = CommandString.userMessage;

  ChannelUserMessageResendRequest(
    UserMessage message, {
    OnUserMessageCallback? onCompleted,
  }) : super();

  /// Resends failed [UserMessage] on this channel with [message].
  ///
  /// It returns [UserMessage] with [MessageSendingStatus.pending] and
  /// [onCompleted] will be invoked once the message has been sent completely.
  /// Channel event [ChannelEventHandler.onMessageReceived] will be invoked
  /// on all other members' end.
// UserMessage resendUserMessage(
//   UserMessage message, {
//   OnUserMessageCallback? onCompleted,
// }) {
//   if (message.sendingStatus != MessageSendingStatus.failed) {
//     throw InvalidParameterError();
//   }
//   if (message.channelUrl != channelUrl) {
//     throw InvalidParameterError();
//   }
//   if (!message.isResendable()) {
//     throw InvalidParameterError();
//   }

//   final params = UserMessageParams.withMessage(message, deepCopy: false);
//   return sendUserMessage(
//     params,
//     onCompleted: onCompleted,
//   );
// }
}
