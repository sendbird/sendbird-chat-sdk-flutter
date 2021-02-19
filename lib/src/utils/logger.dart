import 'package:logger/logger.dart';
import 'package:sendbirdsdk/sendbirdsdk.dart';

var logger = Logger(
  level: Level.nothing,
  printer: PrettyPrinter(
    methodCount: 0, // number of method calls to be displayed
    errorMethodCount: 8, // number of method calls if stacktrace is provided
    lineLength: 150, // width of the output
    colors: true, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    printTime: false, // Should each log print contain a timestamp
  ),
);

Level convertLogLevel(LogLevel level) {
  switch (level) {
    case LogLevel.debug:
      return Level.debug;
    case LogLevel.error:
      return Level.error;
    case LogLevel.info:
      return Level.info;
    case LogLevel.nothing:
      return Level.nothing;
    case LogLevel.verbose:
      return Level.verbose;
    case LogLevel.warning:
      return Level.warning;
    case LogLevel.wtf:
      return Level.wtf;
    default:
      return Level.nothing;
  }
}
