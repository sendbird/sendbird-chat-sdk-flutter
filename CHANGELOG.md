## [3.2.20] - May 13, 2024

- Fixed bugs that the description in report api is not sent

## [3.2.19] - Oct 13, 2023

- Fixed the bug regarding WebSocket error handling

## [3.2.18] - Sep 18, 2023

- Fixed the bug regarding uploadSizeLimit

## [3.2.17] - Aug 14, 2023

- Fix issue with no named parameter for JsonKey

## [3.2.16] - Aug 10, 2023

- Resolve warning issues
- Fix issue with API Token missing
- Fix typo `allowMultipleVotes`
- Include device token caching

## [3.2.15] - July 7, 2023

- Fix issue with resendFileMessage()
- Fix issue with access code always false

## [3.2.14] - Jun 16, 2023

- Fix issue with MarkAsDirty Method
- Fix issue with retrieving public group channel list

## [3.2.13] - Jun 2, 2023

- Update Connectivity Plus to 4.0.1

## [3.2.12] - May 24, 2023

- Removed error thrown when refresh successful key

## [3.2.11] - May 1, 2023

- Fix issue with code generation dart g files
- `message_list_params` variable `showSubChannelMessagesOnly` JSON key updated
- Update documentation on `preMessage` of not recieving messageID when pending Message
- Update deprecated value `hashValues` to `Object.hash`

## [3.2.10] - Apr 17, 2023

- Fix issue with code generation dart g files

## [3.2.9] - Apr 13, 2023

- Improved stability
- Fix issue when Message `data` property is not String to return NULL
- Fix issue with Vote api request by changing request to websocket request

## [3.2.8] - Mar 20, 2023

# Pinned Message 📌

Pinned Message is released. You can now maintain a special set of messages (up to 10 per channel) that you want everyone in the channel to share. It can be anything from announcements, surveys, upcoming events, and any many more. Pin your messages and never miss them! Stay tuned for updates as we are rolling out more exciting features and see below for exact specifications👇

# Specification

_Pin when sending a message_

- UserMessageParams(bool isPinnedMessage = false)
  _Pin existing message_
- Future<void> GroupChannel.pinMessage(messageId: int)
  _Unpin a message_
- Future<void> GroupChannel.unpinMessage(messageId: int)
  _Pinned messages_
- BaseMessage? GroupChannel.lastPinnedMessage
- List<int>? GroupChannel.pinnedMessageIds

## [3.2.7] - Mar 13, 2023

- Copy `fileName` and `fileSize` when copyMessage for FileMessage
- Include `extendedMessage` for AdminMessage

## [3.2.6] - Feb 22, 2023

- Fix `mark_as_read_all` method not returning the `channel_urls`

## [3.2.5] - Feb 20, 2023

- Include param `shouldRemoveOperatorStatus` in GroupChannelLeaveRequest to remove operator status when leaving groupchannel

## [3.2.4] - Feb 20, 2023

- Improve speed for sending messages

## [3.2.3] - Jan 26, 2023

- Include `FileMessageParams.withFileBytes` to support sending file message with bytes for web

## [3.2.2] - Jan 19, 2023

- Include Pending Message Mention Property

## [3.2.1] - Jan 3, 2023

- Fix issue with uploading profile with file
- Fix issue with retrieving file messages with requireAuth
- Fix issue with scheduled message `channel_type`

## [3.2.1] - Jan 3, 2023

- Fix issue with uploading profile with file
- Fix issue with retrieving file messages with requireAuth
- Fix issue with scheduled message `channel_type`

## [3.2.0] - Dec 14, 2022

- Include Poll Feature
- Include Scheduled Message Feature
- Include Security Tips in ReadME

## Features

# Polls

**Polls** is released 🎉 Here’s where we think it will be mighty.

Collect feedback and customer satisfaction

Drive engagement by receiving participants in preferences

Run surveys and quiz shows

And many more!

# Scheduled messages

**Scheduled messages** is released. Here’s where we think it will be advantageous.

Let your users queue their messages for the future

Set helpful reminders and notifications to nudge certain actions

And many more!

Improvements
Please note that both Polls and Scheduled Messages are released as beta features. Thus specific parameters and properties may change to improve client’s overall experience.

Stay tuned for updates as we are rolling out more exciting features and see below for exact specifications

**Polls**
Create Poll

