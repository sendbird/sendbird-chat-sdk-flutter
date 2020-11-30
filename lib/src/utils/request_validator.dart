// import '../services/session/session_manager.dart';

class RequestValidator {
  static Future<bool> readyToExecuteApiRequest() async {
    // final sessionKey = await SessionManager().getSessionKey();
    // if (sessionKey != null && sessionKey.length > 0) {
    //   //ios has reconnect socket logic here but why..?
    //   return true;
    // }

    return true;
  }

  static Future<bool> readyToExecuteWsRequest() async {
    //check ws client connection
    if (true) {
      //if connetion is available
      return true;
    }

    return false;
  }
}
