import 'package:system_alex_univ/domain/entites/login_response_entites.dart';

class LoginModelDm extends LoginModelEntity {
  LoginModelDm({super.token, super.user, this.message});

  final String? message;
  factory LoginModelDm.fromJson(Map<String, dynamic> json) {
    return LoginModelDm(
      message: json["message"],
      token: json["token"],
      user: json["user"] == null ? null : UserDm.fromJson(json["user"]),
    );
  }
}

class UserDm extends UserEntity {
  UserDm({
    super.id,
    super.name,
    super.email,
    super.role,
  });

  factory UserDm.fromJson(Map<String, dynamic> json) {
    return UserDm(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
    );
  }
}
