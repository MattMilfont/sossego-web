import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/heatmap/states/actions/get_reports_heatmap.dart';
import 'package:sossego_web/modules/heatmap/states/atoms/heatmap_atom.dart';
import 'package:sossego_web/modules/heatmap/views/components/heatmap.dart';
import 'package:sossego_web/utils/app_colors.dart';

class HeatmapPage extends StatefulWidget {
  const HeatmapPage({super.key});

  @override
  State<HeatmapPage> createState() => _HeatmapPageState();
}

class _HeatmapPageState extends State<HeatmapPage> with HookStateMixin {
  @override
  void initState() {
    getReportsHeatmap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = useAtomState(heatmapState);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        title: Text(
          'Mapa de Calor das Denúncias',
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
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: 0.9 * width,
                      height: 0.8 * height,
                      child: HeatMapWidget(reports: s.reports),
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
