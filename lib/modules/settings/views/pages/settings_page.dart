import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';
import 'package:sossego_web/modules/settings/models/update_userdata_model.dart';
import 'package:sossego_web/modules/settings/states/actions/error_update_userdata_action.dart';
import 'package:sossego_web/modules/settings/states/actions/update_userdata.dart';
import 'package:sossego_web/modules/settings/states/atoms/settings_atom.dart';
import 'package:sossego_web/utils/app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with HookStateMixin {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final TextEditingController nameController = TextEditingController(
    text: userData.state?.user?.name,
  );
  final TextEditingController emailController = TextEditingController(
    text: userData.state?.user?.email,
  );
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController(
    text: userData.state?.user?.phoneNumber,
  );

  @override
  Widget build(BuildContext context) {
    final state = useAtomState(settingsState);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          color: AppColors.primaryColor,
          child: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                true,
              ); // retorna "true" como sinal de atualização
            },
            icon: Icon(Icons.arrow_back),
            color: AppColors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 800,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Configurações',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        controller: nameController, // Controller para o e-mail
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Digite seu nome completo',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: emailController, // Controller para o e-mail
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Digite seu e-mail',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: phoneController, // Controller para o e-mail
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Digite seu telefone',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller:
                            passwordController, // Controller para a senha
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
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
                      SizedBox(height: 20),
                      TextFormField(
                        controller:
                            confirmPasswordController, // Controller para a senha
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Digite sua senha novamente',
                          labelStyle: TextStyle(color: Colors.black),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      state.when(
                        init: () {
                          return ElevatedButton(
                            onPressed: () {
                              if (confirmPasswordController.text ==
                                  passwordController.text) {
                                final UpdateUserdataModel formData =
                                    UpdateUserdataModel(
                                      email: emailController.text,
                                      name: nameController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                updateUserdataAction(formData);
                              } else {
                                errorUpdateUserdataAction(
                                  'As senhas não estão idênticas',
                                );
                              }
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
                              'Salvar',
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
                              color: AppColors.primaryColor,
                            ),
                      ),
                    ],
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
