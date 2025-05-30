import 'package:dio/dio.dart';
import 'package:sossego_web/modules/login/models/user_model.dart';
import 'package:sossego_web/utils/endpoinst.dart';

class SignInService {
  final dio = Dio(BaseOptions(
    followRedirects: true,
    validateStatus: (status) => status != null && status < 500,
  ))..interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

  Future<UserModel?> postSignIn(String email, String password) async {
    try {

      final response = await dio.post(
        Endpoints.signIn, // URL completa
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // Verificar se houve redirecionamento
      if (response.statusCode == 307) {
        final location = response.headers.value('location');
        if (location != null) {
          // Adicionar o domínio ao local do redirecionamento, se necessário
          final fullUrl = 'http://35.239.72.106:8080$location';
          print('Redirecionado para: $fullUrl');

          final redirectedResponse = await dio.post(
            fullUrl,
            data: {
              'email': email,
              'password': password,
            },
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );

          print('Dados após redirecionamento: ${redirectedResponse.data}');
          return UserModel.fromJson(redirectedResponse.data);
        }
      }

      // Se a resposta for 200 OK, retorna os dados do usuário
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }

      return null;
    } catch (e) {
      print('Erro na requisição: $e');
      return null;
    }
  }
}
