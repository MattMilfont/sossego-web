import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/login/services/signin_service.dart';
import 'package:sossego_web/modules/login/states/atoms/login_atom.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';
import 'package:sossego_web/modules/login/states/login_state.dart';

final sendFormAction = atomAction2<String, String>((
  set,
  email,
  password,
) async {
  set(loginState, LoadingLoginState());

  try {
    final user = await SignInService().postSignIn(email, password);
    if (user!.token != null) {
      set(userData, user);
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
        erroMsg: 'Erro Interno no servidor, tente novemente mais tarde.',
      ),
    );
  }
});
