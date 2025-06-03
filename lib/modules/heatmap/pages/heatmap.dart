import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:sossego_web/modules/home/states/actions/get_reports_action.dart';
import 'package:sossego_web/modules/home/states/atoms/home_atom.dart';
import 'package:sossego_web/modules/home/views/components/heatmap.dart';
import 'package:sossego_web/modules/home/views/components/report_card.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';
import 'package:sossego_web/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HookStateMixin {
  @override
  void initState() {
    getReportsUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = useAtomState(userData);
    final state = useAtomState(homeState);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        title: Text(
          'Bem-vindo, ${userInfo!.user!.name}!',
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
          IconButton(
            onPressed: () => Modular.to.pushNamed('/reports'),
            icon: Icon(Icons.add, color: AppColors.white),
          ),
        ],
      ),
      body: state.when(
        init:
            () => Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
        success: (s) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: s.reports.length,
                  itemBuilder: (context, index) {
                    final report = s.reports[index];
                    final date = DateFormat(
                      'dd/MM/yyyy',
                    ).format(DateTime.parse(report.reportDate!));
                    return SizedBox(
                      width: 400,
                      child: ReportCard(
                        report: report,
                        reportDate: date,
                        reportTitle: report.reportsType!,
                        image: report.archive64!,
                        reportDescription:
                            'Volume Sonoro acima do permitido por legislação',
                        reportAddress: '${report.address!}, ${report.number!}',
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 20), // espaçamento
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: 0.6 * width,
                      height: 0.8 * height,
                      child: HeatMapWidget(),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        empty:
            (m) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Não há denúncias feitas por você ainda',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Modular.to.pushNamed('/reports'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.primaryColor,
                      ),
                    ),
                    child: Text(
                      'Nova Denúncia',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
