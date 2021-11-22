import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/error_code.dart';

part 'error.g.dart';

@JsonSerializable()
class SBError extends Error {
  String? message;
  int? code;

  SBError({this.message, this.code = 1});

  void byaction(String erraction) {
    message = erraction;
  }

  factory SBError.fromJson(Map<String, dynamic> json) =>
      _$SBErrorFromJson(json);
  Map<String, dynamic> toJson() => _$SBErrorToJson(this);
}

class InvalidInitializationError extends SBError {
  @override
  int get code => ErrorCode.invalidInitialization;
}

class LoginTimeoutError extends SBError {
  @override
  int get code => ErrorCode.loginTimeout;
}

class AckTimeoutError extends SBError {
  @override
  int get code => ErrorCode.ackTimeout;
}

class ConnectionRequiredError extends SBError {
  @override
  int get code => ErrorCode.connectionRequired;
}

class ConnectionCancelError extends SBError {
  @override
  int get code => ErrorCode.connectionCanceled;
}

class ConnectionClosedError extends SBError {}

class ConnectionFailedError extends SBError {}

class MisConfigurationError extends SBError {}

class WebSocketError extends SBError {
  WebSocketError({int? code, String? message})
      : super(code: code, message: message);
}

class WebSocketConnectionFailed extends SBError {
  @override
  int get code => ErrorCode.webSocketConnectionFailed;
}

class WebSocketConnectionClosedError extends SBError {
  @override
  int get code => ErrorCode.webSocketConnectionClosed;
}

class WebSocketTimeoutError extends SBError {}

class InvalidParameterError extends SBError {
  @override
  int get code => ErrorCode.invalidParameter;
}

class QueryInProgressError extends SBError {
  @override
  int get code => ErrorCode.queryInProgress;
}

class MarkAsReadRateLimitExceededError extends SBError {
  @override
  int get code => ErrorCode.markAsReadRateLimitExceeded;
}

class MalformedError extends SBError {
  @override
  int get code => ErrorCode.malformedData;
}

class BadRequestError extends SBError {
  BadRequestError({String? message, int? code})
      : super(message: message, code: code);
}

class UnauthorizeError extends SBError {
  UnauthorizeError({String? message, int? code})
      : super(message: message, code: code);
}

class InternalServerError extends SBError {
  InternalServerError({String? message, int? code})
      : super(message: message, code: code);
}

class FileSizeLimitExceededError extends SBError {
  @override
  int get code => ErrorCode.fileSizeLimitExceeded;
}

class SessionKeyRefreshSucceededError extends SBError {
  @override
  int get code => ErrorCode.sessionKeyRefreshSucceeded;
}

class SessionKeyRefreshFailedError extends SBError {
  @override
  int get code => ErrorCode.sessionKeyRefreshFailed;
}

class InvalidAccessTokenError extends SBError {
  @override
  int get code => ErrorCode.passedInvalidAccessToken;
}

class UnrecognizedTypeError extends SBError {}

class UnrecognizedMessageTypeError extends SBError {}

class UnknownError extends SBError {}

class NotFoundError extends SBError {}

class OperationCancelError extends SBError {}
