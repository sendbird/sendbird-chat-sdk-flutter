/// A structure for options to SendbirdSdk.
class Options {
  bool useMemeberAsMessageSender;

  /// Sets the timeout for connection. If there is a timeout error
  /// frequently, set the longer timeout than default value. The
  /// default is 10 seconds
  int connectionTimeout = 10;

  /// Sets a term of typing indicator throttling in group channel.
  /// After this throttling interval from typing indicator started
  /// (or ended), You can re-start (or re-end) typing indicator.
  /// If you call start (or end) again in this interval, the call will be ignored.
  int typingIndicatorThrottle = 5;

  /// TBD
  int authenticationTimeout = 10;

  /// Sets the timeout for file transfer. This value affects the methods
  /// that send a binary data including sending file messages, creating
  /// and updating channels
  int fileTransferTimeout = 30;

  /// Sets the websocket response timeout used in sending/receiving
  /// commmands by websocket. The value should be between 5 seconds
  /// and 300 seconds (5 minutes). The default value is 10 seconds.
  int websocketTimeout = 1000;

  Options({
    this.connectionTimeout = 30,
    this.authenticationTimeout = 30,
    this.fileTransferTimeout = 30,
    this.typingIndicatorThrottle = 5,
    this.useMemeberAsMessageSender = true,
    this.websocketTimeout = 30,
  });
}
