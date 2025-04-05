import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/apis/api_constant.dart';

@singleton
class ApiManager {
  final dio = Dio();
  String buildUrl(String endpoint) {
    final base = ApiConstant.baseurl;
    if (base.endsWith('/') && endpoint.startsWith('/')) {
      return base + endpoint.substring(1); // remove extra slash
    } else if (!base.endsWith('/') && !endpoint.startsWith('/')) {
      return '$base/$endpoint'; // add missing slash
    }
    return base + endpoint; // already correct
  }

  Future<Response> getData({
    required String apiEndpoints,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    final url = buildUrl(apiEndpoints);
    print('GET: $url');
    return dio.get(
      url,
      options: Options(validateStatus: (status) => true, headers: headers),
      queryParameters: queryParameters,
    );
  }

  Future<Response> postData({
    required String apiEndpoints,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
    Options? options,
  }) {
    final url = buildUrl(apiEndpoints);
    print('POST: $url');
    return dio.post(
      url,
      data: body,
      options: Options(validateStatus: (status) => true, headers: headers),
      queryParameters: queryParameters,
    );
  }

  Future<Response> deleteData({
    required String apiEndpoints,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
    Options? options,
  }) {
    final url = buildUrl(apiEndpoints);
    print('DELETE: $url');
    return dio.delete(
      url,
      data: body,
      options: Options(validateStatus: (status) => true, headers: headers),
      queryParameters: queryParameters,
    );
  }

  Future<Response> update({
    required String apiEndpoints,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
    Options? options,
  }) {
    final url = buildUrl(apiEndpoints);
    print('PUT: $url');
    return dio.put(
      url,
      data: body,
      options: Options(validateStatus: (status) => true, headers: headers),
      queryParameters: queryParameters,
    );
  }
}
