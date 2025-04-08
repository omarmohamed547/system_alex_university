import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/apis/api_endpoints.dart';
import 'package:system_alex_univ/core/utils/apis/api_manager.dart';
import 'package:system_alex_univ/core/utils/cache/shared_pref.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/data/models/AvaliableCourseStudentDm.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';
import 'package:system_alex_univ/domain/repository/register_student/registerStu_dataSource.dart';

@Injectable(as: RegistertuDatasource)
class RegisterStuDatasourceimp implements RegistertuDatasource {
  ApiManager apiManager;
  RegisterStuDatasourceimp({required this.apiManager});

  @override
  Future<Either<Failure, AvaliableCourseStudentDm>> getAvaliableCourse() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var token = SharedPrefernceUtilis.getData('token');

        print("token:$token");
        var userId = SharedPrefernceUtilis.getData('userId');

        var response = await apiManager.getData(
          apiEndpoints:
              "${ApiEndpoints.getAvliableCourseseStudentndpoint}/$userId",
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print("response:$response");

          var avliablecourseResponse =
              AvaliableCourseStudentDm.fromJson(response.data);
          return Right(avliablecourseResponse);
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

  @override
  Future<Either<Failure, RegisterCourseDm>> registerCourse(
      String coursecodes) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var token = SharedPrefernceUtilis.getData('token');
        var userId = SharedPrefernceUtilis.getData('userId');
        print("token:$token");
        var response = await apiManager.postData(
          body: {"courseCodes": coursecodes},
          apiEndpoints:
              "${ApiEndpoints.registerCourseseStudentndpoint}/$userId",
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print("response:$response");

          var avliablecourseResponse = RegisterCourseDm.fromJson(response.data);
          return Right(avliablecourseResponse);
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

  @override
  Future<Either<Failure, RegisterCourseDm>> dropCourse(
      String coursecodes) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var token = SharedPrefernceUtilis.getData('token');
        var userId = SharedPrefernceUtilis.getData('userId');
        print("token:$token");
        var response = await apiManager.deleteData(
          body: {"courseCodes": coursecodes},
          apiEndpoints: "${ApiEndpoints.dropCourseseStudentndpoint}/$userId",
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print("response:$response");

          var avliablecourseResponse = RegisterCourseDm.fromJson(response.data);
          return Right(avliablecourseResponse);
        } else {
          return Left(ServerError(errorMessage: "Failed to drop courses"));
        }
      } catch (e) {
        return Left(Failure(errorMessage: e.toString()));
      }
    } else {
      return Left(NetworkError(errorMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, RegisterCourseDm>> registerSection(
      String coursecodes, String sectionId) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var token = SharedPrefernceUtilis.getData('token');
        var userId = SharedPrefernceUtilis.getData('userId');
        print("token:$token");
        var response = await apiManager.postData(
          body: {"courseCodes": coursecodes, "sectionId": sectionId},
          apiEndpoints:
              "${ApiEndpoints.registerSectionsStudentndpoint}/$userId",
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print("response:$response");

          var avliablesectionResponse =
              RegisterCourseDm.fromJson(response.data);
          return Right(avliablesectionResponse);
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
