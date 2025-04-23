import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_routes.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/custom_elevated_button.dart';

class ForgetPassordscreen extends StatelessWidget {
  const ForgetPassordscreen({super.key});

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
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 25.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    color: Color(0xff7EB6FF),
                    thickness: 3,
                    indent: 5,
                    endIndent: 160,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Email",
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
                                hintText: 'ramdan@gmail.com',
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
                    "Phone no",
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
                          "assets/icons/smart-phone-01 - 24px.png",
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Image.asset("assets/icons/Line 7.png")),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '01020632425',
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
                    "New Password",
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
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Confirm New Password",
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
                                hintText: 'Confirm your password',
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
            custom_elevated_button(
                onButtonClicked: () {}, text: "Reset password"),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an Account!",
                  style:
                      AppStyle.normal14Grey.copyWith(color: Color(0xff9E9E9E)),
                ),
                TextButton(
                  child: Text(
                    "Login",
                    style: AppStyle.medium14Blue,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
