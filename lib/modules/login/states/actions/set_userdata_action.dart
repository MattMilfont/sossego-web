import 'package:asp/asp.dart';
import 'package:sossego_web/modules/login/models/user_model.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';

final setUserdataAction = atomAction1<UserModel>((set, user) async {
  set(userData, user);
});
