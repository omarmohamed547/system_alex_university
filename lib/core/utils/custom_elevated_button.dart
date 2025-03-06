import 'package:event_planning_ass/utilis/app_colors.dart';
import 'package:event_planning_ass/utilis/app_style.dart';
import 'package:flutter/material.dart';

class custom_elevated_button extends StatelessWidget {
  String text;
  Color? color;
  TextStyle? style;
  Widget? icon;
  Function onButtonClicked;
  EdgeInsets? paddingHeight;
  EdgeInsets? paddingContainer;

  custom_elevated_button({
    required this.onButtonClicked,
    this.paddingHeight,
    this.paddingContainer,
    this.icon,
    required this.text,
    this.style,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      padding: paddingContainer ??
          EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.01),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  side:
                      BorderSide(width: 1, color: AppColors.primaryColorLight),
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: color ?? AppColors.primaryColorLight,
              elevation: 0),
          onPressed: () {
            onButtonClicked();
          },
          child: Padding(
            padding:
                paddingHeight ?? EdgeInsets.symmetric(vertical: height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? SizedBox.shrink(),
                SizedBox(
                  width: width * 0.02,
                ),
                Text(
                  text,
                  style: style ?? AppStyle.Medium16White.copyWith(fontSize: 20),
                ),
              ],
            ),
          )),
    );
  }
}
