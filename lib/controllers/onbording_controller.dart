import 'package:bus_tracking_users/data/data_source/static/static.dart';
import 'package:flutter/material.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/services/services.dart';
import 'package:get/get.dart';

abstract class OnBordingController extends GetxController {
  next();
  onPageChanged(int index);
}

class OnBordingControllerImp extends OnBordingController {
  late PageController pagecontroller;
  int currentpage = 0;
  MyServices myServices = Get.find();
  @override
  next() {
    currentpage++;
    if (currentpage > onBoardingList.length - 1) {
      myServices.sharedPreferences.setString("step", "1");
      Get.offAllNamed(AppRoute.login);
    } else {
      pagecontroller.animateToPage(currentpage,
          duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
    }
  }

  @override
  onPageChanged(int index) {
    currentpage = index;
    update();
  }

  @override
  void onInit() {
    pagecontroller = PageController();
    super.onInit();
  }
}
