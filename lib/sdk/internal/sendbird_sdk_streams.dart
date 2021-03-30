import 'dart:async';

import '../../constant/enums.dart';
import '../../core/channel/base/base_channel.dart';
import '../../core/channel/group/group_channel.dart';
import '../../core/models/responses.dart';

class StreamManager {
  StreamController<int> _totalUnreadCountController;
  StreamController<ChannelMessageResponse> _messageUpdateStreamController;
  StreamController<ChannelMessageResponse> _messageReceiveStreamController;
  StreamController<ChannelMessageResponse> _messageDeleteStreamController;
  StreamController<BaseChannel> _channelChangedStreamController;
  StreamController<GroupChannel> _readStreamController;
  StreamController<GroupChannel> _deliveryStreamController;
  StreamController<GroupChannel> _usersTypingStreamController;
  StreamController<ConnectionEventType> _connectionStreamController;

  StreamController<int> get unread => _totalUnreadCountController;
  StreamController<ChannelMessageResponse> get msgUpdated =>
      _messageUpdateStreamController;
  StreamController<ChannelMessageResponse> get msgReceived =>
      _messageReceiveStreamController;
  StreamController<ChannelMessageResponse> get msgDeletd =>
      _messageDeleteStreamController;
  StreamController<BaseChannel> get channelChanged =>
      _channelChangedStreamController;
  StreamController<GroupChannel> get read => _readStreamController;
  StreamController<GroupChannel> get delivery => _deliveryStreamController;
  StreamController<GroupChannel> get typing => _usersTypingStreamController;
  StreamController<ConnectionEventType> get connection =>
      _connectionStreamController;

  void reset() {
    _totalUnreadCountController?.close();
    _messageReceiveStreamController?.close();
    _messageUpdateStreamController?.close();
    _messageDeleteStreamController?.close();
    _readStreamController?.close();
    _deliveryStreamController?.close();
    _channelChangedStreamController?.close();
    _usersTypingStreamController?.close();
    _connectionStreamController?.close();

    _totalUnreadCountController = StreamController<int>.broadcast();
    _messageUpdateStreamController =
        StreamController<ChannelMessageResponse>.broadcast();
    _messageReceiveStreamController =
        StreamController<ChannelMessageResponse>.broadcast();
    _messageDeleteStreamController =
        StreamController<ChannelMessageResponse>.broadcast();
    _channelChangedStreamController = StreamController<BaseChannel>.broadcast();
    _readStreamController = StreamController<GroupChannel>.broadcast();
    _deliveryStreamController = StreamController<GroupChannel>.broadcast();
    _usersTypingStreamController = StreamController<GroupChannel>.broadcast();
    _connectionStreamController =
        StreamController<ConnectionEventType>.broadcast();
  }
}
