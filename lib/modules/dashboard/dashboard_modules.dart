import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/dashboard/views/pages/dashboard_page.dart';

class DashboardModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => DashboardPage());
  }
}
