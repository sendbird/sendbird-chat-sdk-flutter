import 'package:sendbird_sdk/constant/enums.dart';

MuteState booltoMuteState(bool? isMuted) =>
    isMuted != null && isMuted ? MuteState.muted : MuteState.unmuted;

String userToUserId(Map<String, dynamic>? userDic) =>
    userDic != null ? userDic['user_id'] ?? userDic['guest_id'] : null;

UserConnectionStatus boolToConnectionStatus(bool? isOnline) => isOnline == null
    ? UserConnectionStatus.notAvailable
    : isOnline
        ? UserConnectionStatus.online
        : UserConnectionStatus.offline;

bool? connectionStatusToBool(UserConnectionStatus status) =>
    status == UserConnectionStatus.notAvailable
        ? null
        : status == UserConnectionStatus.online;
