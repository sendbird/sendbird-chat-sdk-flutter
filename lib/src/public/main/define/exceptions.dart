// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/public/main/define/sendbird_error.dart';

/// SendbirdException
class SendbirdException implements Exception {
  String? name;
  int? code;
  String? message;

  SendbirdException({this.name, this.code, this.message});

  @override
  String toString() {
    final nameString = name != null ? '$name' : (SendbirdException).toString();
    final codeString = code != null ? '($code)' : '';
    final messageString = message != null ? ': $message' : '';
    return '$nameString$codeString$messageString';
  }
}

/// LoginTimeoutException
class LoginTimeoutException extends SendbirdException {
  LoginTimeoutException()
      : super(
            name: (LoginTimeoutException).toString(),
            code: SendbirdError.loginTimeout);
}

/// AckTimeoutException
class AckTimeoutException extends SendbirdException {
  AckTimeoutException()
      : super(
            name: (AckTimeoutException).toString(),
            code: SendbirdError.ackTimeout);
}

/// ConnectionRequiredException
class ConnectionRequiredException extends SendbirdException {
  ConnectionRequiredException()
      : super(
            name: (ConnectionRequiredException).toString(),
            code: SendbirdError.connectionRequired);
}

/// ConnectionCanceledException
class ConnectionCanceledException extends SendbirdException {
  ConnectionCanceledException()
      : super(
            name: (ConnectionCanceledException).toString(),
            code: SendbirdError.connectionCanceled);
}

/// WebSocketFailedException
class WebSocketFailedException extends SendbirdException {
  WebSocketFailedException({int? code, String? message})
      : super(
            name: (WebSocketFailedException).toString(),
            code: code ?? SendbirdError.webSocketConnectionFailed,
            message: message);
}

/// RequestFailedException
class RequestFailedException extends SendbirdException {
  RequestFailedException({int? code, String? message})
      : super(
            name: (RequestFailedException).toString(),
            code: code ?? SendbirdError.requestFailed,
            message: message);
}

/// InvalidInitializationException
class InvalidInitializationException extends SendbirdException {
  InvalidInitializationException()
      : super(
            name: (InvalidInitializationException).toString(),
            code: SendbirdError.invalidInitialization);
}

/// InvalidCollectionDisposedException
class InvalidCollectionDisposedException extends SendbirdException {
  InvalidCollectionDisposedException()
      : super(
            name: (InvalidCollectionDisposedException).toString(),
            code: SendbirdError.invalidCollectionDisposed);
}

/// InvalidParameterException
class InvalidParameterException extends SendbirdException {
  InvalidParameterException()
      : super(
            name: (InvalidParameterException).toString(),
            code: SendbirdError.invalidParameter);
}

/// NotSupportedException
class NotSupportedException extends SendbirdException {
  NotSupportedException()
      : super(
            name: (NotSupportedException).toString(),
            code: SendbirdError.notSupported);
}

/// QueryInProgressException
class QueryInProgressException extends SendbirdException {
  QueryInProgressException()
      : super(
            name: (QueryInProgressException).toString(),
            code: SendbirdError.queryInProgress);
}

/// MarkAsReadRateLimitExceededException
class MarkAsReadRateLimitExceededException extends SendbirdException {
  MarkAsReadRateLimitExceededException()
      : super(
            name: (MarkAsReadRateLimitExceededException).toString(),
            code: SendbirdError.markAsReadRateLimitExceeded);
}

/// MalformedException
class MalformedDataException extends SendbirdException {
  MalformedDataException()
      : super(
            name: (MalformedDataException).toString(),
            code: SendbirdError.malformedData);
}

/// BadRequestException
class BadRequestException extends SendbirdException {
  BadRequestException({String? message, int? code})
      : super(
            name: (BadRequestException).toString(),
            code: code,
            message: message);
}

/// UnauthorizedException
class UnauthorizedException extends SendbirdException {
  UnauthorizedException({String? message, int? code})
      : super(
            name: (UnauthorizedException).toString(),
            code: code,
            message: message);
}

/// InternalServerException
class InternalServerException extends SendbirdException {
  InternalServerException({String? message, int? code})
      : super(
            name: (InternalServerException).toString(),
            code: code,
            message: message);
}

/// FileSizeLimitExceededException
class FileSizeLimitExceededException extends SendbirdException {
  FileSizeLimitExceededException()
      : super(
            name: (FileSizeLimitExceededException).toString(),
            code: SendbirdError.fileSizeLimitExceeded);
}

/// SessionKeyRefreshFailedException
class SessionKeyRefreshFailedException extends SendbirdException {
  SessionKeyRefreshFailedException()
      : super(
            name: (SessionKeyRefreshFailedException).toString(),
            code: SendbirdError.sessionKeyRefreshFailed);
}

/// AccessTokenRevokedException
class AccessTokenRevokedException extends SendbirdException {
  AccessTokenRevokedException()
      : super(
            name: (AccessTokenRevokedException).toString(),
            code: SendbirdError.accessTokenRevoked);
}

/// InvalidAccessTokenException
class InvalidAccessTokenException extends SendbirdException {
  InvalidAccessTokenException()
      : super(
            name: (InvalidAccessTokenException).toString(),
            code: SendbirdError.passedInvalidAccessToken);
}

/// OperationCanceledException
class OperationCanceledException extends SendbirdException {
  OperationCanceledException()
      : super(name: (OperationCanceledException).toString());
}

/// InvalidMessageTypeException
class InvalidMessageTypeException extends SendbirdException {
  InvalidMessageTypeException()
      : super(name: (InvalidMessageTypeException).toString());
}
