import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_routes.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/custom_elevated_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  Text(
                    "ID",
                    style: AppStyle.medium16SemiBlack,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 30.h,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/mail-02 - 24px.png",
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Image.asset("assets/icons/Line 7.png")),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '2022---',
                                hintStyle: AppStyle.regular14Black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Divider(
                    thickness: 1,
                    indent: 0,
                    endIndent: 45,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Password",
                    style: AppStyle.medium16SemiBlack,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 30.h,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/lock - 24px.png",
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Image.asset("assets/icons/Line 7.png")),
                        Flexible(
                          flex: 8,
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'enter your password',
                                hintStyle: AppStyle.regular14Black),
                          ),
                        ),
                        Flexible(
                            flex: 2,
                            child: Image.asset("assets/icons/view - 24px.png"))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Divider(
                    thickness: 1,
                    indent: 0,
                    endIndent: 45,
                    color: Colors.blue,
                  ),
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
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.resetPassScreen);
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
            custom_elevated_button(onButtonClicked: () {}, text: "Login")
          ],
        ),
      ),
    );
  }
}
