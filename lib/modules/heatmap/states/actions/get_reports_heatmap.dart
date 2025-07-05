import 'package:asp/asp.dart';
import 'package:sossego_web/modules/dashboard/services/get_dashboard_data_services.dart';
import 'package:sossego_web/modules/heatmap/states/atoms/heatmap_atom.dart';
import 'package:sossego_web/modules/heatmap/states/heatmap_state.dart';

final getReportsHeatmap = atomAction((set) async {
  set(heatmapState, LoadingHeatmapState());
  try {
    final reports = await GetDashboardDataService().getAllReports();
    set(heatmapState, SuccessHeatmapState(reports: reports!));
  } catch (e) {
    ErrorHeatmapState(erroMsg: e.toString());
  }
});
