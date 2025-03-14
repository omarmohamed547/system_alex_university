import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({
    super.key,
  });

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
              child: Center(
                child: Text(
                  "08:30 AM",
                  style: AppStyle.white16Inter
                      .copyWith(color: Color(0xff000000), fontSize: 14),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(27)),
            ),
            SizedBox(
              width: 105.w, // Match the width of the container
              child: Text(
                "Operating System Section",
                style: AppStyle.white16Inter,
                textAlign: TextAlign.center, // Centers the text
              ),
            ),
            SizedBox(
              width: 105.w, // Match the width of the container
              child: Text(
                "(425)",
                style: AppStyle.white16Inter.copyWith(color: Color(0xff000000)),
                textAlign: TextAlign.center, // Centers the text
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
