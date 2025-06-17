import 'package:asp/asp.dart';
import 'package:sossego_web/modules/recover/services/send_email_service.dart';
import 'package:sossego_web/modules/recover/states/atoms/recover_atom.dart';
import 'package:sossego_web/modules/recover/states/recover_state.dart';

final sendEmailAction = atomAction1<String>((set, email) async {
  set(recoverState, LoadingRecoverState());

  try {
    final statusCode = await SendEmailService().postSendEmail(email);
    if (statusCode == 200) {
      set(recoverState, SuccessRecoverState());
    } else {
      set(
        recoverState,
        ErrorRecoverState(erroMsg: 'Erro ao enviar e-mail, verifique os dados'),
      );
    }
  } catch (e) {
    print('Erro: $e');
    set(
      recoverState,
      ErrorRecoverState(
        erroMsg: 'Erro Interno no servidor, tente novemente mais tarde.',
      ),
    );
  }
});
