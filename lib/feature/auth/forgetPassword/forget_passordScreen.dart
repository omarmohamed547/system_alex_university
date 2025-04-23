import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/custom_elevated_button.dart';
import 'package:system_alex_univ/core/utils/di/di.dart';
import 'package:system_alex_univ/feature/auth/forgetPassword/cubit/reset_passwordStates.dart';
import 'package:system_alex_univ/feature/auth/forgetPassword/cubit/reset_passwordViewModel.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Static header section (outside BLoC)
          _buildHeaderSection(),
          // Dynamic content section (inside BLoC)
          Expanded(
            child: BlocProvider(
              create: (context) => getIt<ResetPasswordViewModel>(),
              child: _buildContentSection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image.asset(
          "assets/images/welcomeScreen.png",
          height: 400.h,
          width: 411.w,
          fit: BoxFit.fill,
        ),
        Positioned(
          bottom: -12,
          left: 24,
          child: Text(
            "Forget\nPassword?",
            style: AppStyle.bold38Black.copyWith(fontSize: 34),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return BlocBuilder<ResetPasswordViewModel, ResetPasswordstates>(
      builder: (context, state) {
        final viewModel = context.read<ResetPasswordViewModel>();
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Divider(
                  color: const Color(0xff7EB6FF),
                  thickness: 3,
                  indent: 5,
                  endIndent: 160,
                ),
                SizedBox(height: 30.h),
                _buildEmailField(context),
                SizedBox(height: 5.h),
                Divider(
                  thickness: 1,
                  indent: 0,
                  endIndent: 45,
                  color: Colors.blue,
                ),
                if (!viewModel.isFirstStep) ...[
                  SizedBox(height: 30.h),
                  _buildOtpField(context),
                  SizedBox(height: 5.h),
                  Divider(
                    thickness: 1,
                    indent: 0,
                    endIndent: 45,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 30.h),
                  _buildNewPasswordField(context),
                  SizedBox(height: 5.h),
                  Divider(
                    thickness: 1,
                    indent: 0,
                    endIndent: 45,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 30.h),
                  _buildConfirmPasswordField(context),
                  SizedBox(height: 5.h),
                  Divider(
                    thickness: 1,
                    indent: 0,
                    endIndent: 45,
                    color: Colors.blue,
                  ),
                ],
                SizedBox(height: 30.h),
                _buildActionButton(context),
                SizedBox(height: 10.h),
                _buildLoginLink(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmailField(BuildContext context) {
    final viewModel = context.read<ResetPasswordViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email", style: AppStyle.medium16SemiBlack),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 30.h,
          child: Row(
            children: [
              Image.asset("assets/icons/mail-02 - 24px.png"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Image.asset("assets/icons/Line 7.png"),
              ),
              Flexible(
                child: TextField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'example@gmail.com',
                    hintStyle: AppStyle.regular14Black,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpField(BuildContext context) {
    final viewModel = context.read<ResetPasswordViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("OTP Code", style: AppStyle.medium16SemiBlack),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 30.h,
          child: Row(
            children: [
              Image.asset("assets/icons/lock - 24px.png"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Image.asset("assets/icons/Line 7.png"),
              ),
              Flexible(
                child: TextField(
                  controller: viewModel.otpController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter OTP',
                    hintStyle: AppStyle.regular14Black,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewPasswordField(BuildContext context) {
    final viewModel = context.read<ResetPasswordViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("New Password", style: AppStyle.medium16SemiBlack),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 30.h,
          child: Row(
            children: [
              Image.asset("assets/icons/lock - 24px.png"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Image.asset("assets/icons/Line 7.png"),
              ),
              Flexible(
                flex: 8,
                child: TextField(
                  controller: viewModel.newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter new password',
                    hintStyle: AppStyle.regular14Black,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Image.asset("assets/icons/view - 24px.png"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    final viewModel = context.read<ResetPasswordViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Confirm New Password", style: AppStyle.medium16SemiBlack),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 30.h,
          child: Row(
            children: [
              Image.asset("assets/icons/lock - 24px.png"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Image.asset("assets/icons/Line 7.png"),
              ),
              Flexible(
                flex: 8,
                child: TextField(
                  controller: viewModel.confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Confirm new password',
                    hintStyle: AppStyle.regular14Black,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Image.asset("assets/icons/view - 24px.png"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    final viewModel = context.read<ResetPasswordViewModel>();
    return BlocBuilder<ResetPasswordViewModel, ResetPasswordstates>(
      builder: (context, state) {
        return custom_elevated_button(
          isLoading: state is LoadingForgetPass || state is LoadingResetPass,
          onButtonClicked: () {
            if (viewModel.isFirstStep) {
              viewModel.forgetPassword(context);
            } else {
              viewModel.resetPassword(context);
            }
          },
          text: viewModel.isFirstStep ? "Send OTP" : "Reset Password",
        );
      },
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an Account!",
          style: AppStyle.normal14Grey.copyWith(color: const Color(0xff9E9E9E)),
        ),
        TextButton(
          child: Text("Login", style: AppStyle.medium14Blue),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
