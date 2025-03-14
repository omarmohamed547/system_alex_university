import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';

class Anouncmentsitem extends StatelessWidget {
  const Anouncmentsitem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff97c4fe), borderRadius: BorderRadius.circular(30)),
      width: 274.w,
      height: 170.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 23.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Image.asset(
                        width: 43.w,
                        height: 43.h,
                        color: Colors.black,
                        "assets/icons/Avatar Placeholder.png"),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DR. Mohammed",
                        style: AppStyle.black24Inter.copyWith(fontSize: 12),
                      ),
                      Text(
                        "3H ago",
                        style: AppStyle.grey10Inter,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, top: 16),
              child: Text("Today’s stream lecture is cancelled",
                  style: AppStyle.white16Inter
                      .copyWith(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}
