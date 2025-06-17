import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/home/services/finish_report_service.dart';
import 'package:sossego_web/modules/home/states/atoms/finish_report_atom.dart';
import 'package:sossego_web/modules/home/states/finish_report_state.dart';

final finishReport = atomAction2<int, String>((set, idReport, solution) async {
  try {
    final response = await FinishReportService().solveReport(
      idReport,
      solution,
    );
    if (response == 200) {
      set(finishReportState, InitFinishReportState());
      Modular.to.popAndPushNamed('/home');
    } else {
      set(
        finishReportState,
        ErrorFinishReportState(
          erroMsg: 'Não foi possível finalizar denúncia, tente novamente!',
        ),
      );
    }
  } catch (e) {
    print(e.toString());
    set(
      finishReportState,
      ErrorFinishReportState(
        erroMsg: 'Não foi possível finalizar denúncia, tente novamente!',
      ),
    );
  }
});
