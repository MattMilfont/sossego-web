import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/heatmap/pages/heatmap_page.dart';

class HeatmapModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => HeatmapPage());
  }
}
