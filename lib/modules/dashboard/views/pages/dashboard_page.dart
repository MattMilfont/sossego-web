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
                      padding: const EdgeInsets.all(30),
                      child: Card(
                        color: AppColors.primaryColor,
                        child: SizedBox(
                          width: width * 0.2,
                          height: height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                s.reports.length.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Total de Denúncias',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Card(
                        color: AppColors.primaryColor,
                        child: SizedBox(
                          width: width * 0.2,
                          height: height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                s.activeReports.length.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Denúncias Ativas',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Card(
                        color: AppColors.primaryColor,
                        child: SizedBox(
                          width: width * 0.2,
                          height: height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                s.solvedReports.length.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Denúncias Resolvidas',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Denúncias em Geral',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 0.4 * width,
                            height: 0.4 * height,
                            child: ReportsMonthsGraphic(
                              reports: s.reports,
                              columnColor: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Denúncias Resolvidas',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 0.4 * width,
                            height: 0.4 * height,
                            child: ReportsMonthsGraphic(
                              reports: s.solvedReports,
                              columnColor: AppColors.error,
                            ),
                          ),
                        ],
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
