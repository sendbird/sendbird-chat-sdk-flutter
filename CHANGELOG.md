## v4.2.28 (Nov 15, 2024)

### Improvements
- Fixed a bug regarding the initial parameters in message collection

## v4.2.27 (Nov 6, 2024)

### Features
- Applied the message threading policy for last message and unread message count in `GroupChannel`

### Improvements
- Fixed a bug where update events are not called for messages with OGTags
- Fixed the reconnection events to be called in pairs

## v4.2.26 (Oct 28, 2024)

### Features
- Added `useAutoResend` in `SendbirdChatOptions`

### Improvements
- Fixed a bug regarding `onReconnectFailed()` event in `ConnectionHandler`

## v4.2.25 (Oct 21, 2024)

### Improvements
- Fixed the reconnection bug while entering foreground
- Modified the endpoint of sbm metric

## v4.2.24 (Oct 8, 2024)

### Improvements
- Fixed bugs regarding the events for `hide()` in `GroupChannel`
- Fixed the message deletion bug in db regarding `resetMyHistory()`

## v4.2.23 (Sep 13, 2024)

### Improvements
- Fixed the bug regarding `hide()` in `GroupChannel`
- Fixed the issue regarding websocket security

## v4.2.22 (Aug 23, 2024)

### Improvements
- Fixed the bugs regarding the channel change logs on multi `GroupChannelCollection`s

## v4.2.21 (Aug 16, 2024)

### Improvements
- Fixed the bug when upserting a parent message regarding the error on isar
- Fixed the bug regarding the channel filtering when local caching is not used
- Fixed the bugs regarding the thumbnail caching for UIKit
- Fixed a bug regarding reactions on offline mode

## v4.2.20 (Jul 11, 2024)

### Improvements
- Fixed the parsing bug regarding `markAsRead()` event
- Fixed the db upsert bug regarding read status

## v4.2.19 (Jul 4, 2024)

### Improvements
- Fixed a bug that channels are not added when `includeEmpty` is `false` in `GroupChannelCollection`
- Fixed a bug regarding a channel event when leaving a `GroupChannel`
- Fixed a bug regarding the filtering on multi `GroupChannelCollection`s

## v4.2.18 (Jun 26, 2024)

### Improvements
- Fixed the bugs regarding edge cases during `resetMyHistory()` processing
- Fixed a bug that the filtering is not worked on multi `GroupChannelCollection`s
- Fixed a bug that channel changelogs are not upserted in db
- Fixed a bug regarding the result of `init()` in `SendbirdChat`

## v4.2.17 (Jun 18, 2024)

### Improvements
- Fixed a bug regarding receiving messages during `resetMyHistory()` processing

## v4.2.16 (Jun 13, 2024)

### Improvements
- Fixed a bug regarding `await` in `resetMyHistory()` in `GroupChannel`

## v4.2.15 (Jun 5, 2024)

### Improvements
- Fixed the bugs regarding my mute info
- Fixed the bugs regarding changelogs on web
- Fixed the bugs regarding connection management
- Fixed the bugs regarding `markAsDelivered()` in `SendbirdChat`
- Added `metaData`, `readStatus`, `deliveryStatus` in channel db
- Fixed a bug when `includeEmpty` is `false` in `GroupChannelCollection`

## v4.2.14 (May 16, 2024)

### Improvements
- Fixed the exceptions regarding url encoding for api
- Fixed the bug that profile image is not updated on web
- Fixed the bugs regarding event, exception and cache
- Modified the event order regarding failed messages in message collection
- Improved stability

## v4.2.13 (Apr 30, 2024)

### Improvements
- Fixed the bugs regarding session update

## v4.2.12 (Apr 24, 2024)

### Features
- Updated dependency range for `connectivity_plus` package from `^5.0.1` to `>=5.0.1 <7.0.0`

### Improvements
- Fixed `MessageCollection` regarding `resetMyHistory()` in `GroupChannel`
- Fixed `removeFailedMessage()` and `removeAllFailedMessages()` in `MessageCollection`
- Fixed the bugs regarding message change log, pending message removal, typing status and delivered status
- Added improvements on `getUndeliveredMembers()` method to prevent a potential problem.
  The return type for `getUndeliveredMembers()` was updated from `List<Member>` to `List<Member>?`.
  Please update this part of your code if you use `getUndeliveredMembers()`.
