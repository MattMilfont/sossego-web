import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sossego_web/app_module.dart';
import 'package:sossego_web/modules/login/models/user_model.dart';
import 'package:sossego_web/modules/login/states/actions/set_userdata_action.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que SharedPreferences pode ser usado

  final prefs = await SharedPreferences.getInstance();
  final jsonUser = prefs.getString('user_data');
  final userMap = jsonDecode(jsonUser!);
  final user = UserModel.fromJson(userMap);
  setUserdataAction(user);

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sossego',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: Modular.routerConfig,
    );
  }
}
