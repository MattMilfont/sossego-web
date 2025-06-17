import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/recover/views/pages/recover_page.dart';

class RecoverModule extends Module{
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => RecoverPage());
  }
}