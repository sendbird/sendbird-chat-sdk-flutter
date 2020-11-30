abstract class Operation {}

class AsyncOperation<T> implements Operation {
  Future Function(T) fnc;
  T arg;

  AsyncOperation({this.fnc, this.arg});
}

class AsyncOperation2<T, D> implements Operation {
  Future Function(T, D) fnc;
  T arg;
  D arg2;

  AsyncOperation2(this.fnc, this.arg, this.arg2);
}
