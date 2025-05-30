import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/home/models/report_model.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';
import 'package:sossego_web/utils/endpoinst.dart';

class GetReportsUserService {
  final dio = Dio(
    BaseOptions(
      followRedirects: true,
      validateStatus: (status) => status != null && status < 500,
    ),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Future<List<ReportModel>?> getReportsUser(int? id) async {
    try {
      print('URL da requisição: ${Endpoints.getReportsUser}');

      final response = await dio.get(
        '${Endpoints.getReportsUser}/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${userData.state?.token}'},
        ),
      );

      if (response.statusCode == 307) {
        final location = response.headers.value('location');
        if (location != null) {
          final fullUrl = 'http://35.239.72.106:8080$location';
          print('Redirecionado para: $fullUrl');

          final redirectedResponse = await dio.get(
            '$fullUrl/$id',
            options: Options(
              headers: {'Authorization': 'Bearer ${userData.state?.token}'},
            ),
          );

          final data = redirectedResponse.data as List;
          return data.map((json) => ReportModel.fromJson(json)).toList();
        }
      }

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => ReportModel.fromJson(json)).toList();
      }

      if (response.statusCode == 401) {
        Modular.to.navigate('/');
      }
    } catch (e) {
      print('Erro na requisição: $e');
    }

    return null;
  }
}
