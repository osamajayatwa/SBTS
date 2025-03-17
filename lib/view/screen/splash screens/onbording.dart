import 'package:flutter/material.dart';
import 'package:bus_tracking_users/controllers/onbording_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/view/widget/OnBording/Customdotonbording.dart';
import 'package:bus_tracking_users/view/widget/OnBording/custombutton.dart';
import 'package:bus_tracking_users/view/widget/OnBording/customslider.dart';
import 'package:get/get.dart';

class OnBording extends StatelessWidget {
  const OnBording({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBordingControllerImp());
    return const Scaffold(
        backgroundColor: AppColor.backgroundcolor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(flex: 4, child: CustomSliderOnBording()),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CustomDotOnBording(),
                      Spacer(
                        flex: 2,
                      ),
                      CustombuttonOnBording(),
                    ],
                  ))
            ],
          ),
        ));
  }
}
