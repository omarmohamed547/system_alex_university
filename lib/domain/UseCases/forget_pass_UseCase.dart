import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/login_response_entites.dart';
import 'package:system_alex_univ/domain/entites/reset_passs_entity.dart';
import 'package:system_alex_univ/domain/repository/auth/auth_repos.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPassUsecase {
  AuthRepos authRepos;
  ForgetPassUsecase({required this.authRepos});
  Future<Either<Failure, ForgetPasswordEntity>> invoke(String email) {
    return authRepos.forgetPassword(email);
  }
}
