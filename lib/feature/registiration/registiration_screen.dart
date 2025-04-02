import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/feature/home/home_drawer.dart';
import 'package:system_alex_univ/feature/home/homes_screen.dart';

class RegistrationScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: 256.w,
        child: Drawer(
          child: HomeDrawer(
            onClose: () {},
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                width: double.infinity,
                height: 300.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.white],
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text("Registration",
                      style: AppStyle.white16Inter.copyWith(fontSize: 36)),
                ),
              ),
              Positioned(
                  top: 50,
                  left: 20,
                  child: ShowHomeDrawer(scaffoldKey: _scaffoldKey))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: Color(0xff83B8FD))),
                  width: 145.w,
                  height: 36.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: DropdownButton<String>(
                      value: "Fourthyear",
                      items: ["Fourthyear"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: Color(0xff83B8FD))),
                  width: 135.w,
                  height: 36.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: DropdownButton<String>(
                      value: "Sort A-Z",
                      items: ["Sort A-Z"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text("0", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: 4,
              itemBuilder: (context, index) {
                return CourseCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 208.h,
        width: 390.w,
        padding: EdgeInsets.only(left: 8.w),
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
            color: Color(0xffFEF9F2),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(32)),
            border: Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, 0.25))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color: Color(0xff83B8FD))),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: Text("02-24-2024",
                          style: TextStyle(color: Colors.orange)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 2,
                      "intro to Social\n Network",
                      style: AppStyle.bold38Black.copyWith(fontSize: 24),
                    ),
                    SizedBox(
                      width: 12.h,
                    ),
                    Text("Dr reem EssamELdin", style: AppStyle.regular14Black),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Align text to the start

                          children: [
                            Text("Lec", style: TextStyle(color: Colors.orange)),
                            Text("Tue 10:30Am",
                                style: TextStyle(color: Colors.orange)),
                          ],
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Align text to the start

                          children: [
                            Text("Sec", style: TextStyle(color: Colors.orange)),
                            Text("Tue 10:30Am",
                                style: TextStyle(color: Colors.orange)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff83B8FD),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              width: 70.w,
              height: double.infinity,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 42,
              ),
            ),
          ],
        ));
  }
}
