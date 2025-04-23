import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/UseCases/Reset_pass_UseCase.dart';
import 'package:system_alex_univ/domain/UseCases/forget_pass_UseCase.dart';
import 'package:system_alex_univ/domain/entites/reset_passs_entity.dart';
import 'package:system_alex_univ/feature/auth/forgetPassword/cubit/reset_passwordStates.dart';

@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordstates> {
  final ResetPassUsecase resetPassUsecase;
  final ForgetPassUsecase forgetPassUsecase;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ResetPasswordViewModel({
    required this.forgetPassUsecase,
    required this.resetPassUsecase,
  }) : super(ResetPasswordInitial());

  bool _isFirstStep = true;

  bool get isFirstStep => _isFirstStep;

  // For Forget Password (Send OTP)
  void forgetPassword(BuildContext context) async {
    if (emailController.text.isEmpty) {
      _showSnackBar(context, 'Please enter your email');
      return;
    }

    emit(LoadingForgetPass());

    final either = await forgetPassUsecase.invoke(emailController.text.trim());

    either.fold(
      (failure) {
        emit(FailureForgetPass(error: failure));
        _showSnackBar(context, failure.errorMessage);
      },
      (success) {
        _isFirstStep = false;
        emit(SucessForgetPass(forgetPasswordEntity: success));
        _showSnackBar(context, 'OTP sent successfully');
      },
    );
  }

  // For Reset Password
  void resetPassword(BuildContext context) async {
    if (otpController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      _showSnackBar(context, 'Please fill all fields');
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      _showSnackBar(context, 'Passwords do not match');
      return;
    }

    emit(LoadingResetPass());

    final either = await resetPassUsecase.invoke(
      email: emailController.text.trim(),
      otp: otpController.text.trim(),
      password: newPasswordController.text.trim(),
    );

    either.fold(
      (failure) {
        emit(FailureResetPass(error: failure));
        _showSnackBar(context, failure.errorMessage);
      },
      (success) {
        emit(SucessResetPass(resetPasswordEntity: success));
        _showSnackBar(context, 'Password reset successfully');
        // You can navigate to login screen here if needed
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    newPasswordController.dispose();
    otpController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
