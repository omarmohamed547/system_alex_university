import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/login_response_entites.dart';
import 'package:system_alex_univ/domain/repository/auth/auth_repos.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthUsecase {
  AuthRepos authRepos;
  AuthUsecase({required this.authRepos});
  Future<Either<Failure, LoginModelEntity>> invoke(
      String email, String password) {
    return authRepos.login(email, password);
  }
}
