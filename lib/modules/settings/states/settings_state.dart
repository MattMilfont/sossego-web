sealed class SettingsState {
  T when<T>({
    required T Function() init,
    T Function(SuccessSettingsState s)? success,
    T Function(ErrorSettingsState s)? error,
    T Function(LoadingSettingsState s)? loading,
  }) {
    return switch (this) {
      InitSettingsState _ => init(),
      final SuccessSettingsState s => success?.call(s) ?? init(),
      final ErrorSettingsState s => error?.call(s) ?? init(),
      final LoadingSettingsState s => loading?.call(s) ?? init(),
    };
  }
}

class InitSettingsState extends SettingsState {}

class SuccessSettingsState extends SettingsState {
  String successMsg;
  SuccessSettingsState({required this.successMsg});
}

class LoadingSettingsState extends SettingsState {}

class ErrorSettingsState extends SettingsState {
  String erroMsg;
  ErrorSettingsState({required this.erroMsg});
}