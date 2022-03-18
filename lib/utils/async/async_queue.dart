import 'dart:async';
import 'dart:collection';
import 'package:sendbird_sdk/utils/logger.dart';

import 'async_operation.dart';

class AsyncQueue<T> {
  bool _scheduled = false;

  Queue<Operation> _queue = Queue<Operation>();
  Map<int, Completer> _completers = {};
  Operation? _currentOp;

  Future enqueue(Operation operation) {
    _queue.add(operation);
    final completer = Completer();
    _completers[operation.hashCode] = completer;

    if (!_scheduled) {
      _scheduled = true;
      Timer(Duration(seconds: 0), _execute);
    }

    return completer.future;
  }

  bool cancel(int hashCode) {
    final completer = _completers.remove(hashCode);
    if (completer != null && !completer.isCompleted) {
      if (_currentOp?.onCancel != null) {
        _currentOp?.onCancel!();
      }
      completer.complete();
      return true;
    }
    return false;
  }

  Future _execute() async {
    while (true) {
      if (_queue.isEmpty) {
        _scheduled = false;
        return;
      }

      var task = _queue.removeFirst();
      _currentOp = task;
      try {
        if (task is AsyncTask<T>) {
          final res = await task.func(task.arg);
          logger.i('completed async task ${task.func}');
          _completers.remove(task.hashCode)?.complete(res);
        } else if (task is AsyncSimpleTask) {
          await task.func();
          logger.i('completed async task ${task.func}');
          _completers.remove(task.hashCode)?.complete();
        }
      } catch (e) {
        logger.e('error while processing async task $task');
      }
    }
  }

  void cleanUp() {
    _queue.forEach((q) {
      cancel(q.hashCode);
    });
    _queue.removeWhere((element) => true);
    _currentOp = null;
  }
}
