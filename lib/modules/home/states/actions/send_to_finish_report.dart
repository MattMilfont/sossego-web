import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/home/models/report_model.dart';
import 'package:sossego_web/modules/home/states/atoms/finish_report_atom.dart';
import 'package:sossego_web/modules/home/states/finish_report_state.dart';

final sendToFinishReport = atomAction1<ReportModel>((set, report) async {
  set(finishReportState, SelectedState(selectedReport: report));

  Modular.to.pushNamed('/home/finishReport');
});
