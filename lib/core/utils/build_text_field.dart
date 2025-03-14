import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';

Widget buildTextField(BuildContext context,
    {required String label,
    required String hintText,
    required String iconPath,
    required TextEditingController controller,
    Iterable<String>? autofillHints,
    bool isPassword = false,
    Widget? suffix}) {
  return Padding(
    padding: EdgeInsets.only(
        top: 8.h, bottom: 8.h, right: 42.w), // Adjust vertical spacing
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyle.medium16SemiBlack,
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "This field is required";
            }
            return null;
          },
          autofillHints: autofillHints, // For email autofill

          decoration: InputDecoration(
            suffixIcon: suffix,
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 32.w, bottom: 8.h),
              child: Image.asset(
                iconPath,
                height: 24.h,
                width: 24.w,
              ),
            ),
            hintText: hintText,

            hintStyle: AppStyle.regular14Black,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff616161)),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff616161)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            //contentPadding: EdgeInsets.only(bottom: 12.w),
          ),
        ),
      ],
    ),
  );
}
