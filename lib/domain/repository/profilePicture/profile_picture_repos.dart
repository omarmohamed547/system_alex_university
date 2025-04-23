import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/profilePictureEntity.dart';

abstract class ProfilePictureRepos {
  Future<Either<Failure, ProfilePictureEntity>> getProfilePicture();
}