- Improved stability

## v4.2.11 (Apr 18, 2024)

### Improvements
- Fixed the bug that there are duplicate channels in `GroupChannelCollection`
- Added default mimeType in `FileMessageCreateParams`

## v4.2.10 (Apr 9, 2024)

### Features
- Added the privacy manifest file for iOS

### Improvements
- Fixed the bug that there are duplicate channels in `GroupChannelCollection`

## v4.2.9 (Apr 3, 2024)

### Improvements
- Fixed the bugs regarding error handling in `MessageCollection`
- Fixed the bug that `mentionedUserIds` is missing in a pending message

## v4.2.8 (Mar 27, 2024)

### Improvements
- Fixed the compile error regarding logger v1.4.0

## v4.2.7 (Mar 21, 2024)

### Improvements
- Updated dependency range for http, uuid and logger packages
- Fixed the exception regarding encrypt package

## v4.2.6 (Mar 20, 2024)

### Improvements
- Fixed the bug regarding reaction payload parsing

## v4.2.5 (Mar 12, 2024)

### Improvements
- Added `secureUrl` in `Thumbnail`

## v4.2.4 (Mar 8, 2024)

### Improvements
- Fixed the exception regarding unmodifiable list

## v4.2.3 (Mar 4, 2024)

### Improvements
- Fixed the bug where `query` in `GroupChannelCollection` does not work when reconnected

## v4.2.2 (Fed 15, 2024)

### Improvements
- Fixed the bug where `votedPollOptionIds` in `Poll` is always empty

## v4.2.1 (Fed 5, 2024)

### Improvements
- Fixed the bug where `getCachedMetaData()` in `BaseChannel` is not being updated when deleting metadata

## v4.2.0 (Jan 31, 2024)

### Features

#### Local Caching for Android and iOS (Not supported for Web yet)
> Local caching enables Sendbird Chat SDK for Flutter to cache and retrieve group channel and message data locally. Its benefits include reducing refresh time and allowing a client app to create a channel list or a chat view that can work online as well as offline.
> The local caching feature is enabled by default.

- Added `useCollectionCaching` in `SendbirdChatOptions` (The default value is `true`)
- Added `getCachedDataSize()`, `clearCachedData()` and `clearCachedMessages()` in `SendbirdChat`
- Added `getFailedMessages()`, `removeFailedMessages()` and `removeAllFailedMessages()` in `MessageCollection`
- Added `markAsRead()` in `BaseMessageCollection`

### Improvements
- Fixed the bugs regarding FeedChannel
- Improved stability

## v4.1.2 (Dec 12, 2023)

### Features
- Added `createdBefore` and `createdAfter` in `GroupChannelListQuery` and `PublicGroupChannelListQuery`
- Added `markAsClicked()` in `FeedChannel`
- Replaced `markAsReadBy()` with `markAsRead()` in `FeedChannel`

### Improvements
- Fix the bugs regarding FeedChannel
- Fix the bugs regarding ReactionEvent
- Improved stability

## v4.1.1 (Nov 8, 2023)

### Improvements
- Updated `connectivity_plus` package to `5.0.1`

## v4.1.0 (Nov 3, 2023)

### Features

#### NotificationMessage
- Added `NotificationMessage` with `notificationId`, `messageStatus` and `notificationData`
- Added `markAsReadBy()`, `logImpression()` and `logCustom()` in `FeedChannel`
- Replaced `BaseMessage? lastMessage` with `NotificationMessage? lastMessage` in `FeedChannel`
- Replaced `List<BaseMessage> messageList` with `List<NotificationMessage> messageList` in `NotificationCollection`
- Modified `onMessagesAdded()`, `onMessagesUpdated()` and `onMessagesDeleted()` in `NotificationCollectionHandler`
- Modified `onMessageReceived()` and `onChannelChanged()` in `FeedChannelHandler`

### Deprecated Methods
- Removed `onTotalUnreadMessageCountUpdated()` in `UserEventHandler`

### Improvements
- Improved stability

## v4.0.13 (Sep 27, 2023)

