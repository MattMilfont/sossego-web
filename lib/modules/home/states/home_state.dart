import 'package:sossego_web/modules/home/models/report_model.dart';

sealed class HomeState {
  T when<T>({
    required T Function() init,
    T Function(SuccessHomeState s)? success,
    T Function(EmptyHomeState m)? empty,
    T Function(ErrorHomeState e)? error,
    T Function(LoadingHomeState l)? loading,
  }) {
    return switch (this) {
      InitHomeState _ => init(),
      final SuccessHomeState s => success?.call(s) ?? init(),
      final EmptyHomeState m => empty?.call(m) ?? init(),
      final ErrorHomeState e => error?.call(e) ?? init(),
      final LoadingHomeState l => loading?.call(l) ?? init(),
    };
  }
}

class InitHomeState extends HomeState {}

class SuccessHomeState extends HomeState {
  List<ReportModel> reports;
  SuccessHomeState({required this.reports});
}

class LoadingHomeState extends HomeState {}

class EmptyHomeState extends HomeState {}

class ErrorHomeState extends HomeState {
  String erroMsg;
  ErrorHomeState({required this.erroMsg});
}