```
Poll.create({PollCreateParams params, OnPollCallback? onCompleted})
```

Read Poll

```
Poll.get({PollRetrievalParams params, OnPollCallback? onCompleted})
```

PollListQuery

```
PollListQuery({PollListQueryParams params})
```

UserMessage.poll

Update Poll

```
GroupChannel.updatePoll({int pollId, PollUpdateParams params, OnPollCallback? onCompleted})
```

Close Poll

```
GroupChannel.closePoll({ int pollId, OnPollCallback? onCompleted})
```

Delete Poll

```
GroupChannel.deletePoll({int pollId, OnCompleteCallback? onCompleted})
```

Others:

Poll

```
GroupChannel.getPollChangeLogsSinceTimestamp(int ts, PollChangeLogsParams params)
```

```
GroupChannel.getPollChangeLogsSinceToken(String? token, PollChangeLogsParams params)
```

PollData

**Poll Options**
Create Poll Option

```
GroupChannel.addPollOption({int pollId, String optionText, OnPollCallback? onCompleted})
```

Read Poll Option

```
PollOption.get(PollOptionRetrievalParams params, OnPollOptionCallback? onCompleted)
```

Poll Vote List

```
PollVoterListQuery(PollVoterListQueryParams params)
```

Update Poll Option

```
GroupChannel.updatePollOption({int pollId, int pollOptionId, String optionText, OnPollCallback? onCompleted})
```

Vote Poll

```
GroupChannel.votePoll({int pollId, List<int> pollOptionIds,OnPollCallback? onCompleted})
```

Delete Poll Option

```
GroupChannel.deletePollOption({int pollId, int pollOptionId, OnCompleteCallback? onCompleted})
```

Others:

PollOption

PollStatus

PollVoteEvent

PollUpdateEvent

ChannelEventHandler - void onPollUpdated(PollUpdateEvent event) {}

ChannelEventHandler - void onPollVoted(PollVoteEvent event) {}

ChannelEventHandler - void onPollDeleted(int pollId) {}

**Scheduled Messages**
Create Scheduled Messages

```
GroupChannel.createScheduledUserMessage()
GroupChannel.createScheduledFileMessage()
```

Read Scheduled Message

```
BaseMessage.getScheduledMessage()
```

ScheduledMessageListQuery

ScheduledMessageRetrievalParams

Update Scheduled Message

```
GroupChannel.updateScheduledUserMessage()
GroupChannel.updateScheduledFileMessage()
```

Delete Scheduled Message

```
GroupChannel.cancelScheduledMessage()
```

Others

ScheduledInfo

MessageSendingStatus.scheduled

BaseMessage.scheduledInfo

sdk.getTotalScheduledMessageCount()

TotalScheduledMessageCountParams

## [3.1.20] - Dec 6, 2022

- Fix `GroupChannelListRequest` for `channel_urls`
- Fix `OGMetaData` property naming
- Include `ScheduledMessageListQueryParams`
- Fix `EnumToString` issue
- Fix `updateUnreadCount` for Admin Message

## [3.1.19] - Nov 15, 2022

- Removed `user-agent` in http request header

## [3.1.18] - Nov 10, 2022

- Fixed issue with `requireAuth` in `parentMessage`

## [3.1.17] - Nov 3, 2022

- Updated documentation for registerPushToken
- Updated `connectivity_plus` dependency to support Flutter 3.3.1

## [3.1.16] - Oct 27, 2022

- Fixed file message issue with HEIC and HEIF files

## [3.1.15] - Jul 20, 2022

- Update License Agreement
- Change markAsRead method to Future method
- Fix a bug where connection status close automatically
- Include isChannelMention parameter in UserMessageParams

## [3.1.14] - Jul 20, 2022

- Fix connection subscription issue

## [3.1.13] - Jun 22, 2022

- Update G Files
- Include Should Remove Operator Status
- Include Scheduled User and File Message
- Include View Scheduled Message
- Include Cancel Scheduled Message
- Include Total Count Scheduled MEssages
- Include View Scheduled Message List
- Include Scheduled Message Update
- Include Scheduled Message Send Now
- Include parameter `channelType` for poll request
- Include Scheduled Message Callback
- Include HiddenFilter All Option
- Include Exclusive Channel
- Changed to require MimeType FileInfo.fromData
- Fix include scheduled_message_id to message_id
- Fix Connection Subscription Issue
- Fix issue with Flutter Version 3.0.0 Update

