import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/managers/event_manager.dart';

/// Represents a class to notify user event.
///
/// This is base class that you can mixin, so that you can register on
/// [SendbirdSdk.addUserEventHandler]. Typically you want to use this class as
/// following:
///
/// ```
/// class MyHandler with UserEventHandler {
///   @override
///   void onUpdateTotalUnreadMessageCount(int totalCount, Map<String, num> customTypesCount) {
///      // user logic when total unread message count is updated
///   }
/// }
/// ```
class UserEventHandler implements EventHandler {
  /// Not supporting TBD
  void onFriendsDiscovered(List<User> friends) {}

  /// Informs total unread message count has been changed
  void onTotalUnreadMessageCountUpdated(
    int totalCount,
    Map<String, num> customTypesCount,
  ) {}
}
