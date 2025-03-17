// ignore_for_file: deprecated_member_use

import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/localization/changelocal.dart';
import 'package:bus_tracking_users/view/widget/custombuttonlang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class Language extends GetView<LocaleController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.seconedcolor,
              AppColor.primaryColor,
              AppColor.seconedcolor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: GlassContainer(
            height: 240,
            width: 300,
            blur: 4,
            color: Colors.white.withOpacity(0.3),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.blueAccent.withOpacity(0.4),
              ],
            ),
            border: Border.fromBorderSide(BorderSide.none),
            shadowStrength: 5,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(25),
            shadowColor: Colors.white.withOpacity(0.24),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Choose Language".tr,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Custom(
                    textbottun: "Arabic",
                    onPressed: () {
                      controller.changeLang("ar");
                      Get.toNamed(AppRoute.onBoarding);
                    },
                  ),
                  const SizedBox(height: 15),
                  Custom(
                    textbottun: "English",
                    onPressed: () {
                      controller.changeLang("en");
                      Get.toNamed(AppRoute.onBoarding);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
