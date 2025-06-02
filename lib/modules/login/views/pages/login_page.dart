import 'package:flutter/material.dart';
import 'package:asp/asp.dart';
import 'package:sossego_web/modules/login/states/actions/chek_login_action.dart';
import 'package:sossego_web/modules/login/states/actions/send_form_action.dart';
import 'package:sossego_web/modules/login/states/actions/send_sign_up.dart';
import 'package:sossego_web/modules/login/states/atoms/login_atom.dart';
import 'package:sossego_web/utils/app_assets.dart';
import 'package:sossego_web/utils/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with HookStateMixin {
  bool _isPasswordVisible = false;

  // 1. Criar os controllers para os campos de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Usando o useAtomState para pegar o estado do login
    final state = useAtomState(loginState);

    checkLogin();

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: SizedBox(
                  width: 800,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset(AppAssets.logo)],
                      ),
                      // 2. Associando o TextFormField com o controlador de email
                      TextFormField(
                        controller: emailController, // Controller para o e-mail
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Digite seu e-mail',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      // 3. Associando o TextFormField com o controlador de senha
                      TextFormField(
                        controller:
                            passwordController, // Controller para a senha
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Digite sua senha',
                          labelStyle: TextStyle(color: Colors.black),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft, // Alinha à esquerda
                        child: GestureDetector(
                          onTap: () {
                            print(
                              "Texto clicado!",
                            ); // Substitua com a ação desejada
                          },
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      state.when(
                        init: () {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  sendToSignUp();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              // 4. Passar os valores dos controllers para a função sendFormAction
                              ElevatedButton(
                                onPressed: () {
                                  final email =
                                      emailController.text; // Obtendo o e-mail
                                  final password =
                                      passwordController
                                          .text; // Obtendo a senha

                                  // Chama o método de login com os valores dos campos
                                  sendFormAction(email, password);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        loading: (l) {
                          return CircularProgressIndicator(
                            color: AppColors.white,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          state.when(
            init: () => Column(),
            error:
                (e) => Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        e.erroMsg,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
