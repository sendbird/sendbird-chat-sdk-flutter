/// A structure for options to SendbirdSdk.
class Options {
  bool useMemeberAsMessageSender;

  /// Sets the timeout for connection. If there is a timeout error
  /// frequently, set the longer timeout than default value. The
  /// default is 10 seconds
  int connectionTimeout;

  /// Sets a term of typing indicator throttling in group channel.
  /// After this throttling interval from typing indicator started
  /// (or ended), You can re-start (or re-end) typing indicator.
  /// If you call start (or end) again in this interval, the call will be ignored.
  int typingIndicatorThrottle;

  /// TBD
  int authenticationTimeout;

  /// Sets the timeout for file transfer. This value affects the methods
  /// that send a binary data including sending file messages, creating
  /// and updating channels
  int fileTransferTimeout;

  /// Sets the websocket response timeout used in sending/receiving
  /// commmands by websocket. The value should be between 5 seconds
  /// and 300 seconds (5 minutes). The default value is 10 seconds.
  int websocketTimeout;

  /// option to include poll detail
  bool includePollDetails;

  Options({
    this.connectionTimeout = 10,
    this.authenticationTimeout = 30,
    this.fileTransferTimeout = 30,
    this.typingIndicatorThrottle = 5,
    this.useMemeberAsMessageSender = true,
    this.websocketTimeout = 30,
    this.includePollDetails = true,
  });
}
