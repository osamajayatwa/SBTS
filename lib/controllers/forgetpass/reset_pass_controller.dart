import 'package:bus_tracking_users/core/class/statusrequest.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/functions/handilingdata.dart';
import 'package:bus_tracking_users/core/services/services.dart';

import 'package:bus_tracking_users/data/data_source/remote/forgetpass/resetpass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {
  resetpass();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController password;
  late TextEditingController repassword;
  StatusRequest statusrequest = StatusRequest.none;
  MyServices myServices = Get.find();
  ResetData resetData = ResetData(Get.find());

  @override
  resetpass() async {
    if (password.text != repassword.text) {
      return Get.defaultDialog(
          title: "warning", middleText: "password not match");
    }

    if (formstate.currentState!.validate()) {
      String? id = myServices.sharedPreferences.getString("id");
      statusrequest = StatusRequest.loading;
      update();
      var response = await resetData.resetdata(id!, password.text);
      statusrequest = handilingData(response);
      if (StatusRequest.success == statusrequest) {
        Get.offNamed(AppRoute.successResetpassword);
      } else {
        Get.defaultDialog(title: "Warning", middleText: "Try Again");
        statusrequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  @override
  void onInit() {
    password = TextEditingController();
    repassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }
}
