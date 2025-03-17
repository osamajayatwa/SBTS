import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:flutter/material.dart';

bool isWithinTimeRange1() {
  final now = DateTime.now();
  final startTime = DateTime(now.year, now.month, now.day, 00, 0);
  final endTime = DateTime(now.year, now.month, now.day, 24, 30);
  return now.isAfter(startTime) && now.isBefore(endTime);
}

void showAlertDialog1(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: AppColor.primaryColor,
        surfaceTintColor: AppColor.primaryColor,
        title: const Text(
          "Sorry",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColor.primaryColor, fontSize: 25),
        ),
        content: const Text(
          "This action is only available between 6:00 and 7:30 am.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: AppColor.grey2),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "OK",
              style: TextStyle(color: AppColor.primaryColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

bool isWithinTimeRange2() {
  final now = DateTime.now();
  final startTime = DateTime(now.year, now.month, now.day, 00, 0);
  final endTime = DateTime(now.year, now.month, now.day, 24, 00);
  return now.isAfter(startTime) && now.isBefore(endTime);
}

void showAlertDialog2(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: AppColor.primaryColor,
        surfaceTintColor: AppColor.primaryColor,
        title: const Text(
          "Sorry",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColor.primaryColor, fontSize: 25),
        ),
        content: const Text(
          "This action is only available between 1:00 and 2:30 pm.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: AppColor.grey2),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "OK",
              style: TextStyle(color: AppColor.primaryColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
