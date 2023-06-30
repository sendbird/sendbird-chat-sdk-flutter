## v4.0.3 (Jun 30, 2023)

### Features

#### FeedChannel
- Added `FeedChannelListQuery`
- Added `FeedChannel`.
- Added `feed` in `ChannelType`.
- Added `getMyFeedChannelChangeLogs()` with `FeedChannelChangeLogsParams` in SendbirdChat.
- Added `getTotalUnreadMessageCountWithFeedChannel()
  ` in SendbirdChat.
- Added `FeedChannelHandler`.
- Added `onTotalUnreadMessageCountChanged()` in `UserEventHandler` and `UnreadMessageCount`.

#### Collection for notifications
- Added `NotificationCollection`, `NotificationCollectionHandler` and `NotificationContext`.
- Added `BaseMessageCollection`, `BaseMessageCollectionHandler` and `BaseMessageContext`.
- Added `FeedChannelContext`, `BaseChannelContext`.

#### ChatNotification for GroupChannel
- Added `isChatNotification` in GroupChannel.
- Added `includeChatNotification` in `GroupChannelListQuery` and `GroupChannelChangeLogsParams`.

#### Setting and Template for Notification
- Added `getGlobalNotificationChannelSetting()
  ` and `GlobalNotificationChannelSetting` in SendbirdChat.
- Added `getNotificationTemplateListByToken()
  ` with `NotificationTemplateListParams` and `NotificationTemplateList` in SendbirdChat.
- Added `getNotificationTemplate()
  ` and `NotificationTemplate` in SendbirdChat.

#### NotificationInfo
- Added `NotificationInfo`.
- Added `notificationInfo` in `AppInfo`.

### Improvements
- Improved stability.

## v4.0.2 (Jun 23, 2023)
- Improved stability.

## v4.0.1 (Jun 14, 2023)
- Improved stability.

## v4.0.0 (May 31, 2023)
> To see detailed changes, please refer to the [migration guide](https://sendbird.com/docs/chat/v4/flutter/getting-started/migration-guide).

### Features
- Added `GroupChannelCollection`, `GroupChannelContext` and `GroupChannelCollectionHandler`.
- Added `MessageCollection`, `MessageContext` and `MessageCollectionHandler`.
- Added `enum CollectionEventSource`.

## v3 Changelog
Please refer to [this page](https://github.com/sendbird/sendbird-chat-sdk-flutter/blob/v3/CHANGELOG.md).
