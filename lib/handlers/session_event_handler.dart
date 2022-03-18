import 'package:meta/meta.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/managers/event_manager.dart';

/// Represents a class to notify user session event.
///
/// This is base class that you can mixin, so that you can register on
/// [SendbirdSdk.addSessionEventHandler]. Typically you want to use this class as
/// following:
///
/// ```
/// class MyHandler with SessionEventHandler {
///   @override
///   void onCloseSession() {
///      //user logic here when session is closed
///   }
///   ...
/// }
/// ```
class SessionEventHandler implements EventHandler {
  /// App needs to fetch a new token.
  /// Pass on the new (retrieved) token to SDK via `success(NEW_TOKEN)`
  /// or `fail()` if fetch failed.
  /// In case when app decides not to refresh the session for this user,
  /// they should call `success(null)`.
  @required
  void onSessionTokenRequired(Function(String) successCb, Function failCb) {}

  /// Informs when the SDK can't refresh the session.
  /// App should force a user to a login page to connect again.
  @required
  void onSessionClosed() {}

  /// Informs when session key is expired.
  void onSessionExpired() {}

  /// Informs when SDK refreshed the session key.
  void onSessionRefreshed() {}

  /// Informs when the SDK run into an error while refreshing the session key
  void onSessionError(SBError error) {}
}
