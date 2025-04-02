import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/apis/api_endpoints.dart';
import 'package:system_alex_univ/core/utils/apis/api_manager.dart';
import 'package:system_alex_univ/core/utils/cache/shared_pref.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/data/models/get_courses_responseDm.dart';
import 'package:system_alex_univ/domain/repository/home/home_remoteDataSource.dart';
import 'package:either_dart/either.dart';

@Injectable(as: HomeRemotedatasource)
class HomeDatasourceImpl implements HomeRemotedatasource {
  ApiManager apiManager;
  HomeDatasourceImpl({required this.apiManager});
  @override
  Future<Either<Failure, List<GetCoursesResponseDm>>> getCourses() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var token = SharedPrefernceUtilis.getData('token');

        print("token:$token");
        var response = await apiManager.getData(
          apiEndpoints: ApiEndpoints.getCoursesendpoint,
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print("response:$response");

          // ✅ Check if response is a list and parse it properly
          if (response.data is List) {
            var courseResponse =
                GetCoursesResponseDm.fromJsonList(response.data);
            return Right(courseResponse);
          } else {
            return Left(
                ServerError(errorMessage: "Invalid API response format"));
          }
        } else {
          return Left(ServerError(errorMessage: "Failed to fetch courses"));
        }
      } catch (e) {
        return Left(Failure(errorMessage: e.toString()));
      }
    } else {
      return Left(NetworkError(errorMessage: "No internet connection"));
    }
  }
}
