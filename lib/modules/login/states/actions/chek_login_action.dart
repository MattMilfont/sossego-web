import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';

final checkLogin = atomAction((set) async {
  if (userData.state?.token != null) {
    Modular.to.navigate('/home');
  }
});
