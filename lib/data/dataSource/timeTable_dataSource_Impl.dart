import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/apis/api_endpoints.dart';
import 'package:system_alex_univ/core/utils/apis/api_manager.dart';
import 'package:system_alex_univ/core/utils/cache/shared_pref.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/data/models/course_timeTableDm.dart';
import 'package:system_alex_univ/domain/entites/Course_TimeTable_entity.dart';
import 'package:system_alex_univ/domain/repository/home_stu/time_table_dataSource.dart';

@Injectable(as: TimeTableDatasource)
class TimetableDatasourceImpl implements TimeTableDatasource {
  ApiManager apiManager;
  TimetableDatasourceImpl({required this.apiManager});
  @override
  Future<Either<Failure, CourseTableDm>> getTimeTable() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var token = SharedPrefernceUtilis.getData('token');

        print("token:$token");
        var userId = SharedPrefernceUtilis.getData('userId');

        var response = await apiManager.getData(
          apiEndpoints: "${ApiEndpoints.getCourseseTableendpoint}/$userId",
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print("response:$response");

          var getCoursesResponse = CourseTableDm.fromJson(response.data);
          return Right(getCoursesResponse);
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
