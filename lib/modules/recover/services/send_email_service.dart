import 'package:dio/dio.dart';
import 'package:sossego_web/utils/endpoints.dart';

class SendEmailService {
  final dio = Dio(
    BaseOptions(
      followRedirects: true,
      validateStatus: (status) => status != null && status < 500,
    ),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Future<int?> postSendEmail(String email) async {
    try {
      final response = await dio.post(
        Endpoints.sendEmail,
        data: {'email': email},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // Verificar se houve redirecionamento
      if (response.statusCode == 307) {
        final location = response.headers.value('location');
        if (location != null) {
          // Adicionar o domínio ao local do redirecionamento, se necessário
          final fullUrl = '${Endpoints.baseUrl}$location';
          print('Redirecionado para: $fullUrl');

          final redirectedResponse = await dio.post(
            fullUrl,
            data: {'email': email},
            options: Options(headers: {'Content-Type': 'application/json'}),
          );

          print('Dados após redirecionamento: ${redirectedResponse.data}');
          return redirectedResponse.statusCode;
        }
      }

      return response.statusCode;
    } catch (e) {
      print('Erro na requisição: $e');
      return null;
    }
  }
}
