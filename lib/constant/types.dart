import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/message/file_message.dart';
import 'package:sendbird_sdk/core/message/user_message.dart';
import 'package:sendbird_sdk/events/poll_vote_event.dart';
import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/features/poll/poll_option.dart';

typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);
typedef OnMessageCallback = void Function(BaseMessage message, Error? error);
typedef OnFileMessageCallback = void Function(
    FileMessage message, Error? error);
typedef OnUserMessageCallback = void Function(
    UserMessage message, Error? error);
typedef OnScheduledMessageCallback<T> = void Function(T? message, Error? error);
typedef OnTotalScheduledMessageCountCallback = void Function(
    int? totalCount, Error? error);
typedef OnScheduledMessageCancelCallback = void Function(Error? error);
typedef OnScheduledMessageSendNowCallback = void Function(Error? error);
typedef OnPollCallback = void Function(Poll? poll, Error? error);
typedef OnPollVoteEventCallback = void Function(
    PollVoteEvent? poll, Error? error);
typedef OnPollOptionCallback = void Function(
    PollOption? pollOption, Error? error);
typedef OnCompleteCallback = void Function(bool? isCompleted, Error? error);
