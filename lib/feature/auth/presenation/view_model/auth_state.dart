abstract class AuthState {}

class IntialState extends AuthState {}

class LoadingState extends AuthState {}

class SucessState extends AuthState {}

class ErrorSate extends AuthState {
  ErrorSate(this.ErrorMessage);
  final String ErrorMessage;
}
