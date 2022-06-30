class CommandString {
  static const String userMessage = 'MESG';
  static const String userMessageUpdate = 'MEDI';
  static const String fileMessage = 'FILE';
  static const String fileMessageUpdate = 'FEDI';
  static const String adminMessage = 'ADMM';
  static const String adminMessageUpdate = 'AEDI';
  static const String broadcastMessage = 'BRDM';
  static const String deleteMessage = 'DELM';
  static const String delivery = 'DLVR';
  static const String read = 'READ';
  static const String memberCountChange = 'MCNT';
  static const String reaction = 'MRCT';
  static const String thread = 'MTHD';
  static const String userEvent = 'USEV';
  static const String systemEvent = 'SYEV';
  static const String sessionExpired = 'EXPR';
  static const String error = 'EROR';

  static const String login = 'LOGI';
  static const String enter = 'ENTR';
  static const String exit = 'EXIT';
  static const String mack = 'MACK';
  static const String typingStart = 'TPST';
  static const String typingEnd = 'TPEN';
  static const String ping = 'PING';

  static const String pollVote = 'VOTE';
  static const String pollUpdate = 'PEDI';

  static bool isUserMessage(String cmd) {
    return CommandType.userMessage.value == cmd ||
        CommandType.userMessageUpdate.value == cmd;
  }

  static bool isFileMessage(String cmd) {
    return CommandType.fileMessage.value == cmd ||
        CommandType.fileMessageUpdate.value == cmd;
  }

  static bool isAdminMessage(String cmd) {
    return CommandType.adminMessage.value == cmd ||
        CommandType.adminMessageUpdate.value == cmd ||
        CommandType.broadcastMessage.value == cmd;
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

//string to enum
// const commandTypeEnumMap = <String, CommandType>{
//  'MESG': CommandType.userMessage,
//   'MEDI': CommandType.userMessageUpdate,
//       'FILE': CommandType.fileMessage,
//       'FEDI': CommandType.fileMessageUpdate,
//         return ;
//       case CommandType.adminMessage:
//         return 'ADMM';
//       case CommandType.adminMessageUpdate:
//         return 'AEDI';
//       case CommandType.broadcastMessage:
//         return 'BRDM';
//       case CommandType.deleteMessage:
//         return 'DELM';
//       case CommandType.delivery:
//         return 'DLRV';
//       case CommandType.read:
//         return 'READ';
//       case CommandType.memberCountChange:
//         return 'MCNT';
//       case CommandType.reaction:
//         return 'MRCT';
//       case CommandType.threading:
//         return 'MTHD';
//       case CommandType.userEvent:
//         return 'USEV';
//       case CommandType.systemEvent:
//         return 'SYEV';
//       case CommandType.sessionExpired:
//         return 'EXPR';
//       case CommandType.login:
//         return 'LOGI';
//       case CommandType.enter:
//         return 'ENTR';
//       case CommandType.exit:
//         return 'EXIT';
//       case CommandType.mack:
//         return 'MACK';
//       case CommandType.typingStart:
//         return 'TPST';
//       case CommandType.typingEnd:
//         return 'TPEN';
//       case CommandType.ping:
//         return 'PING';
//       case CommandType.error:
//         return 'EROR';
// };

//enum to string
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
