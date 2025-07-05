import 'package:sossego_web/modules/home/models/report_model.dart';

sealed class HeatmapState {
  T when<T>({
    required T Function() init,
    T Function(SuccessHeatmapState s)? success,
    T Function(EmptyHeatmapState m)? empty,
    T Function(ErrorHeatmapState e)? error,
    T Function(LoadingHeatmapState l)? loading,
  }) {
    return switch (this) {
      InitHeatmapState _ => init(),
      final SuccessHeatmapState s => success?.call(s) ?? init(),
      final EmptyHeatmapState m => empty?.call(m) ?? init(),
      final ErrorHeatmapState e => error?.call(e) ?? init(),
      final LoadingHeatmapState l => loading?.call(l) ?? init(),
    };
  }
}

class InitHeatmapState extends HeatmapState {}

class SuccessHeatmapState extends HeatmapState {
  List<ReportModel> reports;
  SuccessHeatmapState({required this.reports});
}

class LoadingHeatmapState extends HeatmapState {}

class EmptyHeatmapState extends HeatmapState {}

class ErrorHeatmapState extends HeatmapState {
  String erroMsg;
  ErrorHeatmapState({required this.erroMsg});
}
