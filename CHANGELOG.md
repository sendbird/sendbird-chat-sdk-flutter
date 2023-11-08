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
