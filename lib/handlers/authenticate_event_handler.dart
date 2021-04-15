import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/managers/event_manager.dart';

/// Represents a class to get notify authentication events
class AuthenticateEventHandler implements EventHandler {
  /// Informs for user authentication.
  ///
  /// Implements this method to get `userId`, `accessToken`, `apiHost` and
  /// `wsHost` from customer side. Then method will attempt to authenticate
  /// with given information.
  void handleWithAuthInfo(
      Function(String userId, String accessToken, String apiHost, String wsHost)
          cb) {}

  /// Informs user authentication has been finished.
  ///
  /// If succeeded, valid [user] object will be passed into the method.
  /// Otherwise, `error` contains information about authentication error.
  void onFinishAuthentication(User user, Error error) {}
}

/// Represents a class to get notify network events
class NetworkEventHandler implements EventHandler {
  /// Informs when reconnection is about to happen
  void onReconnect() {}
}
