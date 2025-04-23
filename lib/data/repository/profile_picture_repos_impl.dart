import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/Course_TimeTable_entity.dart';
import 'package:system_alex_univ/domain/entites/profilePictureEntity.dart';
import 'package:system_alex_univ/domain/repository/home_stu/time_table_dataSource.dart';
import 'package:system_alex_univ/domain/repository/home_stu/time_table_repos.dart';
import 'package:system_alex_univ/domain/repository/profilePicture/profile_picture_dataSource.dart';
import 'package:system_alex_univ/domain/repository/profilePicture/profile_picture_repos.dart';

@Injectable(as: ProfilePictureRepos)
class ProfilePictureReposImpl implements ProfilePictureRepos {
  ProfilePictureDatasource profilePictureDatasource;
  ProfilePictureReposImpl({required this.profilePictureDatasource});

  @override
  Future<Either<Failure, ProfilePictureEntity>> getProfilePicture() async {
    var either = await profilePictureDatasource.getProfilePicture();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}
