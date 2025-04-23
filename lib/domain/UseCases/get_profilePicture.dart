import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/profilePictureEntity.dart';
import 'package:system_alex_univ/domain/repository/profilePicture/profile_picture_repos.dart';

@injectable
class GetProfilepictureUseCase {
  ProfilePictureRepos profilePictureRepos;
  GetProfilepictureUseCase({required this.profilePictureRepos});
  Future<Either<Failure, ProfilePictureEntity>> invoke() {
    return profilePictureRepos.getProfilePicture();
  }
}
