import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/feature/home/home_drawer.dart';
import 'package:system_alex_univ/feature/home/homes_screen.dart';

class PerformanceScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: 260.w,
        child: Drawer(
          child: HomeDrawer(
            onClose: () {},
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TitleScreenWithDrawer(
              scaffoldKey: _scaffoldKey,
              title: "performance",
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 276.h,
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(0.6)),
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        "Education Hours",
                        style: AppStyle.black24Inter.copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 145.h,
                              width: 145.w,
                              child: const CircularProgressIndicator(
                                value: 0.66,
                                strokeWidth: 8,
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff83B8FD),
                                ),
                              ),
                            ),
                          ),
                          const Icon(Icons.person,
                              color: Color(0xff83B8FD), size: 40),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.circle,
                              color: Color(0xff83B8FD), size: 12),
                          SizedBox(width: 4),
                          Text("Taken 132H",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          SizedBox(width: 16),
                          Icon(Icons.circle, color: Colors.grey, size: 12),
                          SizedBox(width: 4),
                          Text("Left 12H",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "Year",
                        style: AppStyle.extraBold14Blue,
                      ),
                      Text(
                        "Forth",
                        style: AppStyle.bold38Black.copyWith(fontSize: 13),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        "CGPA",
                        style: AppStyle.extraBold14Blue,
                      ),
                      Text(
                        "3.3323",
                        style: AppStyle.bold38Black.copyWith(fontSize: 13),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        "Hours\nregistered",
                        style: AppStyle.extraBold14Blue,
                      ),
                      Text(
                        "18",
                        style: AppStyle.bold38Black.copyWith(fontSize: 13),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 16.w),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xffF2F2F2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    label: Text("Delete",
                        style: TextStyle(
                            color: Color(0xff807A7A),
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xffF2F2F2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.grey,
                    ),
                    label: const Text("Filter",
                        style: TextStyle(
                            color: Color(0xff807A7A),
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color(0xffF2F2F2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.search, color: Colors.grey),
                      label: const Text("Search",
                          style: TextStyle(
                              color: Color(0xff807A7A),
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              color: Color(0xffF2F2F2),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Text("Name ⬍",
                          style: AppStyle.regular14Black.copyWith(
                              fontSize: 12, color: Color(0xff404040)))),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Hours ⬍",
                        style: AppStyle.regular14Black.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xff404040)),
                      )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Grade ⬍",
                        style: AppStyle.regular14Black.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xff404040)),
                      )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Midterm ⬍",
                        style: AppStyle.regular14Black.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xff404040)),
                      )),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 16.h,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => PerformanceSubjItem(),
              childCount: 5,
            ),
          )
        ],
      ),
    );
  }
}

class PerformanceSubjItem extends StatelessWidget {
  const PerformanceSubjItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Color(0xffF2F2F2),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                "Linearalgebra",
                style: AppStyle.regular14Black
                    .copyWith(fontSize: 12, color: Color(0xff404040)),
              )),
          Expanded(
              flex: 2,
              child: Text(
                "3H",
                style: AppStyle.regular14Black.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff404040)),
              )),
          Expanded(
              flex: 2,
              child: Text(
                "B-",
                style: AppStyle.regular14Black.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff404040)),
              )),
          Expanded(
              flex: 2,
              child: Text(
                "18",
                style: AppStyle.regular14Black.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff404040)),
              )),
        ],
      ),
    );
  }
}
