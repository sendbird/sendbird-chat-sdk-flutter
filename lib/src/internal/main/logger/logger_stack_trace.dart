// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

class LoggerStackTrace {
  const LoggerStackTrace._({
    required this.functionName,
    required this.callerFunctionName,
    required this.fileName,
    required this.lineNumber,
    required this.columnNumber,
  });

  factory LoggerStackTrace.from(StackTrace trace) {
    final frames = trace.toString().split('\n');
    final functionName = _getFunctionNameFromFrame(frames[0]);
    final callerFunctionName = _getFunctionNameFromFrame(frames[1]);
    final fileInfo = _getFileInfoFromFrame(frames[0]);

    return LoggerStackTrace._(
      functionName: functionName,
      callerFunctionName: callerFunctionName,
      fileName: fileInfo.isNotEmpty ? fileInfo[0] : '',
      lineNumber: fileInfo.length >= 2 ? fileInfo[1] : '',
      columnNumber:
          fileInfo.length >= 3 ? fileInfo[2].replaceFirst(')', '') : '',
    );
  }

  final String functionName;
  final String callerFunctionName;
  final String fileName;
  final String lineNumber;
  final String columnNumber;

  static List<String> _getFileInfoFromFrame(String trace) {
    String fileInfo = trace;

    final indexOfFileName = trace.indexOf(RegExp('[_A-Za-z]+.dart'));
    if (indexOfFileName != -1) {
      fileInfo = trace.substring(indexOfFileName);
    }
    return fileInfo.split(':');
  }

  static String _getFunctionNameFromFrame(String trace) {
    String functionName = trace;

    final indexOfWhiteSpace = trace.indexOf(' ');
    if (indexOfWhiteSpace != -1) {
      functionName = trace.substring(indexOfWhiteSpace);
    }

    final indexOfFunction = functionName.indexOf(RegExp('[A-Za-z0-9]'));
    if (indexOfFunction != -1) {
      functionName = functionName.substring(indexOfFunction);

      final index = functionName.indexOf(' ');
      if (index != -1) {
        functionName = functionName.substring(0, index);
      }
    }
    return functionName;
  }

  @override
  String toString() {
    return 'LoggerStackTrace('
        'functionName: $functionName, '
        'callerFunctionName: $callerFunctionName, '
        'fileName: $fileName, '
        'lineNumber: $lineNumber, '
        'columnNumber: $columnNumber)';
  }
}
