// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';

/// A handler required on refreshing the session key on expiration.
/// This should be added by [SendbirdChat.setSessionHandler] before the connection by [SendbirdChat.connect].
abstract class SessionHandler {
  /// App needs to fetch a new token and pass on the new token to SDK via [AccessTokenRequester.onSuccess],
  /// or [AccessTokenRequester.onFail] if error has occurred during the fetch.
  ///
  /// In case when app decides not to refresh the session for the user,
  /// they should call [AccessTokenRequester.onSuccess] with `null` as a token value.
  void onAccessTokenRequired(AccessTokenRequester accessTokenRequester);

  /// Called when:
  ///   1. the token has been revoked
  ///   2. the app has returned `null` as a new token value on [AccessTokenRequester.onSuccess].
  ///
  /// SDK disconnects the connection before calling this callback by
  /// [SendbirdChat.disconnect], so the app is recommended to direct a user to a
  /// login page to connect again.
  void onSessionClosed();

  /// Called after SDK successfully refreshes the session key.
  void onSessionRefreshed() {}

  /// Called when the SDK runs into an error while refreshing the session key.
  void onSessionError(SendbirdException e) {}
}

/// Interface that is passed on to [SessionHandler.onAccessTokenRequired].
/// After the application fetches the new accessToken, it should pass on the accessToken to SDK through [onSuccess].
/// If any error occurred during this process, it must call [onFail] to let SDK know the status.
abstract class AccessTokenRequester {
  /// Call this method after retrieving a new token.
  ///
  /// In case when app decides not to refresh the session for the user,
  /// they should call this with newToken as `null`.
  Future<void> onSuccess(String? newAccessToken);

  /// Call this method when failed to retrieve a new token.
  Future<void> onFail();
}
