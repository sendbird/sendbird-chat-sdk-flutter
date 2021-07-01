import 'dart:async';

import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/models/responses.dart';

class StreamManager {
  late StreamController<int> _totalUnreadCountController;
  late StreamController<ChannelMessageResponse> _messageUpdateStreamController;
  late StreamController<ChannelMessageResponse> _messageReceiveStreamController;
  late StreamController<ChannelMessageResponse> _messageDeleteStreamController;
  late StreamController<BaseChannel> _channelChangedStreamController;
  late StreamController<GroupChannel> _readStreamController;
  late StreamController<GroupChannel> _deliveryStreamController;
  late StreamController<GroupChannel> _usersTypingStreamController;
  late StreamController<ConnectionEventType> _connectionStreamController;

  StreamManager() {
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
    _totalUnreadCountController.close();
    _messageReceiveStreamController.close();
    _messageUpdateStreamController.close();
    _messageDeleteStreamController.close();
    _readStreamController.close();
    _deliveryStreamController.close();
    _channelChangedStreamController.close();
    _usersTypingStreamController.close();
    _connectionStreamController.close();

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
