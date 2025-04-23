import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/reset_passs_entity.dart';

abstract class ResetPasswordstates {}

class ResetPasswordInitial extends ResetPasswordstates {}

class LoadingForgetPass extends ResetPasswordstates {}

class FailureForgetPass extends ResetPasswordstates {
  Failure error;
  FailureForgetPass({required this.error});
}

class SucessForgetPass extends ResetPasswordstates {
  ForgetPasswordEntity forgetPasswordEntity;
  SucessForgetPass({required this.forgetPasswordEntity});
}

class LoadingResetPass extends ResetPasswordstates {}

class FailureResetPass extends ResetPasswordstates {
  Failure error;
  FailureResetPass({required this.error});
}

class SucessResetPass extends ResetPasswordstates {
  ResetPasswordEntity resetPasswordEntity;
  SucessResetPass({required this.resetPasswordEntity});
}
