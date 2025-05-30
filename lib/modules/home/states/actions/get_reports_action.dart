import 'package:asp/asp.dart';
import 'package:sossego_web/modules/home/services/get_reports_service.dart';
import 'package:sossego_web/modules/home/states/atoms/home_atom.dart';
import 'package:sossego_web/modules/home/states/home_state.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';

final getReportsUser = atomAction((set) async {
  set(homeState, LoadingHomeState());
  try {
    final reports = await GetReportsUserService().getReportsUser(
      userData.state?.user!.id,
    );
    if (reports!.isNotEmpty) {
      set(homeState, SuccessHomeState(reports: reports));
    } else {
      set(homeState, EmptyHomeState());
    }
  } catch (e) {
    print('Erro: $e');
    set(
      homeState,
      ErrorHomeState(
        erroMsg: 'Erro Interno no servidor, tente novemente mais tarde.',
      ),
    );
  }
});
