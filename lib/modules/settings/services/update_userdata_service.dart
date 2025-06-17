import 'package:dio/dio.dart';
import 'package:sossego_web/modules/settings/models/update_userdata_model.dart';
import 'package:sossego_web/utils/endpoints.dart';

class UpdateUserdataService {
  final dio = Dio(
    BaseOptions(
      followRedirects: true,
      validateStatus: (status) => status != null && status < 500,
    ),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Future<int?> updateUserdata(int? userId, UpdateUserdataModel formData) async {
    final url = '${Endpoints.updateUserdata}/$userId';

    try {
      final response = await dio.put(
        url,
        data: formData.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // Em caso de redirecionamento
      if (response.statusCode == 307) {
        final location = response.headers.value('location');
        if (location != null) {
          final fullUrl = '${Endpoints.baseUrl}$location';

          final redirectedResponse = await dio.put(
            fullUrl,
            data: formData.toJson(),
            options: Options(headers: {'Content-Type': 'application/json'}),
          );
          print('Dados após redirecionamento: ${redirectedResponse.data}');
          return redirectedResponse.statusCode;
        }
      }

      print('Resposta direta: ${response.data}');
      return response.statusCode;
    } catch (e) {
      print('Erro ao atualizar dados do usuário: $e');
    }
    return null;
  }
}
