import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/app_module.dart';

void main() {
  runApp(
    ModularApp(module: AppModule(), child: AppWidget(),),
  ); // Aqui você passa o child, que é o seu widget inicial
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sossego',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: Modular.routerConfig,
    ); //added by extension
  }
}
