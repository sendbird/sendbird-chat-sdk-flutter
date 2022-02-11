## [3.1.8] - Feb 8, 2022
* Web support included
* Improved stability
* Fixed issue with retrieving `creator` property from `BaseChannel` Class
* Fixed issue with retrieving groupchannel with `thumbnails` property

## [3.1.7] - Dec 14, 2021
* Introduced new feature `Reply to channel` 
* Added `ReplyType` enum for loading messages with respect to message's reply messages
* Added `includeParentMessageInfo`, `replyType` in `MessageChangeLogsParams`, `MessageListParams`, `PreviousMessageListQuery`
* Deprecated `includeReplies`, `includeParentMessageText` in `MessageChangeLogsParams`, `MessageListParams`, `PreviousMessageListQuery`
* Added `parentMessage`, `isReplyToChannel` in `BaseMessage`
* Deprecated `parentMessageText` in `BaseMessage`
* Added `replyToChannel` to `BaseMessageParams`
* Updated `GroupChannelParams` constructor to take `isUpdate` parameter for update channel
* Fixed connection issue when `LoginTimeout` occurs 

## [3.1.6] - Nov 3, 2021
* Added `RestrictedUser` for callback mute/ban feature
* Fixed session related issue
* Fixed group channel updates not to apply unset `operator_ids` in `GroupChannelParams` 

## [3.1.5] - Sep 30, 2021
* Fixed link in README
* Improved stabilities

## [3.1.4] - Sep 24, 2021
* Fixed HMS push token registration
* Improved stability 

## [3.1.3] - Sep 3, 2021
* Added metaData related filters for `GroupChannelListQuery` and `PublicGroupChannelListQuery`
* Fixed behavior when app life cylce state has changed
* Fixed message parsing when it has a link
* Improved stabilities

## [3.1.2] - Aug 25, 2021
* Added `broadcastOnly` option for super group filter in group list query
* Fixed last message update for admin message
* Fixed member state when a user was invited to group channel
* Refactored api architecture

## [3.1.1] - Jul 27, 2021
* Fixed a bug that connectivity is not working properly when nternet connection becomes on after off
* Changed `connectivity` dependency to `connectivity_plus`

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
* Fixed `connectionStatus` mapping for user/sender/member
* Added HMS for push type
* Added `always_push` parameter for push registeration
* Improved stability

## [3.1.0-nullsafety] - Jun 22, 2021
* Fixed channel object to contain last message when invoking `onMessageReceived` callback
* Improved stability

## [3.0.14-nullsafety] - Jun 13, 2021
* Applied null-safety
* Updated dependencies
* Fixed `mostRepliesUsers` mapping in ThreadInfo
* Improved stability

## [3.0.13] - May 17, 2021
* Fixed file type mis mapping bug
* Added `cancelUploadingFileMessage` in `BaseChannel`
* Added `joinedAt` in `GroupChannel`
* Improved stability

## [3.0.12] - Apr 25, 2021
* Fixed to apply option to `SendbirdSdk` properly
* Fixed `sendFileMessage` progress inconsistency
* Improved stability

## [3.0.11] - Apr 22, 2021
* Added `nicknameStartWith` filter in `ApplicationListQuery`
* Updated pubspec and README
* Fixed typo

## [3.0.10] - Apr 19, 2021
* Fixed register token endpoint
* Fixed typo
* Dropped some suffix `~Filter` from `GroupChannelListQuery`
* Changed `FileInfo.fromUrl` parameter `mimeType` as optional (default is `image/jpeg`)
* Changed `getCurrentUser` to `currentUser` getter
* Improved stability

## [3.0.9]
* Fixed metaData mapping for `User`
* Renamed `ImageInfo` to `FileInfo`
* Renamed `markAsDelivered` parameter name from `payload` to `data`
* Renamed `PushTokenType` `gcm` to `fcm` 

## [3.0.8]
* Implemented `==` operator for channels, users and messages
* Fixed `getMessage` method
* Added `getMyMuteInfo` method in `BaseChannel`
* Renamed `GroupChannelSuperChannelFilter` and `GroupChannelPublicChannelFilter` to `SuperChannelFilter` and `PublicChannelFilter`
* Redefined error cases 
* Added rate limit (1 second) in `markAsRead` method
* Renamed `onChannelMetaData~` and `onChannelMetaCounter~` of channel event handler's method to `onMetaData~` and `onMetaCounter~`
* Renamed `addChannelHandler` `removeChannelHandler` and `getChannelHandler` to `addChannelEventHandler`, `removeChannelEventHandler` and `getChannelEventHandler` respectively
* Renamed `addConnectionHandler` `removeConnectionHandler` and `getConnectionHandler` to `addConnectionEventHandler`, `removeConnectionEventHandler` and `getConnectionEventHandler` respectively
* Renamed `onUpdateTotalUnreadMessageCount` method in `UserEventHandler` to `onTotalUnreadMessageCountUpdated`

## [3.0.7]
* Added `nickname` parameter in `connect` method
* Implmeneted json serializations for queries
* Fixed message change log bugs
* Updated user agent
* Updated README and fixed repo link
* Cleaned up import pattern

## [3.0.6]
* Renamed package `sendbirdsdk` to `sendbird_sdk`
* Cleaned up unused codes
* Improved stability

## [3.0.5]
* Fixed Admin message mapping
* Changed user property `isOnline` to `connectionStatus`
* Added `getCachedMetaData` method in `BaseChannel`
* Updated docs
* Improved stability

## [3.0.4]
* Added `GroupChannelMemberListQuery`
* Changed `refreshChannel` to `refresh` for channel
* Changed parameter type from `User` to `String` for `reportUser` on channel
* Fixed bugs on mapping sender
* Fixed bugs on sending file message
* Fixed bugs on caching 
* Improved stability

## [3.0.3]
* Changed return type of update messages (remove completion and use future)
* Accepted mimetype on `ImageInfo` 
* Improved stability

## [3.0.2] 
* Added member count events for ChannelEventHandler
* Added session refresh / expiration
* Changed method signatures for send / update / resend user and file message
* Handled file message sending asynchronously
* Added network awarness to reconnect
* Updated internal logic while reconnecting
* Refactored socket events
* Improved stability

## [3.0.1] Add missing features
* Added reactions
* Added file size limit
* Added thumbnail option for file message 
* Added `OGMetaData`, `OGImage` for open graph
* Added logging
* Added `PreviousMessageListQuery`
* Updated reference documentation
* Improved stability 

## [3.0.0] developer preview
* Developer preview
