import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';

class AuthGuard extends RouteGuard {
  AuthGuard()
    : super(redirectTo: '/login'); // se não autorizado, vai para login

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final user = userData.state;
    if (user != null && user.token != null && user.token!.isNotEmpty) {
      return true;
    }
    return false;
  }
}
