import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/login_response_entites.dart';
import 'package:either_dart/either.dart';

abstract class AuthRepos {
  Future<Either<Failure, LoginModelEntity>> login(
      String email, String password);
}
