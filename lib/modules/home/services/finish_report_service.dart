import 'package:dio/dio.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';
import 'package:sossego_web/utils/endpoints.dart';

class FinishReportService {
  final dio = Dio(
    BaseOptions(
      followRedirects: true,
      validateStatus: (status) => status != null && status < 500,
    ),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Future<int?> solveReport(int? id, String solution) async {
    try {
      final response = await dio.put(
        '${Endpoints.finishReport}/$id/solution',
        data: {'report_solution': solution},
        options: Options(
          headers: {'Authorization': 'Bearer ${userData.state?.token}'},
        ),
      );

      if (response.statusCode == 307) {
        final location = response.headers.value('location');
        if (location != null) {
          final fullUrl = '${Endpoints.baseUrl}$location';
          final redirectedResponse = await dio.put(
            '$fullUrl/$id',
            data: {'report_solution': solution},
            options: Options(
              headers: {'Authorization': 'Bearer ${userData.state?.token}'},
            ),
          );
          return redirectedResponse.statusCode;
        }
      }

      return response.statusCode;
    } catch (e) {
      print('Erro na requisição: $e');
    }
    return null;
  }
}
