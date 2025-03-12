import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/utils/apis/api_constant.dart';
import 'package:e_commerce_app/core/utils/apis/api_endpoints.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  final dio = Dio();
  Future<Response> getData(
      {required String apiEndpoints,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      Options? options}) {
    return dio.get(ApiConstant.baseurl + apiEndpoints,
        options: Options(validateStatus: (status) => true, headers: headers),
        queryParameters: queryParameters);
  }

  Future<Response> postData(
      {required String apiEndpoints,
      Map<String, dynamic>? queryParameters,
      Object? body,
      Map<String, dynamic>? headers,
      Options? options}) {
    return dio.post(ApiConstant.baseurl + apiEndpoints,
        data: body,
        options: Options(validateStatus: (status) => true, headers: headers),
        queryParameters: queryParameters);
  }

  Future<Response> deleteData(
      {required String apiEndpoints,
      Map<String, dynamic>? queryParameters,
      Object? body,
      Map<String, dynamic>? headers,
      Options? options}) {
    return dio.delete(ApiConstant.baseurl + apiEndpoints,
        data: body,
        options: Options(validateStatus: (status) => true, headers: headers),
        queryParameters: queryParameters);
  }

  Future<Response> update(
      {required String apiEndpoints,
      Map<String, dynamic>? queryParameters,
      Object? body,
      Map<String, dynamic>? headers,
      Options? options}) {
    return dio.put(ApiConstant.baseurl + apiEndpoints,
        data: body,
        options: Options(validateStatus: (status) => true, headers: headers),
        queryParameters: queryParameters);
  }
}
