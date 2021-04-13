import 'package:logger/logger.dart';
import 'package:sendbird_sdk/constant/enums.dart';

var logger = Logger(
  level: Level.nothing,
  printer: PrefixPrinter(
    PrettyPrinter(
      methodCount: 0, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 100, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true, // Should each log print contain a timestamp
    ),
    info: '[Sendbird][I]',
    error: '[Sendbird][E]',
    warning: '[Sendbird][W]',
  ),
);

void initLogger(LogLevel lvl) {
  final level = convertLogLevel(lvl);
  logger = Logger(
    level: level,
    printer: PrefixPrinter(
      PrettyPrinter(
        methodCount: 0, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 100, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false, // Should each log print contain a timestamp
      ),
      info: '[Sendbird][I]',
      error: '[Sendbird][E]',
      warning: '[Sendbird][W]',
    ),
  );
}

Level convertLogLevel(LogLevel level) {
  switch (level) {
    case LogLevel.error:
      return Level.error;
    case LogLevel.info:
      return Level.info;
    case LogLevel.none:
      return Level.nothing;
    case LogLevel.verbose:
      return Level.verbose;
    case LogLevel.warning:
      return Level.warning;
    default:
      return Level.nothing;
  }
}
