import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/apis/api_endpoints.dart';
import 'package:system_alex_univ/core/utils/apis/api_manager.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/data/models/login_response_dm.dart';
import 'package:system_alex_univ/domain/entites/login_response_entites.dart';
import 'package:system_alex_univ/domain/repository/auth/auth_remote_dataSource.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

@Injectable(as: AuthdataSource)
class AuthDatasourceImpl implements AuthdataSource {
  ApiManager apiManager;
  AuthDatasourceImpl({required this.apiManager});
  @override
  Future<Either<Failure, LoginModelDm>> login(
      String email, String password) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var response = await apiManager
            .postData(apiEndpoints: ApiEndpoints.loginendpoint, body: {
          "id": email,
          "password": password,
        });
        var loginResponse = LoginModelDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(loginResponse);
        } else {
          return Left(ServerError(errorMessage: loginResponse.message!));
        }
      } catch (e) {
        return Left(ServerError(errorMessage: "an error has occured"));
      }
    } else {
      return Left(NetworkError(errorMessage: "No internet connection"));
    }
  }
}
