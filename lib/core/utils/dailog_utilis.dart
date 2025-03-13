import 'package:flutter/material.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';

class DailogUtilis {
  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message,
                    style: AppStyle.bold40Black.copyWith(fontSize: 14),
                  ),
                )
              ],
            ),
          );
        });
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    String title = '',
    String? postActionname,
    Function? postActionFunc,
    required BuildContext context,
    required String message,
  }) {
    List<Widget> actions = [];
    if (postActionname != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            postActionFunc?.call();
          },
          child: Text(
            postActionname,
            style: AppStyle.bold40Black.copyWith(fontSize: 14),
          )));
    }

    showDialog(
        //barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              message,
              style: AppStyle.bold40Black.copyWith(fontSize: 14),
            ),
            title: Text(
              title,
              style: AppStyle.bold40Black.copyWith(fontSize: 14),
            ),
            actions: actions,
          );
        });
  }
}
