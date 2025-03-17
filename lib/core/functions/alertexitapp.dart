import 'dart:io';

import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: "Alert".tr,
      titleStyle: const TextStyle(
          color: AppColor.primaryColor, fontWeight: FontWeight.bold),
      middleText: "Do You Want To Exit The App ?".tr,
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(AppColor.primaryColor)),
            onPressed: () {
              exit(0);
            },
            child: Text("Yes".tr)),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(AppColor.primaryColor)),
            onPressed: () {
              Get.back();
            },
            child: Text("No".tr))
      ]);
  return Future.value(true);
}
