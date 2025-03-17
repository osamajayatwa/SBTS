import 'package:bus_tracking_users/controllers/forgetpass/reset_pass_controller.dart';
import 'package:bus_tracking_users/core/class/handilingdataview.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/functions/validinput.dart';
import 'package:bus_tracking_users/view/widget/auth/costumlogintextC.dart';
import 'package:bus_tracking_users/view/widget/auth/custombuttonauth.dart';
import 'package:bus_tracking_users/view/widget/auth/customloginTextA.dart';
import 'package:bus_tracking_users/view/widget/auth/customloginTextB.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordControllerImp());
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.backgroundcolor,
            elevation: 0.0,
            title: Text(
              'Reset Password'.tr,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColor.grey,
                  ),
            )),
        body: GetBuilder<ResetPasswordControllerImp>(
          builder: (controller) => HandilingDataRequest(
              statusrequest: controller.statusrequest,
              widget: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  child: Form(
                    key: controller.formstate,
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CostumTextTitle(
                          text: "New Password".tr,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextBody(text: "Please Enter new Password".tr),
                        const SizedBox(
                          height: 40,
                        ),
                        CostumTextForm(
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!, 5, 20, "password");
                          },
                          mycontroller: controller.password,
                          labeltext: "New Password".tr,
                          hinttext: "Please Enter new Password".tr,
                          icondata: Icons.lock_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CostumTextForm(
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!, 5, 40, "password");
                          },
                          mycontroller: controller.repassword,
                          hinttext: "Re".tr + " " + "Password".tr,
                          icondata: Icons.lock_outline,
                          labeltext: "New Password".tr,
                        ),
                        const SizedBox(height: 20),
                        CustomBottunAuth(
                          text: "Save".tr,
                          onPressed: () {
                            controller.resetpass();
                          },
                        ),
                      ],
                    ),
                  ))),
        ));
  }
}
