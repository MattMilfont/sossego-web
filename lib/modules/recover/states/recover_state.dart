sealed class RecoverState {
  T when<T>({
    required T Function() init,
    T Function(SuccessRecoverState s)? success,
    T Function(ErrorRecoverState s)? error,
    T Function(LoadingRecoverState s)? loading,
  }) {
    return switch (this) {
      InitRecoverState _ => init(),
      final SuccessRecoverState s => success?.call(s) ?? init(),
      final ErrorRecoverState s => error?.call(s) ?? init(),
      final LoadingRecoverState s => loading?.call(s) ?? init(),
    };
  }
}

class InitRecoverState extends RecoverState {}

class SuccessRecoverState extends RecoverState {}

class LoadingRecoverState extends RecoverState {}

class ErrorRecoverState extends RecoverState {
  String erroMsg;
  ErrorRecoverState({required this.erroMsg});
}