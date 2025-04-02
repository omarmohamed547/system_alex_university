import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_routes.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/feature/home/homes_screen.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback onClose;
  const HomeDrawer({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Stack(
          children: [
            Container(
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
                      context: context,
                    ),
                    DrawerItem(
                      icon: Icons.event,
                      text: "Attendance",
                      route: AppRoutes.homeScreen,
                      context: context,
                    ),
                    DrawerItem(
                      icon: Icons.assessment,
                      text: "Performance",
                      route: AppRoutes.homeScreen,
                      context: context,
                    ),
                    DrawerItem(
                      icon: Icons.app_registration,
                      text: "Registration",
                      route: AppRoutes.registirationScreen,
                      context: context,
                    ),
                    DrawerItem(
                      icon: Icons.calendar_today,
                      text: "Lecture Table",
                      route: AppRoutes.homeScreen,
                      context: context,
                    ),
                    DrawerItem(
                      icon: Icons.school,
                      text: "Exams Table",
                      route: AppRoutes.homeScreen,
                      context: context,
                    ),
                    DrawerItem(
                      icon: Icons.chat,
                      text: "Chat-bot",
                      route: AppRoutes.homeScreen,
                      context: context,
                    ),
                    DrawerItem(
                      icon: Icons.message,
                      text: "Chat",
                      route: AppRoutes.homeScreen,
                      context: context,
                    ),
                  ],
                ),
              ),
            ),

            // Close Button
            Positioned(
              top: 40.h,
              right: -20.w,
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ],
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
  final BuildContext context;
  DrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.route,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(
        text,
        style: AppStyle.text16Inter,
      ),
      onTap: () {
        // Get current route name
        String? currentRoute = ModalRoute.of(context)?.settings.name;

        // Navigate only if it's a different route
        if (currentRoute != route) {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
