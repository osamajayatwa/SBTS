import 'package:bus_tracking_users/controllers/auth/success_reset_password_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SuccessResetPass extends StatelessWidget {
  const SuccessResetPass({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessResetPasswordControllerImp controller =
        Get.put(SuccessResetPasswordControllerImp());

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.backgroundcolor,
          elevation: 0.0,
          title: Text(
            'Success'.tr,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: AppColor.grey,
                ),
          )),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 200,
              color: AppColor.primaryColor,
            ),
            Text(
              "Password has been reset successfully".tr,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomBottunAuth(
                text: "go to home".tr,
                onPressed: () {
                  controller.goToPageLogin();
                },
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
