import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_routes.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';

class StartUpScreen extends StatelessWidget {
  const StartUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(
                "assets/images/welcomeScreen.png",
                height: 500.h,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Image.asset(
                "assets/images/logo_alex_univ.png",
                height: 123.h,
                width: 188.w,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 29.w),
            child: Text(
              "Welcome",
              style: AppStyle.bold40Black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 29.w, top: 20.h),
            child: Text(
              "This app will help you  make your college life easier",
              style: AppStyle.normal14Grey,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.loginScreen);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    height: 36.h,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Continue",
                          style: AppStyle.normal14Grey,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.asset("assets/icons/continueArrowIcon.png")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
