import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';

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
                    DrawerItem(icon: Icons.home, text: "Home"),
                    DrawerItem(icon: Icons.event, text: "Attendance"),
                    DrawerItem(icon: Icons.assessment, text: "Performance"),
                    DrawerItem(
                        icon: Icons.app_registration, text: "Registration"),
                    DrawerItem(
                        icon: Icons.calendar_today, text: "Lecture Table"),
                    DrawerItem(icon: Icons.school, text: "Exams Table"),
                    DrawerItem(icon: Icons.chat, text: "Chat-bot"),
                    DrawerItem(icon: Icons.message, text: "Chat"),
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
  const DrawerItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(
        text,
        style: AppStyle.text16Inter,
      ),
      onTap: () {},
    );
  }
}
