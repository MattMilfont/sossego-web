import 'package:asp/asp.dart';
import 'package:sossego_web/modules/home/models/report_model.dart';
import 'package:sossego_web/modules/home/states/atoms/map_atom.dart';
import 'package:sossego_web/modules/home/states/map_state.dart';

final selectReport = atomAction1<ReportModel>((set, report) async {
  set(mapState, SelectedState(selectedReport: report));
});
