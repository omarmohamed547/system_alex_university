import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_routes.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/cache/shared_pref.dart';
import 'package:system_alex_univ/core/utils/di/di.dart';
import 'package:system_alex_univ/core/utils/observer.dart';
import 'package:system_alex_univ/feature/LectureTable/Lecture_table_screen.dart';
import 'package:system_alex_univ/feature/StartUP_screen.dart';
import 'package:system_alex_univ/feature/auth/forgetPassword/forget_passordScreen.dart';
import 'package:system_alex_univ/feature/auth/login/cubit/login_viewModel.dart';
import 'package:system_alex_univ/feature/auth/login/login_screen.dart';
import 'package:system_alex_univ/feature/home/cubit/home_view_model.dart';
import 'package:system_alex_univ/feature/home/homes_screen.dart';
import 'package:system_alex_univ/feature/registiration/cubit/registiration_view_model.dart';
import 'package:system_alex_univ/feature/registiration/registiration_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter is fully initialized
  configureDependencies();

  Bloc.observer = MyBlocObserver();
  await SharedPrefernceUtilis.init();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => getIt<LoginViewmodel>()),
    BlocProvider(create: (context) => getIt<RegistirationnViewModel>()),
    BlocProvider(create: (context) => getIt<HomeViewModel>()),
  ], child: const MyApp()));
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
            AppRoutes.homeScreen: (context) => HomesScreen(),
            AppRoutes.registirationScreen: (context) => RegistrationScreen(),
            AppRoutes.lectureTableScreen: (context) => LectureTable(),
          },
        );
      },
    );
  }
}
