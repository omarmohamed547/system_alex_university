class ForgetPasswordEntity {
  ForgetPasswordEntity({
    required this.message,
    required this.otp,
  });

  final String? message;
  final String? otp;
}

class ResetPasswordEntity {
  ResetPasswordEntity({
    required this.message,
  });

  final String? message;
}
