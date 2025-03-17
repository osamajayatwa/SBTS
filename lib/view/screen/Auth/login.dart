import 'package:bus_tracking_users/controllers/auth/login_controller.dart';
import 'package:bus_tracking_users/core/class/handilingdataview.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/functions/alertexitapp.dart';
import 'package:bus_tracking_users/core/functions/validinput.dart';
import 'package:bus_tracking_users/view/widget/auth/costumlogintextC.dart';
import 'package:bus_tracking_users/view/widget/auth/custombuttonauth.dart';
import 'package:bus_tracking_users/view/widget/auth/customloginTextA.dart';
import 'package:bus_tracking_users/view/widget/auth/customloginTextB.dart';
import 'package:bus_tracking_users/view/widget/auth/logoauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            clipBehavior: Clip.none,
            backgroundColor: AppColor.primaryColor,
            elevation: 0.0,
            title: Text(
              'LogIn'.tr,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColor.black,
                  ),
            )),
        body: GetBuilder<LoginControllerImp>(
          builder: (controller) => HandilingDataRequest(
              statusrequest: controller.statusRequest,
              widget: PopScope(
                canPop: false,
                onPopInvoked: (bool didpop) {
                  if (didpop) {
                    return;
                  }
                  alertExitApp();
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 35),
                    child: Form(
                      key: controller.formstate,
                      child: ListView(
                        children: [
                          const LogoAuth(),
                          const SizedBox(
                            height: 15,
                          ),
                          CostumTextTitle(
                            text: "Welcome".tr,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextBody(
                              text:
                                  "SignIn with Your Username And Password".tr),
                          const SizedBox(
                            height: 40,
                          ),
                          CostumTextForm(
                            isNumber: false,
                            valid: (val) {
                              return validInput(val!, 0, 100, "email");
                            },
                            mycontroller: controller.username,
                            labeltext: "Username".tr,
                            hinttext: "Enter Your Username".tr,
                            icondata: Icons.email_outlined,
                            obscure: false,
                          ),
                          const SizedBox(height: 20),
                          GetBuilder<LoginControllerImp>(
                            builder: (controller) => CostumTextForm(
                              obscure: controller.isshowpassword,
                              onTapIcon: () {
                                controller.showPassword();
                              },
                              isNumber: false,
                              valid: (val) {
                                return validInput(val!, 1, 20, "password");
                              },
                              mycontroller: controller.password,
                              labeltext: "Password".tr,
                              hinttext: "Enter Your Password".tr,
                              icondata: Icons.lock_outlined,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     controller.goToForgetPassword();
                          //   },
                          //   child: Text(
                          //     "14".tr,
                          //     textAlign: TextAlign.end,
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Dont Have An Account".tr + "?".tr),
                              InkWell(
                                onTap: () {
                                  controller.goToSignUp();
                                },
                                child: Text(
                                  "  " + "Register".tr + "  ",
                                  style: const TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          CustomBottunAuth(
                            text: "LogIn".tr,
                            onPressed: () {
                              controller.login();
                            },
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    )),
              )),
        ));
  }
}
