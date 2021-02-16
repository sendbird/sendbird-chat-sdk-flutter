// import '../services/session/session_manager.dart';

import 'package:sendbirdsdk/sendbirdsdk.dart';

class RequestValidator {
  static Future<bool> readyToExecuteApiRequest() async {
    // final sessionKey = await SessionManager().getSessionKey();
    // if (sessionKey != null && sessionKey.length > 0) {
    //   //ios has reconnect socket logic here but why..?
    //   return true;
    // }

    return true;
  }

  static Future<Error> readyToExecuteWsRequest() async {
    //check ws client connection
    if (true) {
      //if connetion is available
      return null;
    }

    return WebSocketError();
  }
}
