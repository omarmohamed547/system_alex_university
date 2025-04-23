import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_routes.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/cache/shared_pref.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback onClose;
  const HomeDrawer({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drawer Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    "FOURTH YEAR",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    SharedPrefernceUtilis.getData("username")?.toString() ??
                        'No Name',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Image.asset(
                      "assets/images/FcdsLogo.png",
                      height: 72.h,
                      width: 196.w,
                    ),
                  ),
                ],
              ),

              // Drawer Menu Items
              DrawerItem(
                icon: Icons.home,
                text: "Home",
                route: AppRoutes.homeScreen,
              ),
              DrawerItem(
                icon: Icons.event,
                text: "Attendance",
                route: AppRoutes.homeScreen,
              ),
              DrawerItem(
                icon: Icons.assessment,
                text: "Performance",
                route: AppRoutes.performaneScreen,
              ),
              DrawerItem(
                icon: Icons.app_registration,
                text: "Registration",
                route: AppRoutes.registirationScreen,
              ),
              DrawerItem(
                icon: Icons.calendar_today,
                text: "Lecture Table",
                route: AppRoutes.lectureTableScreen,
              ),
              DrawerItem(
                icon: Icons.school,
                text: "Exams Table",
                route: AppRoutes.examTableScreen,
              ),
              DrawerItem(
                icon: Icons.chat,
                text: "Chat-bot",
                route: AppRoutes.homeScreen,
              ),
              DrawerItem(
                icon: Icons.message,
                text: "Chat",
                route: AppRoutes.chatScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Drawer Item Widget
class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String route;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    // Get current route to check if this item is active
    String? currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
      color: currentRoute == route
          ? const Color.fromRGBO(193, 220, 255, 1)
          : Colors.transparent,
      child: ListTile(
        leading: Icon(
          icon,
          color: currentRoute == route
              ? Color.fromRGBO(45, 104, 254, 1)
              : Colors.grey,
        ),
        title: Text(
          text,
          style: AppStyle.text16Inter.copyWith(
            color: currentRoute == route
                ? Color.fromRGBO(45, 104, 254, 1)
                : Colors.black,
          ),
        ),
        onTap: () {
          if (currentRoute != route) {
            Navigator.pushNamed(context, route);
          }
        },
      ),
    );
  }
}

class ShowHomeDrawer extends StatelessWidget {
  const ShowHomeDrawer({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _scaffoldKey.currentState?.openDrawer(); // Open Drawer
      },
      child: Image.asset(
        "assets/icons/drawer.png",
        color: Colors.white,
        height: 18.h,
        width: 32.w,
      ),
    );
  }
}

class TitleScreenWithDrawer extends StatelessWidget {
  String title;
  Widget? icon;
  TitleScreenWithDrawer({
    required this.title,
    this.icon,
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff83B8FD), Colors.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,

              stops: [
                0.9,
                1.0
              ], // Most of it is blue, fading to white only at bottom-left
            ),
          ),
          child: Image.asset(
            fit: BoxFit.cover,
            height: 300.h,
            "assets/images/Rectangle 151.png",
          ),
        ),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                maxLines: 2,
                title,
                style: AppStyle.white16Inter.copyWith(fontSize: 36)),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: icon ?? ShowHomeDrawer(scaffoldKey: _scaffoldKey),
        ),
      ],
    );
  }
}
