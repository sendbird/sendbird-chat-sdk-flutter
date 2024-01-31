// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'chat.dart';

extension ChatAuth on Chat {
  Future<User> authenticateFeed(
    String userId, {
    String? accessToken,
    String? apiHost,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    listenAppLifecycleState(); // Check

    if (chatContext.currentUser != null) {
      if (chatContext.currentUser!.userId == userId) {
        if (chatContext.isChatConnected) {
          return chatContext.currentUser!;
        }
      } else {
        if (chatContext.isChatConnected) {
          throw RequestFailedException(
              message:
                  'Already logged in as a different user. Call disconnect() first.');
        }
        if (chatContext.isFeedAuthenticated) {
          await disconnect();
        }
      }
    }

    connectionManager.setLoginInfo(
      fromWebSocket: false,
      userId: userId,
      accessToken: accessToken,
      apiHost: apiHost,
    );

    await eventDispatcher.onConnecting(); // Check

    try {
      return await apiClient.send<User>(AuthenticateFeedRequest(
        this,
        userId,
        accessToken: accessToken,
        apiHost: apiHost,
      ));
    } on SendbirdException catch (e) {
      //+ [DBManager]
      if (dbManager.isEnabled()) {
        final user = await dbManager.getLoginInfoByException(userId, e);
        if (user != null) {
          return user;
        }
      }
      //- [DBManager]

      if (e.code == SendbirdError.accessTokenNotValid) {
        eventManager.notifySessionError(InvalidAccessTokenException());
        throw InvalidAccessTokenException();
      }
      rethrow;
    }
  }

  void refreshNotificationCollections() {
    collectionManager.refreshNotificationCollections();
  }
}
