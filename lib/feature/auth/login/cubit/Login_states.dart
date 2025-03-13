import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/login_response_entites.dart';

abstract class LoginStates {}

class IntialLoginStates extends LoginStates {}

class LoadingLoginState extends LoginStates {}

class FailureLoginState extends LoginStates {
  Failure error;
  FailureLoginState({required this.error});
}

class SucessLoginState extends LoginStates {
  LoginModelEntity loginModelEntity;
  SucessLoginState({required this.loginModelEntity});
}
