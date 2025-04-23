import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_alex_univ/core/utils/app_routes.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/cache/shared_pref.dart';
import 'package:system_alex_univ/feature/profile/cubit/profile_states.dart';
import 'package:system_alex_univ/feature/profile/cubit/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch data from SharedPreferences with null checks
    final name =
        SharedPrefernceUtilis.getData("username")?.toString() ?? 'No Name';
    final email =
        SharedPrefernceUtilis.getData("email")?.toString() ?? 'No Email';
    final id = SharedPrefernceUtilis.getData("userId")?.toString() ?? 'No ID';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Deeper Curved Bottom
            Stack(
              alignment: Alignment.bottomCenter,

              clipBehavior: Clip.none, // Allows overflow of clipped content
              children: [
                // Blue background with image
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      height: 250.h,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF83B8FD), Color(0xFF5AA9FF)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/Rectangle 151.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                        left: 20.w,
                        top: 50.h,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                                size: 32,
                                Icons.arrow_back,
                                color: Colors.white))),
                  ],
                ),

                // White curved overlay with subtle dip
                Positioned(
                  bottom: -8,
                  left: 0,
                  right: 0,
                  child: ClipPath(
                    clipper: SubtleDipClipper(),
                    child: Container(
                      height: 60.h, // Reduced height for subtle curve
                      color: Colors.white,
                    ),
                  ),
                ),

                // Profile Avatar
                Positioned(
                  bottom: 30.h, // Adjusted position
                  child: SizedBox(
                    width: 140.w,
                    height: 140.h,
                    child: BlocBuilder<ProfileViewModel, ProfileStates>(
                      bloc: ProfileViewModel.get(context)..getProfilePicture(),
                      builder: (context, state) {
                        if (state is FailureProfilePicture) {
                          return Center(child: Text(state.error.errorMessage));
                        } else if (state is SuccessProfilePicture) {
                          return ClipOval(
                            child: Image.network(
                              state.profilePictureEntity.profilePicture ?? "",
                              fit: BoxFit.fill,
                            ),
                          );
                        } else {
                          return CircularProgressIndicator(
                            color: Colors.grey,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Profile Content Section
            Padding(
              padding: EdgeInsets.only(
                  top: 20.h, left: 24.w, right: 24.w), // Increased top padding
              child: Column(
                children: [
                  // Profile Info
                  Column(
                    children: [
                      Text(
                        name,
                        style: AppStyle.bold38Black.copyWith(fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        email,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Color.fromRGBO(102, 99, 99, 1),
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        id,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Color.fromRGBO(102, 99, 99, 1),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),

                  // Menu Items
                  Column(
                    children: [
                      _buildMenuItem('Bylaw course', Icons.book),
                      _buildMenuItem('My complaints', Icons.report_problem),
                      _buildMenuItem('Academic fee', Icons.school),
                      _buildMenuItem(
                        'GPA calculator',
                        Icons.calculate,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.gpaCalaulator);
                        },
                      ),
                      SizedBox(height: 16.h),
                      _buildMenuItem(
                        'Logout Account',
                        Icons.logout,
                        isLogout: true,
                        onTap: () async {
                          try {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.clear();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.loginScreen,
                              (route) => false,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Logout failed: $e')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon, {
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Color.fromRGBO(131, 184, 253, 1),
        size: 24.r,
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
            fontSize: 14,
            color: isLogout ? Colors.red : Color.fromRGBO(102, 99, 99, 1),
            fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.r,
        color: Color.fromRGBO(107, 114, 128, 1),
      ),
      onTap: onTap,
    );
  }
}

class SubtleDipClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top-left
    path.lineTo(0, 0);

    // Draw to before center - moderate base
    path.lineTo(size.width / 2 - 70, 0);

    // Create moderate downward curve
    path.quadraticBezierTo(
        size.width / 2,
        60, // Moderate depth
        size.width / 2 + 70,
        0);

    // Complete top line
    path.lineTo(size.width, 0);

    // Complete the rectangle
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
