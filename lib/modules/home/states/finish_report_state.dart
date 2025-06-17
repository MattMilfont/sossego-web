import 'package:sossego_web/modules/home/models/report_model.dart';

sealed class FinishReportState {
  T when<T>({
    required T Function() init,
    T Function(SelectedState s)? selected,
    T Function(ErrorFinishReportState e)? error,
  }) {
    return switch (this) {
      InitFinishReportState _ => init(),
      final SelectedState s => selected?.call(s) ?? init(),
      final ErrorFinishReportState e => error?.call(e) ?? init(),
    };
  }
}

class InitFinishReportState extends FinishReportState {}

class SelectedState extends FinishReportState {
  ReportModel selectedReport;
  SelectedState({required this.selectedReport});
}

class ErrorFinishReportState extends FinishReportState {
  String erroMsg;
  ErrorFinishReportState({required this.erroMsg});
}
