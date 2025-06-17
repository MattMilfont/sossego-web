import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/heatmap/heatmap_module.dart';
import 'package:sossego_web/modules/home/home_module.dart';
import 'package:sossego_web/modules/login/login_module.dart';
import 'package:sossego_web/modules/recover/recover_module.dart';
import 'package:sossego_web/modules/settings/settings_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r
      ..module('/home', module: HomeModule())
      ..module('/recover', module: RecoverModule())
      ..module('/settings', module: SettingsModule())
      ..module('/heatmap', module: HeatmapModule())
      ..module('/', module: LoginModule());
  }
}
