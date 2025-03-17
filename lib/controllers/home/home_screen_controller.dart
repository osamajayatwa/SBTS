import 'package:bus_tracking_users/view/screen/Drawer/contact_us.dart';
import 'package:bus_tracking_users/view/screen/home/home.dart';
import 'package:bus_tracking_users/view/screen/notification.dart';
import 'package:bus_tracking_users/view/screen/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;
  List<Widget> listPage = [
    const HomePage(),
    const NotificationView(),
    const ContactUs(),
    const SettingsPage(),
  ];

  List<Map<String, dynamic>> get bottomappbar => [
        {"title": "Home".tr, "icon": Icons.home},
        {"title": "Notifications".tr, "icon": Icons.notifications},
        {"title": "Contact Us".tr, "icon": Icons.phone_callback},
        {"title": "settings".tr, "icon": Icons.settings},
      ];
  @override
  changePage(int i) {
    currentpage = i;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    update();
  }
}
