import 'package:asp/asp.dart';
import 'package:sossego_web/modules/settings/states/atoms/settings_atom.dart';
import 'package:sossego_web/modules/settings/states/settings_state.dart';

final errorUpdateUserdataAction = atomAction1((set, String erro) {
  set(settingsState, ErrorSettingsState(erroMsg: erro));
});
