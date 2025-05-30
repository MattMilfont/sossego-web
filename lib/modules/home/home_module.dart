import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/home/views/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
  }
}
