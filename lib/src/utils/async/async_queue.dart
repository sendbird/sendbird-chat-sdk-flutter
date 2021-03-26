import 'dart:async';
import 'dart:collection';

import 'async_operation.dart';

class AsyncQueue<T> {
  bool _scheduled = false;

  Queue<Operation> _queue = Queue<Operation>();
  Map<int, Completer> _completers = {};

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

  Future _execute() async {
    while (true) {
      if (_queue.isEmpty) {
        _scheduled = false;
        return;
      }

      var first = _queue.removeFirst();
      if (first is AsyncTask<T>) {
        final res = await first.func(first.arg);
        _completers.remove(first.hashCode)?.complete(res);
      } else if (first is AsyncSimpleTask) {
        await first.func();
        _completers.remove(first.hashCode)?.complete();
      }
    }
  }

  void cleanUp() {
    _queue.removeWhere((element) => true);
  }
}
