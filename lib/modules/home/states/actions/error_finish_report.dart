import 'package:asp/asp.dart';
import 'package:sossego_web/modules/home/states/atoms/finish_report_atom.dart';
import 'package:sossego_web/modules/home/states/finish_report_state.dart';

final errorFinishReport = atomAction1<String>((set, error) async {
  set(finishReportState, ErrorFinishReportState(erroMsg: error));
});
