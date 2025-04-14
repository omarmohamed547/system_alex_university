import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/apis/api_constant.dart';

@singleton
class ApiManager {
  final dio = Dio();

  String buildUrl(String endpoint) {
    final base = ApiConstant.baseurl;
    if (base.endsWith('/') && endpoint.startsWith('/')) {
      return base + endpoint.substring(1);
    } else if (!base.endsWith('/') && !endpoint.startsWith('/')) {
      return '$base/$endpoint';
    }
    return base + endpoint;
  }

  Future<Response> getData({
    required String apiEndpoints,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final url = buildUrl(apiEndpoints);
    print('GET: $url');

    try {
      final response = await dio.get(
        url,
        options: Options(validateStatus: (_) => true, headers: headers),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      print("Dio GET error: ${e.message}");
      rethrow;
    }
  }

  Future<Response> postData({
    required String apiEndpoints,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    final url = buildUrl(apiEndpoints);
    print('POST: $url, BODY: $body');

    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(validateStatus: (_) => true, headers: headers),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      print("Dio POST error: ${e.message}");
      rethrow;
    }
  }

  Future<Response> deleteData({
    required String apiEndpoints,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    final url = buildUrl(apiEndpoints);
    print('DELETE: $url, BODY: $body');

    try {
      final response = await dio.delete(
        url,
        data: body,
        options: Options(validateStatus: (_) => true, headers: headers),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      print("Dio DELETE error: ${e.message}");
      rethrow;
    }
  }

  Future<Response> update({
    required String apiEndpoints,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    final url = buildUrl(apiEndpoints);
    print('PUT: $url, BODY: $body');

    try {
      final response = await dio.put(
        url,
        data: body,
        options: Options(validateStatus: (_) => true, headers: headers),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      print("Dio PUT error: ${e.message}");
      rethrow;
    }
  }
}
