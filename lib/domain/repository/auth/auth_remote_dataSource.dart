import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/login_response_entites.dart';

abstract class AuthdataSource {
  Future<Either<Failure, LoginModelEntity>> login(
      String email, String password);
}
