import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class ChannelFileMessageResendRequest extends WsRequest {
  @override
  final cmd = CommandString.fileMessage;

  ChannelFileMessageResendRequest(
    message, {
    required FileMessageParams params,
    OnFileMessageCallback? onCompleted,
    OnUploadProgressCallback? progress,
  }) : super();
}