### Features
- Added `MessageSearchQuery`
- Added `includeMetaArray`, `includeReactions` and `includeThreadInfo` in `PreviousMessageListQuery`

### Improvements
- Improved stability

## v4.0.12 (Sep 15, 2023)

### Improvements
- Fixed the bug regarding parent `FileMessage` type
- Updated regarding statistics

## v4.0.11 (Sep 12, 2023)

### Improvements
- Fixed the bug regarding the url encoding of `userId`

## v4.0.10 (Aug 31, 2023)

### Improvements
- Fixed the bug regarding the `FeedChannel` caching

## v4.0.9 (Aug 30, 2023)

### Improvements
- Fixed the bug regarding the `hasNext` in `BaseMessageCollection`
- Fixed the bug when the `reverse` is `true` in `MessageListParams` regarding `BaseMessageCollection`
- Improved stability

## v4.0.8 (Aug 22, 2023)

### Features
- Replaced `Map<String, String> templateVariables` with `Map<String, dynamic> templateVariables` in `NotificationData`
- Added `tags` in `NotificationData`

### Improvements
- Improved stability

## v4.0.7 (Aug 18, 2023)

### Features
- Added `notificationData` in `BaseMessage`

### Improvements
- Fixed the bug regarding `unreadMessageCount` in `FeedChannel`

## v4.0.6 (Aug 16, 2023)

### Features

#### Notification
- Added `isTemplateLabelEnabled`, `isCategoryFilterEnabled` and `notificationCategories` in `FeedChannel`
- Added `authenticateFeed()`, `refreshNotificationCollections()` in `SendbirdChat`

### Improvements
- Improved stability

## v4.0.5 (Jul 14, 2023)

### Features
- Added `SendbirdStatistics` for internal use

### Improvements
- Improved stability

## v4.0.4 (Jul 3, 2023)

### Improvements
- Fixed the bug regarding `resendFileMessage()`
- Fixed the bug regarding connectivity events

## v4.0.3 (Jun 30, 2023)

### Features

#### FeedChannel
- Added `FeedChannelListQuery`
- Added `FeedChannel`
- Added `feed` in `ChannelType`
- Added `getMyFeedChannelChangeLogs()` with `FeedChannelChangeLogsParams` in SendbirdChat
- Added `getTotalUnreadMessageCountWithFeedChannel()
  ` in SendbirdChat
- Added `FeedChannelHandler`
- Added `onTotalUnreadMessageCountChanged()` in `UserEventHandler` and `UnreadMessageCount`

#### Collection for notifications
- Added `NotificationCollection`, `NotificationCollectionHandler` and `NotificationContext`
- Added `BaseMessageCollection`, `BaseMessageCollectionHandler` and `BaseMessageContext`
- Added `FeedChannelContext`, `BaseChannelContext`

#### ChatNotification for GroupChannel
- Added `isChatNotification` in GroupChannel
- Added `includeChatNotification` in `GroupChannelListQuery` and `GroupChannelChangeLogsParams`

#### Setting and Template for Notification
- Added `getGlobalNotificationChannelSetting()` and `GlobalNotificationChannelSetting` in SendbirdChat
- Added `getNotificationTemplateListByToken()` with `NotificationTemplateListParams` and `NotificationTemplateList` in SendbirdChat
- Added `getNotificationTemplate()` and `NotificationTemplate` in SendbirdChat

#### NotificationInfo
- Added `NotificationInfo`
- Added `notificationInfo` in `AppInfo`

### Improvements
- Improved stability

## v4.0.2 (Jun 23, 2023)
- Improved stability

## v4.0.1 (Jun 14, 2023)
- Improved stability

## v4.0.0 (May 31, 2023)
> To see detailed changes, please refer to the [migration guide](https://sendbird.com/docs/chat/v4/flutter/getting-started/migration-guide)

### Features
- Added `GroupChannelCollection`, `GroupChannelContext` and `GroupChannelCollectionHandler`
- Added `MessageCollection`, `MessageContext` and `MessageCollectionHandler`
- Added `enum CollectionEventSource`

## v3 Changelog
Please refer to [this page](https://github.com/sendbird/sendbird-chat-sdk-flutter/blob/v3/CHANGELOG.md)
