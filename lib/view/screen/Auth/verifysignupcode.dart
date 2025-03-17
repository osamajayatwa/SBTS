import 'package:bus_tracking_users/controllers/auth/verify_signup_contorller.dart';
import 'package:bus_tracking_users/core/class/handilingdataview.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/view/widget/auth/customloginTextA.dart';
import 'package:bus_tracking_users/view/widget/auth/customloginTextB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerifySignUp extends StatelessWidget {
  const VerifySignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifySignUpControllerImp());
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.backgroundcolor,
            elevation: 0.0,
            title: Text(
              '00'.tr,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColor.grey,
                  ),
            )),
        body: GetBuilder<VerifySignUpControllerImp>(
            builder: (controller) => HandilingDataRequest(
                statusrequest: controller.statusrequest,
                widget: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CostumTextTitle(
                        text: "30".tr,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CustomTextBody(
                          text: "Pleaze Enter The Digit Code Sent To"),
                      const SizedBox(
                        height: 40,
                      ),
                      OtpTextField(
                        fieldWidth: 50.0,
                        borderRadius: BorderRadius.circular(20),
                        numberOfFields: 5,
                        borderColor: const Color(0xFF512DA8),
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) {
                          controller.goToSuccessSignUp(verificationCode);
                        },
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        onTap: () {
                          controller.reSend();
                        },
                        child: const Center(
                            child: Text(
                          "Resend verfiy code",
                          style: TextStyle(
                              color: AppColor.primaryColor, fontSize: 20),
                        )),
                      )
                    ],
                  ),
                ))));
  }
}
