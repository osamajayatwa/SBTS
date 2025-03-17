import 'package:bus_tracking_users/controllers/auth/signup_controller.dart';
import 'package:bus_tracking_users/core/class/handilingdataview.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/functions/alertexitapp.dart';
import 'package:bus_tracking_users/core/functions/validinput.dart';
import 'package:bus_tracking_users/view/widget/auth/costumlogintextC.dart';
import 'package:bus_tracking_users/view/widget/auth/costumtextsignup.dart';
import 'package:bus_tracking_users/view/widget/auth/custombuttonauth.dart';
import 'package:bus_tracking_users/view/widget/auth/customloginTextB.dart';
import 'package:bus_tracking_users/view/widget/auth/logoauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            clipBehavior: Clip.none,
            backgroundColor: AppColor.primaryColor,
            elevation: 0.0,
            title: Text(
              'Register'.tr,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColor.black,
                  ),
            )),
        body: PopScope(
            canPop: false,
            onPopInvoked: (bool didpop) {
              if (didpop) {
                return;
              }
              alertExitApp();
            },
            child: GetBuilder<SignUpControllerImp>(
                builder: (controller) => HandilingDataRequest(
                      statusrequest: controller.statusRequest,
                      widget: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 35),
                          child: Form(
                            key: controller.formstate,
                            child: ListView(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const LogoAuth(),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextBody(
                                    text:
                                        "Register with Your Username And Password"
                                            .tr),
                                const SizedBox(
                                  height: 10,
                                ),
                                CostumTextForm(
                                  isNumber: false,
                                  valid: (val) {
                                    return validInput(val!, 3, 20, "username");
                                  },
                                  mycontroller: controller.username,
                                  labeltext: "Username".tr,
                                  hinttext: "Enter Your Username".tr,
                                  icondata: Icons.person_outlined,
                                ),

                                // CostumTextForm(
                                //   isNumber: false,
                                //   valid: (val) {
                                //     return validInput(val!, 5, 40, "email");
                                //   },
                                //   mycontroller: controller.email,
                                //   labeltext: "18".tr,
                                //   hinttext: "12".tr,
                                //   icondata: Icons.email_outlined,
                                // ),

                                CostumTextForm(
                                  isNumber: true,
                                  valid: (val) {
                                    return validInput(val!, 7, 10, "phone");
                                  },
                                  mycontroller: controller.phone,
                                  labeltext: "Phone".tr,
                                  hinttext: "Enter Your Phone".tr,
                                  icondata: Icons.phone_outlined,
                                ),

                                GetBuilder<SignUpControllerImp>(
                                    builder: (controller) => CostumTextForm(
                                          obscure: controller.isshowpaas,
                                          onTapIcon: () {
                                            controller.showpass();
                                          },
                                          isNumber: false,
                                          valid: (val) {
                                            return validInput(
                                                val!, 5, 30, "password");
                                          },
                                          mycontroller: controller.password,
                                          labeltext: "Password".tr,
                                          hinttext: "Enter Your Password".tr,
                                          icondata: Icons.lock_outlined,
                                        )),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomBottunAuth(
                                  text: "Register".tr,
                                  onPressed: () {
                                    controller.signUp();
                                  },
                                ),
                                const SizedBox(height: 30),
                                CostumSignUp(
                                  textone: "have an account".tr + " " + "?".tr,
                                  texttow: " " + "LogIn".tr + " ",
                                  onTap: () {
                                    controller.goToLogInIn();
                                  },
                                )
                              ],
                            ),
                          )),
                    ))));
  }
}
