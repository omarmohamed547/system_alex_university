import 'package:system_alex_univ/domain/entites/reset_passs_entity.dart';

class ForgetPasswordDm extends ForgetPasswordEntity {
  ForgetPasswordDm({
    super.message,
    super.otp,
  });

  factory ForgetPasswordDm.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordDm(
      message: json["message"],
      otp: json["otp"],
    );
  }
}

class ResetPasswordDm extends ResetPasswordEntity {
  ResetPasswordDm({
    super.message,
  });

  factory ResetPasswordDm.fromJson(Map<String, dynamic> json) {
    return ResetPasswordDm(
      message: json["message"],
    );
  }
}
