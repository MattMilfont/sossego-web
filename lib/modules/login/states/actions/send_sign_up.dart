import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';

final sendToSignUp = atomAction((set) {
  Modular.to.pushNamed('/signUp');
});