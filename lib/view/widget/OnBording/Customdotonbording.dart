import 'package:bus_tracking_users/data/data_source/static/static.dart';
import 'package:flutter/material.dart';
import 'package:bus_tracking_users/controllers/onbording_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:get/get.dart';

class CustomDotOnBording extends StatelessWidget {
  const CustomDotOnBording({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBordingControllerImp>(
        builder: (controller) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    onBoardingList.length,
                    (index) => AnimatedContainer(
                          margin: const EdgeInsets.only(right: 5),
                          duration: const Duration(milliseconds: 900),
                          width: controller.currentpage == index ? 20 : 5,
                          height: 6,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                        ))
              ],
            ));
  }
}
