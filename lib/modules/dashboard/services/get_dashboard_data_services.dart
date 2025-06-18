import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sossego_web/modules/home/models/report_model.dart';
import 'package:sossego_web/modules/login/states/atoms/user_atom.dart';
import 'package:sossego_web/utils/endpoints.dart';

class GetDashboardDataService {
  final dio = Dio(
    BaseOptions(
      followRedirects: true,
      validateStatus: (status) => status != null && status < 500,
    ),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Future<List<ReportModel>?> getActiveReports() async {
    try {
      final response = await dio.get(
        Endpoints.getAllActiveReports,
        options: Options(
          headers: {'Authorization': 'Bearer ${userData.state?.token}'},
        ),
      );

      if (response.statusCode == 307) {
        final location = response.headers.value('location');
        if (location != null) {
          final fullUrl = '${Endpoints.baseUrl}$location';
          print('Redirecionado para: $fullUrl');

          final redirectedResponse = await dio.get(
            fullUrl,
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

  Future<List<ReportModel>?> getSolvedReports() async {
    try {
      final response = await dio.get(
        Endpoints.getAllSolvedReports,
        options: Options(
          headers: {'Authorization': 'Bearer ${userData.state?.token}'},
        ),
      );

      if (response.statusCode == 307) {
        final location = response.headers.value('location');
        if (location != null) {
          final fullUrl = '${Endpoints.baseUrl}$location';
          print('Redirecionado para: $fullUrl');

          final redirectedResponse = await dio.get(
            fullUrl,
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

  Future<List<ReportModel>?> getAllReports() async {
    try {
      final response = await dio.get(
        Endpoints.getAllReports,
        options: Options(
          headers: {'Authorization': 'Bearer ${userData.state?.token}'},
        ),
      );

      if (response.statusCode == 307) {
        final location = response.headers.value('location');
        if (location != null) {
          final fullUrl = '${Endpoints.baseUrl}$location';
          print('Redirecionado para: $fullUrl');

          final redirectedResponse = await dio.get(
            fullUrl,
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
