// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:logger/logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/logger_stack_trace.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

final sbLog = SendbirdLogger();

class SendbirdLogger {
  Logger logger;

  static final _instance = SendbirdLogger._();

  SendbirdLogger._() : logger = Logger(level: Level.nothing) {
    _setLogLevel(Level.nothing);
  }

  factory SendbirdLogger() => _instance;

  void setLogLevel(LogLevel level) {
    _setLogLevel(_convertLogLevel(level));
  }

  void setLogLevelForTest() {
    _setLogLevel(Level.nothing);
  }

  void e(StackTrace stackTrace, [String? message]) {
    logger.e('${_getLogPrefix(stackTrace)} ${message ?? ''}');
  }

  void w(StackTrace stackTrace, [String? message]) {
    logger.w('${_getLogPrefix(stackTrace)} ${message ?? ''}');
  }

  void i(StackTrace stackTrace, [String? message]) {
    logger.i('${_getLogPrefix(stackTrace)} ${message ?? ''}');
  }

  void d(StackTrace stackTrace, [String? message]) {
    logger.d('${_getLogPrefix(stackTrace)} ${message ?? ''}');
  }

  void v(StackTrace stackTrace, [String? message]) {
    logger.v('${_getLogPrefix(stackTrace)} ${message ?? ''}');
  }

  void _setLogLevel(Level level) {
    logger = Logger(
        level: level,
        printer: PrefixPrinter(
          PrettyPrinter(
            methodCount: 0,
            // number of method calls to be displayed
            errorMethodCount: 8,
            // number of method calls if stacktrace is provided
            lineLength: 100,
            // width of the output
            colors: true,
            // Colorful log messages
            printEmojis: false,
            // Print an emoji for each log message
            printTime: true, // Should each log print contain a timestamp
          ),
          error: '[E]',
          warning: '[W]',
          info: '[I]',
          debug: '[D]',
          verbose: '[V]',
        ));
  }

  String _getLogPrefix(StackTrace stackTrace) {
    final trace = LoggerStackTrace.from(stackTrace);
    // return '[${trace.fileName}][${trace.functionName}]';
    return '[${trace.functionName}]';
  }

  Level _convertLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.error:
        return Level.error;
      case LogLevel.warning:
        return Level.warning;
      case LogLevel.info:
        return Level.info;
      case LogLevel.none:
        return Level.nothing;

      default:
        return Level.nothing;
    }
  }
}
