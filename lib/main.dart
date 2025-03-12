import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_routes.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/feature/StartUP_screen.dart';
import 'package:system_alex_univ/feature/auth/forgetPassword/forget_passordScreen.dart';
import 'package:system_alex_univ/feature/auth/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 917),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.startUpScreen,
          routes: {
            AppRoutes.loginScreen: (context) => LoginScreen(),
            AppRoutes.startUpScreen: (context) => StartUpScreen(),
            AppRoutes.resetPassScreen: (context) => ForgetPassordscreen(),
          },
        );
      },
    );
  }
}
