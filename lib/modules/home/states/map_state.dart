import 'package:sossego_web/modules/home/models/report_model.dart';

sealed class MapState {
  T when<T>({
    required T Function() init,
    T Function(SelectedState s)? selected,
    T Function(ErrorMapState e)? error,
  }) {
    return switch (this) {
      InitMapState _ => init(),
      final SelectedState s => selected?.call(s) ?? init(),
      final ErrorMapState e => error?.call(e) ?? init(),
    };
  }
}

class InitMapState extends MapState {}

class SelectedState extends MapState {
  ReportModel selectedReport;
  SelectedState({required this.selectedReport});
}

class ErrorMapState extends MapState {
  String erroMsg;
  ErrorMapState({required this.erroMsg});
}
