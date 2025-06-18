import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/dashboard/states/actions/get_dashboard_data_action.dart';
import 'package:sossego_web/modules/dashboard/states/atoms/dashboard_atom.dart';
import 'package:sossego_web/modules/dashboard/views/components/reports_months_graphic.dart';
import 'package:sossego_web/utils/app_colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with HookStateMixin {
  @override
  void initState() {
    getDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = useAtomState(dashboardState);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        title: Text(
          'Dashboard de Denúncia',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('/settings'),
            icon: Icon(Icons.settings, color: AppColors.white),
          ),
        ],
      ),
      body: state.when(
        init:
            () => Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
        success: (s) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 0.4 * width,
                        height: 0.4 * height,
                        child: ReportsMonthsGraphic(reports: s.activeReports),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 0.4 * width,
                        height: 0.4 * height,
                        child: ReportsMonthsGraphic(reports: s.solvedReports),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 0.4 * width,
                        height: 0.4 * height,
                        child: ReportsMonthsGraphic(reports: s.reports),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 0.4 * width,
                        height: 0.4 * height,
                        child: ReportsMonthsGraphic(reports: s.solvedReports),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        empty:
            (m) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Não há denúncias feitas ainda',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
