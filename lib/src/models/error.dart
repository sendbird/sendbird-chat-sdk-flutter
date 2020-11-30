import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable()
class SBError extends Error {
  String message;
  int code;

  SBError({this.message, this.code});

  void byaction(String erraction) {
    message = erraction;
  }

  factory SBError.fromJson(Map<String, dynamic> json) =>
      _$SBErrorFromJson(json);
  Map<String, dynamic> toJson() => _$SBErrorToJson(this);
}

class ConnectionRequiredError extends SBError {}

class ConnectionClosedError extends SBError {}

class WebSocketError extends SBError {
  WebSocketError({int code, String message})
      : super(code: code, message: message);
}

class WebSocketDisconnectError extends SBError {}

class WebSocketTimeoutError extends SBError {}

class InvalidParameterError extends SBError {}

class QueryInProgressError extends SBError {}

class BadRequestError extends SBError {
  BadRequestError({String message, int code})
      : super(message: message, code: code);
}

class UnauthorizeError extends SBError {
  UnauthorizeError({String message, int code})
      : super(message: message, code: code);
}

class InternalServerError extends SBError {
  InternalServerError({String message, int code})
      : super(message: message, code: code);
}

class UnknownError extends SBError {}
