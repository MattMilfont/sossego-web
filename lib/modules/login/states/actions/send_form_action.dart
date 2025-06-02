import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sossego_web/modules/login/services/signin_service.dart';
import 'package:sossego_web/modules/login/states/atoms/login_atom.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';
import 'package:sossego_web/modules/login/states/login_state.dart';
import 'dart:convert'; 

final sendFormAction = atomAction2<String, String>((set, email, password) async {
  set(loginState, LoadingLoginState());

  try {
    final user = await SignInService().postSignIn(email, password);

    if (user?.token != null) {
      set(userData, user);

      final prefs = await SharedPreferences.getInstance();
      final jsonUser = jsonEncode(user!.toJson());
      await prefs.setString('user_data', jsonUser);

      set(loginState, SucessLoginState());
      Modular.to.navigate('/home');
    } else {
      set(
        loginState,
        ErrorLoginState(
          erroMsg: 'Verifique seu e-mail ou senha e tente novamente.',
        ),
      );
    }
  } catch (e) {
    print('Erro: $e');
    set(
      loginState,
      ErrorLoginState(
        erroMsg: 'Erro Interno no servidor, tente novamente mais tarde.',
      ),
    );
  }
});