## [3.1.12] - March 29, 2022

- Fixed issue with push notification functionality when online (always push)

## [3.1.11] - March 18, 2022

- Updated to latest dependencies
- Fix url exception issue in OGMetaData object by changing OGImage url to be nullable
- Included `getTotalUnreadChannelCountWithParams` method where parameters include custom type and super mode filter
- Included logic for SDK behavior when session token revoked

## [3.1.10] - Feb 25, 2022

- Fix issue with timestamp on Flutter for Web
- Fix issue with pagination in `PreviousMessageListQuery`
- Refactored message fetch params and added deprecation annotation for `includeReplies` and `includeParentMessageText`

## [3.1.9] - Feb 8, 2022

- Web support included
- Improved stability
- Fixed issue with retrieving `creator` property from `BaseChannel` Class
- Fixed issue with retrieving groupchannel with `thumbnails` property

## [3.1.7] - Dec 14, 2021

- Introduced new feature `Reply to channel`
- Added `ReplyType` enum for loading messages with respect to message's reply messages
- Added `includeParentMessageInfo`, `replyType` in `MessageChangeLogsParams`, `MessageListParams`, `PreviousMessageListQuery`
- Deprecated `includeReplies`, `includeParentMessageText` in `MessageChangeLogsParams`, `MessageListParams`, `PreviousMessageListQuery`
- Added `parentMessage`, `isReplyToChannel` in `BaseMessage`
- Deprecated `parentMessageText` in `BaseMessage`
- Added `replyToChannel` to `BaseMessageParams`
- Updated `GroupChannelParams` constructor to take `isUpdate` parameter for update channel
- Fixed connection issue when `LoginTimeout` occurs

## [3.1.6] - Nov 3, 2021

- Added `RestrictedUser` for callback mute/ban feature
- Fixed session related issue
- Fixed group channel updates not to apply unset `operator_ids` in `GroupChannelParams`

## [3.1.5] - Sep 30, 2021

- Fixed link in README
- Improved stabilities

## [3.1.4] - Sep 24, 2021

- Fixed HMS push token registration
- Improved stability

## [3.1.3] - Sep 3, 2021

- Added metaData related filters for `GroupChannelListQuery` and `PublicGroupChannelListQuery`
- Fixed behavior when app life cylce state has changed
- Fixed message parsing when it has a link
- Improved stabilities

## [3.1.2] - Aug 25, 2021

- Added `broadcastOnly` option for super group filter in group list query
- Fixed last message update for admin message
- Fixed member state when a user was invited to group channel
- Refactored api architecture

## [3.1.1] - Jul 27, 2021

- Fixed a bug that connectivity is not working properly when nternet connection becomes on after off
- Changed `connectivity` dependency to `connectivity_plus`

## [3.1.0] - Jul 7, 2021

### Breaking changes

In line with the overall update for Chat SDK for Flutter 3.1.0, behavior changes are applied to the following classes. Visit Sendbird Docs for further information.

- The `PreviousMessageListQuery` now requires `channelType` and `channelUrl`.

```dart
PreviousMessageListQuery({
	required this.channelType,
	required this.channelUrl,
});
```

- The `OperatorListQuery` now requires `channelType` and `channelUrl`.

```dart
 OperatorListQuery({
	required this.channelType,
	required this.channelUrl,
});
```

- The `MessageSearchQuery` now requires `keyword`.

```dart
MessageSearchQuery({required this.keyword});
```

- The `GroupChannelMemberListQuery` now requires `channelUrl`.

```dart
GroupChannelMemberListQuery({required this.channelUrl});
```

- The `UserMessageParams` now requires `message`.

```dart
UserMessageParams({
	required this.message,
})
```

- The `ScheduledUserMessageParams` now requires `scheduledDateString`, `timezone`, and `message`.

```dart
 ScheduledUserMessageParams({
	required this.scheduledDateString,
	required this.timezone,
	required String message,
})
```

- The `MessageRetrievalParams` now requires `channelType`, `channelUrl`, and `messageId`.

```dart
 MessageRetrievalParams({
	required this.channelType,
	required this.channelUrl,
	required this.messageId,
});
```

## [3.1.0-nullsafety.1] - Jun 22, 2021

