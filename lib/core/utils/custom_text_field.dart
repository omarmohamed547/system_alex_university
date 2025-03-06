import 'package:event_planning_ass/utilis/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  void Function(String)? onChanged;
  String hintText;
  Color? borderColor;
  TextStyle? hintStyle;
  Widget? prefixIcon;
  Widget? suffixxIcon;
  EdgeInsets? margin;
  String? label;
  int? maxlines;
  TextEditingController? controller;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  bool? obscureText;
  CustomTextField({
    this.onChanged,
    this.obscureText, // Corrected property name
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.maxlines,
    this.suffixxIcon,
    this.label,
    this.prefixIcon,
    this.hintStyle,
    this.margin,
    required this.hintText,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: margin,
      /* EdgeInsets.only(
        //right: width * 0.02,
       // left: width * 0.02,
        //top: height * 0.05,
      )*/
      // padding: EdgeInsets.symmetric(  horizontal: width * 0.03, vertical: height * 0.001),
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscureText ?? false, // Corrected here
        controller: controller,
        validator: validator,
        maxLines: (obscureText ?? false) ? 1 : maxlines,

        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    BorderSide(width: 1.3, color: borderColor ?? Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1, color: borderColor ?? Color(0xff7B7B7B))),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    BorderSide(width: 1, color: borderColor ?? Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    BorderSide(width: 1, color: borderColor ?? Colors.red)),
            prefixIcon: prefixIcon,
            suffixIcon: suffixxIcon,
            hintText: hintText,
            hintStyle: hintStyle ?? AppStyle.Medium16grey),
      ),
    );
  }
}
