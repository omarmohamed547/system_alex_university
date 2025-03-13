class LoginModelEntity {
  LoginModelEntity({
    required this.token,
    required this.user,
  });

  final String? token;
  final UserEntity? user;
}

class UserEntity {
  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? role;
}
