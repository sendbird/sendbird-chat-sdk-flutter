abstract class Operation {}

class AsyncSimpleTask implements Operation {
  Future Function() func;

  AsyncSimpleTask(this.func);
}

class AsyncTask<T> implements Operation {
  Future Function(T) func;
  T arg;

  AsyncTask({this.func, this.arg});
}

class AsyncTask2<T, D> implements Operation {
  Future Function(T, D) func;
  T arg;
  D arg2;

  AsyncTask2(this.func, this.arg, this.arg2);
}
