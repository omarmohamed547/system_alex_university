import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/domain/entites/GetCourses_response_Entity.dart';

class ScheduleItem extends StatelessWidget {
  SessionEntity sessionEntity;
  final String courseName; // Add course name

  ScheduleItem(
      {super.key, required this.sessionEntity, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff97c4fe), borderRadius: BorderRadius.circular(30)),
      width: 145.w,
      height: 170.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Container(
              width: 105.w,
              height: 37.h,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(27)),
              child: Center(
                child: Text(
                  sessionEntity.startTime.toString(),
                  style: AppStyle.white16Inter
                      .copyWith(color: Color(0xff000000), fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 115.w, // Match the width of the container
              child: Text(
                "$courseName",
                style: AppStyle.white16Inter,
                textAlign: TextAlign.center, // Centers the text
              ),
            ),
            SizedBox(
              width: 108.w, // Match the width of the container
              child: Text(
                "${sessionEntity.type}",
                style: AppStyle.white16Inter,
                textAlign: TextAlign.center, // Centers the text
              ),
            ),
            SizedBox(
              width: 108.w, // Match the width of the container
              child: Text(
                "(${sessionEntity.room})",
                style: AppStyle.white16Inter.copyWith(color: Color(0xff000000)),
                textAlign: TextAlign.center, // Centers the text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
