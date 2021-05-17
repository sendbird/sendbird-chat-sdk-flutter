abstract class Operation {
  Function() onCancel;
}

class AsyncSimpleTask implements Operation {
  @override
  Function() onCancel;
  Future Function() func;

  AsyncSimpleTask(this.func, {this.onCancel});
}

class AsyncTask<T> implements Operation {
  @override
  Function() onCancel;
  Future Function(T) func;
  T arg;

  AsyncTask({this.func, this.arg, this.onCancel});
}

class AsyncTask2<T, D> implements Operation {
  @override
  Function() onCancel;
  Future Function(T, D) func;
  T arg;
  D arg2;

  AsyncTask2(this.func, this.arg, this.arg2, {this.onCancel});
}
