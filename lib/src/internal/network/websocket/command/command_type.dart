// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

class CommandString {
  static const String userMessage = 'MESG';
  static const String userMessageUpdate = 'MEDI';
  static const String fileMessage = 'FILE';
  static const String fileMessageUpdate = 'FEDI';
  static const String adminMessage = 'ADMM';
  static const String adminMessageUpdate = 'AEDI';
  static const String broadcastMessage = 'BRDM';
  static const String messageDeleted = 'DELM';
  static const String parentMessageDeleted = 'DELE';
  static const String delivery = 'DLVR';
  static const String read = 'READ';
  static const String memberCountChanged = 'MCNT';
  static const String reaction = 'MRCT';
  static const String thread = 'MTHD';
  static const String userEvent = 'USEV';
  static const String systemEvent = 'SYEV';
  static const String sessionExpired = 'EXPR';
  static const String error = 'EROR';
  static const String login = 'LOGI';
  static const String busy = 'BUSY';
  static const String enter = 'ENTR';
  static const String exit = 'EXIT';
  static const String mack = 'MACK';
  static const String typingStart = 'TPST';
  static const String typingEnd = 'TPEN';
  static const String ping = 'PING';
  static const String pollVoted = 'VOTE';
  static const String pollUpdated = 'PEDI';

  static bool isUserMessage(String commandType) {
    return CommandType.userMessage.value == commandType ||
        CommandType.userMessageUpdate.value == commandType;
  }

  static bool isFileMessage(String commandType) {
    return CommandType.fileMessage.value == commandType ||
        CommandType.fileMessageUpdate.value == commandType;
  }

  static bool isAdminMessage(String commandType) {
    return CommandType.adminMessage.value == commandType ||
        CommandType.adminMessageUpdate.value == commandType ||
        CommandType.broadcastMessage.value == commandType;
  }
}

enum CommandType {
  userMessage,
  userMessageUpdate,
  fileMessage,
  fileMessageUpdate,
  adminMessage,
  adminMessageUpdate,
  broadcastMessage,
  deleteMessage,
  delivery,
  read,
  memberCountChange,
  reaction,
  threading,
  userEvent,
  systemEvent,
  sessionExpired,
  error,
  login,
  enter,
  exit,
  mack,
  typingStart,
  typingEnd,
  ping,
  pollVote,
  pollUpdate,
}

extension CommandExtension on CommandType {
  String get value {
    switch (this) {
      case CommandType.userMessage:
        return 'MESG';
      case CommandType.userMessageUpdate:
        return 'MEDI';
      case CommandType.fileMessage:
        return 'FILE';
      case CommandType.fileMessageUpdate:
        return 'FEDI';
      case CommandType.adminMessage:
        return 'ADMM';
      case CommandType.adminMessageUpdate:
        return 'AEDI';
      case CommandType.broadcastMessage:
        return 'BRDM';
      case CommandType.deleteMessage:
        return 'DELM';
      case CommandType.delivery:
        return 'DLRV';
      case CommandType.read:
        return 'READ';
      case CommandType.memberCountChange:
        return 'MCNT';
      case CommandType.reaction:
        return 'MRCT';
      case CommandType.threading:
        return 'MTHD';
      case CommandType.userEvent:
        return 'USEV';
      case CommandType.systemEvent:
        return 'SYEV';
      case CommandType.sessionExpired:
        return 'EXPR';
      case CommandType.login:
        return 'LOGI';
      case CommandType.enter:
        return 'ENTR';
      case CommandType.exit:
        return 'EXIT';
      case CommandType.mack:
        return 'MACK';
      case CommandType.typingStart:
        return 'TPST';
      case CommandType.typingEnd:
        return 'TPEN';
      case CommandType.ping:
        return 'PING';
      case CommandType.error:
        return 'EROR';
      case CommandType.pollVote:
        return 'VOTE';
      case CommandType.pollUpdate:
        return 'PEDI';
    }
  }
}
