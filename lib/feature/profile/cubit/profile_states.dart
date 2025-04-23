import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/profilePictureEntity.dart';

abstract class ProfileStates {}

class LoadingProfilePicture extends ProfileStates {}

class FailureProfilePicture extends ProfileStates {
  Failure error;
  FailureProfilePicture({required this.error});
}

class SuccessProfilePicture extends ProfileStates {
  ProfilePictureEntity profilePictureEntity;
  SuccessProfilePicture({required this.profilePictureEntity});
}
