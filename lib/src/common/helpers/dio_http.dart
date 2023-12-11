import 'package:dio/dio.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/models/error_model.dart';
import 'package:marcacion_admin/src/common/services/services.dart';

class DioConexion {
  static final Dio _dio = Dio();

  static void configureDio() {
    // Base del url
    _dio.options.baseUrl = APIURL;

    // Configurar Headers
    _dio.options.headers = {
      'Authorization': 'Bearer ${LocalStorage.prefs.getString('token') ?? ''}'
    };
  }

  static Future get_(String endpoint,
      [Map<String, dynamic>? queryParameters]) async {
    Response response;
    response = await _dio.get(
      endpoint,
      queryParameters: queryParameters,
    );
    // await Future.delayed(const Duration(seconds: 2));
    return response.data;
  }

  static Future post_(String endpoint, dynamic data) async {
    // final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.post(endpoint, data: data);
      return resp.data;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response?.data != null) {
          var msg = ErrorResponse.fromJson(e.response?.data);
          NotificationsService.showSnackbarError(msg.message);
        } else {
          NotificationsService.showSnackbarError(
              "Ooops, ha ocurrido un error, favor intentarlo mas tarde.");
        }
      }

      return 'Error en el POST11';
    }
  }

  static Future put_(String endpoint, Map<String, dynamic> data) async {
    // final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.put(endpoint, data: data);
      return resp.data;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response?.data != null) {
          var msg = ErrorResponse.fromJson(e.response?.data);
          NotificationsService.showSnackbarError(msg.message);
        } else {
          NotificationsService.showSnackbarError(
              "Ooops, ha ocurrido un error, favor intentarlo mas tarde.");
        }
      }
    }
  }

  static Future delete_(String endpoint) async {
    // final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(endpoint);
      return resp.data;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response?.data != null) {
          var msg = ErrorResponse.fromJson(e.response?.data);
          NotificationsService.showSnackbarError(msg.message);
        } else {
          NotificationsService.showSnackbarError(
              "Ooops, ha ocurrido un error, favor intentarlo mas tarde.");
        }
      }
    }
  }
}
