import '../../event/authenticate_event_handler.dart';

class ConnectionManager {
  Map<String, NetworkEventHandler> _networkHandlers = {};
  AuthenticateEventHandler authHandler;

  /// Add network [delegate] with `identifier`
  void addNetworkDelegate(String identifier, NetworkEventHandler delegate) {
    _networkHandlers[identifier] = delegate;
  }

  /// Remove network delegate with `identifier`
  void removeNetworkDelegate(String identifier) {
    _networkHandlers.remove(identifier);
  }

  /// Remove all network delegates
  void removeAllNetworkDelegates() {
    _networkHandlers.removeWhere((key, value) => true);
  }

  /// Set authenticate `delegate`
  void setAuthenticateDelegate(AuthenticateEventHandler handler) {
    authHandler = handler;
  }

  /// Perform authentication. This process should complete within timeout
  /// that is set on `authenticationTimeout` property in [Options]. While it
  /// performs authentication, [AuthenticationDelegate] methods will be invoked
  /// as it needed.
  void authenticate() {}
}
