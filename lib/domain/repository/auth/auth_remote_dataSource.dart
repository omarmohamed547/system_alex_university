import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/login_response_entites.dart';
import 'package:system_alex_univ/domain/entites/reset_passs_entity.dart';

abstract class AuthdataSource {
  Future<Either<Failure, LoginModelEntity>> login(
      String email, String password);

  Future<Either<Failure, ForgetPasswordEntity>> forgetPassword(String email);

  Future<Either<Failure, ResetPasswordEntity>> resetPassword(
      String email, String otp, String newPassword);
}
