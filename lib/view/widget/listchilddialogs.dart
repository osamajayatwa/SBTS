import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:bus_tracking_users/controllers/home/home_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/functions/translatefatabase.dart';
import 'package:bus_tracking_users/data/model/student_for_parent.dart';

void showConfirmDialog(BuildContext context, Items student) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Confirm".tr,
    desc: "Are you sure you want to mark".tr +
        " " +
        "${translateDatabase(student.nameAr, student.nameEn)}" +
        " " +
        "as going to school".tr +
        "?".tr,
    style: AlertStyle(
      backgroundColor: Colors.white,
      titleStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
      descStyle: TextStyle(
        fontSize: 16,
        color: Colors.black.withOpacity(0.7),
      ),
      isCloseButton: false,
      isOverlayTapDismiss: false,
      animationType: AnimationType.fromTop,
      animationDuration: Duration(milliseconds: 300),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    buttons: [
      DialogButton(
        child: Text(
          "Cancel".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        color: Colors.grey,
        width: 120,
      ),
      DialogButton(
        child: Text(
          "Confirm".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Get.find<HomeControllerImp>().markAsPresent(student.stdId!);
          Navigator.of(context).pop();
        },
        color: Colors.green,
        width: 120,
      ),
    ],
  ).show();
}

void showMissingDialog(BuildContext context, Items student) {
  TextEditingController reasonController = TextEditingController();

  Alert(
    context: context,
    type: AlertType.warning,
    title: "Mark".tr +
        " " +
        "${translateDatabase(student.nameAr, student.nameEn)}" +
        " " +
        "as not going to school".tr,
    desc: "Why is this student not going to school today?".tr,
    style: AlertStyle(
      backgroundColor: Colors.white,
      titleStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.primaryColor,
      ),
      descStyle: TextStyle(
        fontSize: 16,
        color: Colors.black.withOpacity(0.7),
      ),
      isCloseButton: false,
      isOverlayTapDismiss: false,
      animationType: AnimationType.fromTop,
      animationDuration: Duration(milliseconds: 300),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        TextField(
          controller: reasonController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: "Reason".tr,
            labelStyle: TextStyle(color: AppColor.primaryColor),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.grey, width: 1.5),
            ),
          ),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        child: Text(
          "Cancel".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        color: Colors.grey,
        width: 120,
      ),
      DialogButton(
        child: Text(
          "Confirm".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          if (reasonController.text.trim().isNotEmpty) {
            Get.find<HomeControllerImp>().markAsNotGoing(student.stdId!);
            Navigator.of(context).pop();
          } else {
            Get.snackbar(
              "Error".tr,
              "Please provide a reason.".tr,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.all(10),
              borderRadius: 10,
              icon: Icon(Icons.error, color: Colors.white),
            );
          }
        },
        color: Colors.red,
        width: 120,
      ),
    ],
  ).show();
}
