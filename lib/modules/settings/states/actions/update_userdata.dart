import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';
import 'package:sossego_web/modules/settings/models/update_userdata_model.dart';
import 'package:sossego_web/modules/settings/services/update_userdata_service.dart';
import 'package:sossego_web/modules/settings/states/atoms/settings_atom.dart';
import 'package:sossego_web/modules/settings/states/settings_state.dart';

final updateUserdataAction = atomAction1((
  set,
  UpdateUserdataModel formData,
) async {
  set(settingsState, LoadingSettingsState());

  try {
    final response = await UpdateUserdataService().updateUserdata(
      userData.state?.user?.id!,
      formData,
    );
    print(response);
    set(
      settingsState,
      SuccessSettingsState(successMsg: 'Atualização realizada com sucesso!'),
    );
    Modular.to.navigate('/');
  } catch (e) {
    set(
      settingsState,
      ErrorSettingsState(
        erroMsg: 'Erro Interno no servidor, tente novemente mais tarde.',
      ),
    );
  }
});
