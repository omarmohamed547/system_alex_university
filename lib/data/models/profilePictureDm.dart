import 'package:system_alex_univ/domain/entites/profilePictureEntity.dart';

class ProfilePictureDm extends ProfilePictureEntity {
  ProfilePictureDm({super.profilePicture, this.message});

  final String? message;
  factory ProfilePictureDm.fromJson(Map<String, dynamic> json) {
    return ProfilePictureDm(
      profilePicture: json["profilePicture"],
      message: json["message"],
    );
  }
}
