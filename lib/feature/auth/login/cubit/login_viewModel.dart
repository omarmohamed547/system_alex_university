import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/domain/UseCases/auth_useCase.dart';
import 'package:system_alex_univ/feature/auth/login/cubit/Login_states.dart';

@injectable
class LoginViewmodel extends Cubit<LoginStates> {
  AuthUsecase loginUseCase;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  static LoginViewmodel get(context) =>
      BlocProvider.of<LoginViewmodel>(context);

  LoginViewmodel({required this.loginUseCase}) : super(IntialLoginStates());

  bool isObscure = true;

  void togglePasswordVisibility() {
    isObscure = !isObscure;
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        emit(LoadingLoginState());
        var either = await loginUseCase.invoke(
            emailController.text.trim(), passwordController.text.trim());

        either.fold((error) {
          debugPrint("Login Failed: ${error.errorMessage}");
          emit(FailureLoginState(error: error));
        }, (response) {
          debugPrint("Login Successful");
          emit(SucessLoginState(loginModelEntity: response));
        });
      } catch (e) {
        debugPrint("Exception in login: $e");
      }
    }
  }
}
