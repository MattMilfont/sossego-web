import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';

final sendToRecover = atomAction((set) {
  Modular.to.pushNamed('/recover');
});