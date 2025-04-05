import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_routes.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';

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
                    "Omarmohamed",
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
                route: AppRoutes.homeScreen,
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
                route: AppRoutes.homeScreen,
              ),
              DrawerItem(
                icon: Icons.chat,
                text: "Chat-bot",
                route: AppRoutes.homeScreen,
              ),
              DrawerItem(
                icon: Icons.message,
                text: "Chat",
                route: AppRoutes.homeScreen,
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
