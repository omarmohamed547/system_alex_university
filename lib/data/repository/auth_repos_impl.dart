import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/login_response_entites.dart';
import 'package:system_alex_univ/domain/entites/reset_passs_entity.dart';
import 'package:system_alex_univ/domain/repository/auth/auth_remote_dataSource.dart';
import 'package:system_alex_univ/domain/repository/auth/auth_repos.dart';

@Injectable(as: AuthRepos)
class AuthReposImpl implements AuthRepos {
  AuthdataSource authdataSource;
  AuthReposImpl({required this.authdataSource});
  @override
  Future<Either<Failure, LoginModelEntity>> login(
      String email, String password) async {
    var either = await authdataSource.login(email, password);
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failure, ForgetPasswordEntity>> forgetPassword(
      String email) async {
    var either = await authdataSource.forgetPassword(
      email,
    );
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failure, ResetPasswordEntity>> resetPassword(
      String email, String otp, String newPassword) async {
    var either = await authdataSource.resetPassword(email, otp, newPassword);
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}
