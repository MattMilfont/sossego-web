import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/login/views/pages/login_page.dart';

class LoginModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => LoginPage());
  }
}
