import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/apis/api_endpoints.dart';
import 'package:system_alex_univ/core/utils/apis/api_manager.dart';
import 'package:system_alex_univ/core/utils/cache/shared_pref.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/data/models/ExamTable_Dm.dart';
import 'package:system_alex_univ/data/models/course_timeTableDm.dart';
import 'package:system_alex_univ/data/models/profilePictureDm.dart';
import 'package:system_alex_univ/domain/entites/ExamTable_entity.dart';
import 'package:system_alex_univ/domain/entites/profilePictureEntity.dart';
import 'package:system_alex_univ/domain/repository/examTable/ExamTable_dataSource.dart';
import 'package:system_alex_univ/domain/repository/profilePicture/profile_picture_dataSource.dart';

@Injectable(as: ProfilePictureDatasource)
class ProfilePictureDatasourceImpl implements ProfilePictureDatasource {
  ApiManager apiManager;
  ProfilePictureDatasourceImpl({required this.apiManager});

  @override
  Future<Either<Failure, ProfilePictureDm>> getProfilePicture() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        var token = SharedPrefernceUtilis.getData('token');

        print("token:$token");
        var userId = SharedPrefernceUtilis.getData('userId');

        var response = await apiManager.getData(
          apiEndpoints: "${ApiEndpoints.getprofilepictureendpoint}/$userId",
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print("response:$response");

          var getprofilepictureResponse =
              ProfilePictureDm.fromJson(response.data);
          return Right(getprofilepictureResponse);
        } else {
          return Left(ServerError(errorMessage: "Failed to fetch photo"));
        }
      } catch (e) {
        return Left(Failure(errorMessage: e.toString()));
      }
    } else {
      return Left(NetworkError(errorMessage: "No internet connection"));
    }
  }
}
