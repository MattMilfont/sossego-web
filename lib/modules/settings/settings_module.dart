import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/settings/views/pages/settings_page.dart';

class SettingsModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => SettingsPage());
  }
}
