part of 'open_channel.dart';

extension OpenChannelOperations on OpenChannel {
  /// Enters to this channel
  Future<void> enter() async {
    final cmd = Command.buildEnterChannel(this);
    final result = await _sdk.cmdManager.sendCommand(cmd);
    if (result == null) {
      throw WebSocketError();
    }
    participantCount = result.payload['participant_count'];
    entered = true;
  }

  /// Exits from this channel
  Future<void> exit() async {
    final cmd = Command.buildExitChannel(this);
    final result = await _sdk.cmdManager.sendCommand(cmd);
    participantCount = result.payload['participant_count'];
    entered = false;
    removeFromCache();
  }
}
