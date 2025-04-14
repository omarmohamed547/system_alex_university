import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/apis/api_endpoints.dart';
import 'package:system_alex_univ/core/utils/apis/api_manager.dart';
import 'package:system_alex_univ/core/utils/cache/shared_pref.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/data/models/course_timeTableDm.dart';
import 'package:system_alex_univ/data/models/performance_dm.dart';
import 'package:system_alex_univ/domain/entites/Course_TimeTable_entity.dart';
import 'package:system_alex_univ/domain/entites/performace_entity.dart';
import 'package:system_alex_univ/domain/repository/home_stu/time_table_dataSource.dart';
import 'package:system_alex_univ/domain/repository/performance/performance_dataSource.dart';

@Injectable(as: PerformanceDatasource)
class PerformanceDatasourceImpl implements PerformanceDatasource {
  ApiManager apiManager;
  PerformanceDatasourceImpl({required this.apiManager});

  @override
  Future<Either<Failure, PerformaceReponseDm>> getPerformace() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var token = SharedPrefernceUtilis.getData('token');

        print("token:$token");
        var userId = SharedPrefernceUtilis.getData('userId');

        var response = await apiManager.getData(
          apiEndpoints: "${ApiEndpoints.getPerformamceendpoint}/$userId",
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print("response:$response");

          var getPerformanceResponse =
              PerformaceReponseDm.fromJson(response.data);
          return Right(getPerformanceResponse);
        } else {
          return Left(ServerError(errorMessage: "Failed to get performance"));
        }
      } catch (e) {
        return Left(Failure(errorMessage: e.toString()));
      }
    } else {
      return Left(NetworkError(errorMessage: "No internet connection"));
    }
  }
}
