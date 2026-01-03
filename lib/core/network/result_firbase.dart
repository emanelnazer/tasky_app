sealed class ResultFB<T> {}

class SucessFB<T> extends ResultFB<T> {
  final T data;
  SucessFB({required this.data});
}

class ErrorFB<T> extends ResultFB<T> {
  final String message;
  ErrorFB(this.message);
}
