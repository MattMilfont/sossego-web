import 'package:asp/asp.dart';
import 'package:sossego_web/modules/dashboard/services/get_dashboard_data_services.dart';
import 'package:sossego_web/modules/dashboard/states/atoms/dashboard_atom.dart';
import 'package:sossego_web/modules/dashboard/states/dashboard_state.dart';

final getDashboardData = atomAction((set) async {
  set(dashboardState, LoadingDashboardState());
  try {
    final activeReports = await GetDashboardDataService().getActiveReports();
    final solvedReports = await GetDashboardDataService().getSolvedReports();
    final reports = await GetDashboardDataService().getAllReports();

    set(
      dashboardState,
      SuccessDashboardState(
        activeReports: activeReports!,
        solvedReports: solvedReports!,
        reports: reports!,
      ),
    );
  } catch (e) {
    print('Erro: $e');
    set(
      dashboardState,
      ErrorDashboardState(
        erroMsg: 'Erro Interno no servidor, tente novemente mais tarde.',
      ),
    );
  }
});
