import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/params/base_message_fetch_params.dart';

part 'message_change_logs_params.g.dart';

/// An object consists a set of parameters to retrieve message's change log
@JsonSerializable()
class MessageChangeLogParams extends BaseMessageFetchParams {}
