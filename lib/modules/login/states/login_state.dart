sealed class LoginState {
  T when<T>({
    required T Function() init,
    T Function(SucessLoginState s)? success,
    T Function(ErrorLoginState s)? error,
    T Function(LoadingLoginState s)? loading,
  }) {
    return switch (this) {
      InitLoginState _ => init(),
      final SucessLoginState s => success?.call(s) ?? init(),
      final ErrorLoginState s => error?.call(s) ?? init(),
      final LoadingLoginState s => loading?.call(s) ?? init(),
    };
  }
}

class InitLoginState extends LoginState {}

class SucessLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  String erroMsg;
  ErrorLoginState({required this.erroMsg});
}