- Fixed `connectionStatus` mapping for user/sender/member
- Added HMS for push type
- Added `always_push` parameter for push registeration
- Improved stability

## [3.1.0-nullsafety] - Jun 22, 2021

- Fixed channel object to contain last message when invoking `onMessageReceived` callback
- Improved stability

## [3.0.14-nullsafety] - Jun 13, 2021

- Applied null-safety
- Updated dependencies
- Fixed `mostRepliesUsers` mapping in ThreadInfo
- Improved stability

## [3.0.13] - May 17, 2021

- Fixed file type mis mapping bug
- Added `cancelUploadingFileMessage` in `BaseChannel`
- Added `joinedAt` in `GroupChannel`
- Improved stability

## [3.0.12] - Apr 25, 2021

- Fixed to apply option to `SendbirdSdk` properly
- Fixed `sendFileMessage` progress inconsistency
- Improved stability

## [3.0.11] - Apr 22, 2021

- Added `nicknameStartWith` filter in `ApplicationListQuery`
- Updated pubspec and README
- Fixed typo

## [3.0.10] - Apr 19, 2021

- Fixed register token endpoint
- Fixed typo
- Dropped some suffix `~Filter` from `GroupChannelListQuery`
- Changed `FileInfo.fromUrl` parameter `mimeType` as optional (default is `image/jpeg`)
- Changed `getCurrentUser` to `currentUser` getter
- Improved stability

## [3.0.9]

- Fixed metaData mapping for `User`
- Renamed `ImageInfo` to `FileInfo`
- Renamed `markAsDelivered` parameter name from `payload` to `data`
- Renamed `PushTokenType` `gcm` to `fcm`

## [3.0.8]

- Implemented `==` operator for channels, users and messages
- Fixed `getMessage` method
- Added `getMyMuteInfo` method in `BaseChannel`
- Renamed `GroupChannelSuperChannelFilter` and `GroupChannelPublicChannelFilter` to `SuperChannelFilter` and `PublicChannelFilter`
- Redefined error cases
- Added rate limit (1 second) in `markAsRead` method
- Renamed `onChannelMetaData~` and `onChannelMetaCounter~` of channel event handler's method to `onMetaData~` and `onMetaCounter~`
- Renamed `addChannelHandler` `removeChannelHandler` and `getChannelHandler` to `addChannelEventHandler`, `removeChannelEventHandler` and `getChannelEventHandler` respectively
- Renamed `addConnectionHandler` `removeConnectionHandler` and `getConnectionHandler` to `addConnectionEventHandler`, `removeConnectionEventHandler` and `getConnectionEventHandler` respectively
- Renamed `onUpdateTotalUnreadMessageCount` method in `UserEventHandler` to `onTotalUnreadMessageCountUpdated`

## [3.0.7]

- Added `nickname` parameter in `connect` method
- Implmeneted json serializations for queries
- Fixed message change log bugs
- Updated user agent
- Updated README and fixed repo link
- Cleaned up import pattern

## [3.0.6]

- Renamed package `sendbirdsdk` to `sendbird_sdk`
- Cleaned up unused codes
- Improved stability

## [3.0.5]

- Fixed Admin message mapping
- Changed user property `isOnline` to `connectionStatus`
- Added `getCachedMetaData` method in `BaseChannel`
- Updated docs
- Improved stability

## [3.0.4]

- Added `GroupChannelMemberListQuery`
- Changed `refreshChannel` to `refresh` for channel
- Changed parameter type from `User` to `String` for `reportUser` on channel
- Fixed bugs on mapping sender
- Fixed bugs on sending file message
- Fixed bugs on caching
- Improved stability

## [3.0.3]

- Changed return type of update messages (remove completion and use future)
- Accepted mimetype on `ImageInfo`
- Improved stability

## [3.0.2]

- Added member count events for ChannelEventHandler
- Added session refresh / expiration
- Changed method signatures for send / update / resend user and file message
- Handled file message sending asynchronously
- Added network awarness to reconnect
- Updated internal logic while reconnecting
- Refactored socket events
- Improved stability

## [3.0.1] Add missing features

- Added reactions
- Added file size limit
- Added thumbnail option for file message
- Added `OGMetaData`, `OGImage` for open graph
- Added logging
- Added `PreviousMessageListQuery`
- Updated reference documentation
- Improved stability

## [3.0.0] developer preview

- Developer preview
