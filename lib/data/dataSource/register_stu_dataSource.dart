import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/apis/api_constant.dart';
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
          String errorMsg = "Failed to register course";

          // Check for specific error messages
          if (response.data != null && response.data is Map) {
            final message =
                response.data['message']?.toString().toLowerCase() ?? '';

            if (message.contains("conflict")) {
              errorMsg = "Time conflict with this course";
            } else if (message
                .contains("exceeds maximum allowed credit hours")) {
              errorMsg = "Exceeds maximum allowed credit hours (18)";
            } else if (message.contains("maximum courses")) {
              errorMsg = "Maximum course limit reached";
            }
          }

          return Left(ServerError(errorMessage: errorMsg));
        }
      } catch (e) {
        return Left(Failure(errorMessage: e.toString()));
      }
    } else {
      return Left(NetworkError(errorMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, DropCourseDm>> dropCourse(String coursecodes) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var token = SharedPrefernceUtilis.getData('token');
        var userId = SharedPrefernceUtilis.getData('userId');
        print("token:$token");
        var response = await apiManager.postData(
          body: {"courseCode": coursecodes},
          apiEndpoints: "${ApiEndpoints.dropCourseseStudentndpoint}/$userId",
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print("response:$response");

          var avliablecourseResponse = DropCourseDm.fromJson(response.data);
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
  Future<Either<Failure, RegisterSectionDm>> registerSection(
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
          apiEndpoints:
              "${ApiEndpoints.registerSectionsStudentndpoint}/$userId",
          body: {
            "registrations": [
              {"courseCode": coursecodes, "sectionId": sectionId}
            ]
          },
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json', // 🔥 Add this
          },
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print("response:$response");

          var avliablesectionResponse =
              RegisterSectionDm.fromJson(response.data);
          return Right(avliablesectionResponse);
        } else {
          // Check if the response contains a conflict message
          String errorMsg = "Failed to fetch sections";

          if (response.data != null &&
              response.data is Map &&
              (response.data['message']
                      ?.toString()
                      .toLowerCase()
                      .contains("conflict") ??
                  false)) {
            errorMsg = "Time conflict";
          }
          return Left(ServerError(errorMessage: errorMsg));
        }
      } catch (e) {
        return Left(Failure(errorMessage: e.toString()));
      }
    } else {
      return Left(NetworkError(errorMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, DropSecDm>> dropSection(
      String coursecodes, String sectionId) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var token = SharedPrefernceUtilis.getData('token');
        var userId = SharedPrefernceUtilis.getData('userId');

        // Debug prints
        print("Token: $token");
        print("UserID: $userId");
        print(
            "Making request to: ${ApiConstant.baseurl}/${ApiEndpoints.dropSectionStudentndpoint}/$userId");

        var response = await apiManager.postData(
          body: {"courseCode": coursecodes, "sectionId": sectionId},
          apiEndpoints: "${ApiEndpoints.dropSectionStudentndpoint}/$userId",
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        // Debug print
        print("Response: ${response.statusCode} - ${response.data}");

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          var avliabledropSecResponse = DropSecDm.fromJson(response.data);
          return Right(avliabledropSecResponse);
        } else {
          // Improved error handling
          final errorMsg = response.data is Map
              ? response.data['message'] ?? "Failed to drop Section"
              : "Server responded with status ${response.statusCode}";
          return Left(ServerError(errorMessage: errorMsg));
        }
      } catch (e) {
        print("Error in dropSection: $e");
        return Left(Failure(errorMessage: "Network error occurred"));
      }
    } else {
      return Left(NetworkError(errorMessage: "No internet connection"));
    }
  }
}
