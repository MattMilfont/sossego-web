import 'dart:async';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sossego_web/modules/home/states/actions/get_reports_action.dart';
import 'package:sossego_web/modules/home/states/actions/send_to_finish_report.dart';
import 'package:sossego_web/modules/home/states/atoms/home_atom.dart';
import 'package:sossego_web/modules/home/states/atoms/map_atom.dart';
import 'package:sossego_web/modules/home/views/components/report_card.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';
import 'package:sossego_web/utils/app_assets.dart';
import 'package:sossego_web/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HookStateMixin {
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    getReportsUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = useAtomState(userData);
    final state = useAtomState(homeState);
    final map = useAtomState(mapState);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final Set<Marker> markers = map.when(
      init:
          () => {
            const Marker(
              markerId: MarkerId('0'),
              position: LatLng(-23.5505, -46.6333),
              infoWindow: InfoWindow(title: 'Centro de Controle de Operações'),
            ),
          },
      selected: (s) {
        final latLng = LatLng(
          s.selectedReport.latitude!,
          s.selectedReport.longitude!,
        );

        // Move a câmera após o build
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final controller = await _mapController.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: latLng, zoom: 15),
            ),
          );
        });

        return {
          Marker(
            markerId: MarkerId(s.selectedReport.reportId.toString()),
            position: latLng,
            infoWindow: InfoWindow(
              title: s.selectedReport.reportsType,
              snippet:
                  '${s.selectedReport.address}, ${s.selectedReport.number}',
            ),
          ),
        };
      },
    );

    return Scaffold(
      drawer: NavigationDrawer(
        backgroundColor: AppColors.white,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(AppAssets.logo),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  child: Card(
                    color: AppColors.primaryColor,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Icon(Icons.home, color: AppColors.white),
                        ),
                        Text(
                          'Menu',
                          style: TextStyle(
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
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () => Modular.to.pushNamed('/heatmap'),
                  child: Card(
                    color: AppColors.primaryColor,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Icon(Icons.map, color: AppColors.white),
                        ),
                        Text(
                          'Mapa de Calor',
                          style: TextStyle(
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
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () => Modular.to.pushNamed('/dashboard'),
                  child: Card(
                    color: AppColors.primaryColor,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Icon(Icons.dashboard, color: AppColors.white),
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
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
        ],
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        title: Text(
          'Bem-vindo, ${userInfo!.user!.name}!',
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('/settings'),
            icon: const Icon(Icons.settings, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => Modular.to.pushNamed('/reports'),
            icon: const Icon(Icons.add, color: AppColors.white),
          ),
        ],
      ),
      body: state.when(
        init: () {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        },
        success: (s) {
          return Row(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(40),
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
                        onFinish: () {
                          sendToFinishReport(report);
                        },
                        reportDescription:
                            'Volume Sonoro acima do permitido por legislação',
                        reportAddress: '${report.address!}, ${report.number!}',
                      ),
                    );
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: 0.6 * width,
                      height: 0.8 * height,
                      child: GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(-23.5505, -46.6333),
                          zoom: 12,
                        ),
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                        markers: markers,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        empty:
            (m) => const Center(
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
                  SizedBox(height: 10),
                ],
              ),
            ),
      ),
    );
  }
}
