// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

abstract class Operation {
  Function()? onCancel;
}

class AsyncSimpleTask implements Operation {
  @override
  Function()? onCancel;
  Future Function() func;

  AsyncSimpleTask(this.func, {this.onCancel});
}

class AsyncTask<T> implements Operation {
  @override
  Function()? onCancel;
  Future Function(T) func;
  T arg;

  AsyncTask({
    required this.func,
    required this.arg,
    this.onCancel,
  });
}
