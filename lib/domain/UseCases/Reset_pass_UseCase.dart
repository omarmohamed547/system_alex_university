import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/login_response_entites.dart';
import 'package:system_alex_univ/domain/entites/reset_passs_entity.dart';
import 'package:system_alex_univ/domain/repository/auth/auth_repos.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPassUsecase {
  AuthRepos authRepos;
  ResetPassUsecase({required this.authRepos});
  Future<Either<Failure, ResetPasswordEntity>> invoke(
      {required String email, required String password, required String otp}) {
    return authRepos.resetPassword(email, otp, password);
  }
}
