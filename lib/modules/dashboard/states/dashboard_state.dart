import 'package:sossego_web/modules/home/models/report_model.dart';

sealed class DashboardState {
  T when<T>({
    required T Function() init,
    T Function(SuccessDashboardState s)? success,
    T Function(EmptyDashboardState m)? empty,
    T Function(ErrorDashboardState e)? error,
    T Function(LoadingDashboardState l)? loading,
  }) {
    return switch (this) {
      InitDashboardState _ => init(),
      final SuccessDashboardState s => success?.call(s) ?? init(),
      final EmptyDashboardState m => empty?.call(m) ?? init(),
      final ErrorDashboardState e => error?.call(e) ?? init(),
      final LoadingDashboardState l => loading?.call(l) ?? init(),
    };
  }
}

class InitDashboardState extends DashboardState {}

class SuccessDashboardState extends DashboardState {
  List<ReportModel> activeReports;
  List<ReportModel> solvedReports;
  List<ReportModel> reports;

  SuccessDashboardState({
    required this.activeReports,
    required this.solvedReports,
    required this.reports,
  });
}

class LoadingDashboardState extends DashboardState {}

class EmptyDashboardState extends DashboardState {}

class ErrorDashboardState extends DashboardState {
  String erroMsg;
  ErrorDashboardState({required this.erroMsg});
}
