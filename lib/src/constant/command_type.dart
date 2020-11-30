class CommandType {
  static const String userMessage = "MESG";
  static const String userMessageUpdate = "MEDI";
  static const String fileMessage = "FILE";
  static const String fileMessageUpdate = "FEDI";
  static const String adminMessage = "ADMN";
  static const String adminMessageUpdate = "AEDI";
  static const String broadcastMessage = "BRDM";
  static const String deleteMessage = "DELM";
  static const String delivery = "DLVR";
  static const String read = "READ";
  static const String reaction = "MRCT";
  static const String thread = "MTHD";
  static const String userEvent = "USEV";
  static const String systemEvent = "SYEV";
  static const String sessionExpired = "EXPR";
  static const String error = "EROR";

  static const String login = "LOGI";
  static const String enter = "ENTR";
  static const String exit = "EXIT";
  static const String mack = "MACK";
  static const String typingStart = "TPST";
  static const String typingEnd = "TPEN";
  static const String ping = "PING";

  static bool isUserMessage(String cmd) {
    return userMessage == cmd || userMessageUpdate == cmd;
  }

  static bool isFileMessage(String cmd) {
    return fileMessage == cmd || fileMessageUpdate == cmd;
  }

  static bool isAdminMessage(String cmd) {
    return adminMessage == cmd ||
        adminMessageUpdate == cmd ||
        broadcastMessage == cmd;
  }
}
