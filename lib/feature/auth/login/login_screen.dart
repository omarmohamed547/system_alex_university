import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_routes.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/build_text_field.dart';
import 'package:system_alex_univ/core/utils/cache/shared_pref.dart';
import 'package:system_alex_univ/core/utils/custom_elevated_button.dart';
import 'package:system_alex_univ/core/utils/custom_text_field.dart';
import 'package:system_alex_univ/core/utils/dailog_utilis.dart';
import 'package:system_alex_univ/feature/auth/login/cubit/Login_states.dart';
import 'package:system_alex_univ/feature/auth/login/cubit/login_viewModel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewmodel, LoginStates>(
      listener: (context, state) {
        if (state is FailureLoginState) {
          DailogUtilis.hideLoading(context: context);
          DailogUtilis.showMessage(
              title: 'Error',
              postActionname: 'Ok',
              context: context,
              message: state.error.errorMessage);
        } else if (state is SucessLoginState) {
          DailogUtilis.hideLoading(context: context);
          DailogUtilis.showMessage(
              title: 'Success',
              postActionname: 'Ok',
              context: context,
              postActionFunc: () {
                SharedPrefernceUtilis.saveData(
                    'token', state.loginModelEntity.token);
                SharedPrefernceUtilis.saveData(
                    'username', state.loginModelEntity.user!.name);
                SharedPrefernceUtilis.saveData(
                    'email', state.loginModelEntity.user!.email);
                SharedPrefernceUtilis.saveData(
                    'userId', state.loginModelEntity.user!.id);
                Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
              },
              message: 'Login Successfully');
        } else {
          DailogUtilis.showLoading(context: context, message: "Loading...");
        }
      },
      child: Scaffold(
        body: Form(
          key: LoginViewmodel.get(context).formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.asset(
                      "assets/images/welcomeScreen.png",
                      height: 400.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 24,
                      left: 24,
                      child: Text(
                        "Log in",
                        style: AppStyle.bold38Black,
                      ),
                    ),
                    Divider(
                      color: Color(0xff7EB6FF),
                      thickness: 3,
                      indent: 25,
                      endIndent: 250,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.w, top: 39.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      buildTextField(
                        autofillHints: [AutofillHints.email],
                        context,
                        label: "ID",
                        controller: LoginViewmodel.get(context).emailController,
                        hintText: "2022---",
                        iconPath: "assets/icons/mail-02 - 24px.png",
                      ),
                      SizedBox(height: 30.h),
                      buildTextField(context,
                          label: "Password",
                          autofillHints: [AutofillHints.password],
                          controller:
                              LoginViewmodel.get(context).passwordController,
                          hintText: "Enter your password",
                          iconPath: "assets/icons/lock - 24px.png",
                          isPassword: true,
                          suffix: Image.asset("assets/icons/view - 24px.png")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 44.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remember Me",
                        style: AppStyle.medium12Black,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            await Navigator.pushNamed(
                                context, AppRoutes.resetPassScreen);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${e.toString()}')),
                            );
                          }
                        },
                        child: Text(
                          "Reset Password?",
                          style: AppStyle.semibold12Blue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                custom_elevated_button(
                    onButtonClicked: () {
                      LoginViewmodel.get(context).login();
                    },
                    text: "Login")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
