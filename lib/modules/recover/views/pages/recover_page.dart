import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:sossego_web/modules/recover/states/actions/sendEmailAction.dart';
import 'package:sossego_web/modules/recover/states/atoms/recover_atom.dart';
import 'package:sossego_web/utils/app_colors.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({super.key});

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> with HookStateMixin {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = useAtomState(recoverState);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 800,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 60,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Recuperar Senha',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Digite seu e-mail',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      state.when(
                        init: () {
                          return ElevatedButton(
                            onPressed: () {
                              sendEmailAction(emailController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 70,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Enviar Recuperação',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                        loading:
                            (l) => CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          state.when(
            init: () => Column(),
            success:
                (s) => Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: AppColors.success,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Center(
                      child: Text(
                        'E-mail enviado com sucesso',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
            error:
                (e) => Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
