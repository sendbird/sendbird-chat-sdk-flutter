import 'package:sendbird_sdk/managers/event_manager.dart';

/// Represents a class to notify various connection event.
///
/// This is base class that you can mixin, so that you can register on
/// [SendbirdSdk.addConnectionEventHandler]. Typically you want to use this class as
/// following:
///
/// ```
/// class MyHandler with ConnectionEventHandler {
///   @override
///   void onReconnectionStarted() {
///      //user logic here when reconnection is started
///   }
///   ...
/// }
/// ```
class ConnectionEventHandler implements EventHandler {
  /// Informs when connection started
  void onReconnectionStarted() {}

  /// Informs when connection has been maded successfully
  void onReconnectionSucceeded() {}

  /// Informs when connection has been failed to reconnect
  void onReconnectionFailed() {}

  /// Informs when connection has been canceled
  void onReconnectionCanceled() {}
}
