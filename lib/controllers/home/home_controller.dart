import 'package:bus_tracking_users/core/functions/fcmconfig.dart';
import 'package:bus_tracking_users/core/localization/changelocal.dart';
import 'package:bus_tracking_users/data/data_source/remote/childstatus.dart';
import 'package:bus_tracking_users/core/class/statusrequest.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/functions/handilingdata.dart';
import 'package:bus_tracking_users/core/services/services.dart';
import 'package:bus_tracking_users/data/data_source/remote/auth/home_data.dart';
import 'package:bus_tracking_users/data/data_source/remote/stdrounds.dart';
import 'package:bus_tracking_users/data/model/student_for_parent.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  initialData();
  getdata();
  goToItems(String stdId, String stdname);
}

class HomeControllerImp extends HomeController {
  ChildStatus childStatus = ChildStatus(Get.find());
  HomeData homeData = HomeData(Get.find());
  final LocaleController localeController = Get.find<LocaleController>();
  StdroundsData stdroundsData = StdroundsData(Get.find());
  MyServices myServices = Get.find();
  late StatusRequest statusRequest = StatusRequest.none;
  String? username;
  String? id;
  String? lang;
  String? phone;
  Map<String, bool> isNotGoingMap = {};
  String? parentname;
  String? parentnamear;
  String? address;
  String? nationalNumber;

  var rides = <Items>[].obs;

  @override
  initialData() {
    initialModel();
    Locale locale = Locale(lang!);
    if (Get.locale != locale) {
      Get.updateLocale(locale);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      localeController.requestLocationPermission();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestPermissionNotification();
    });
    getstudent(id!);
  }

  initialModel() {
    phone = myServices.sharedPreferences.getString("phone");
    nationalNumber = myServices.sharedPreferences.getString("nationalNumber");
    address = myServices.sharedPreferences.getString("address");
    lang = myServices.sharedPreferences.getString("lang") ?? "en";
    username = myServices.sharedPreferences.getString("name");
    id = myServices.sharedPreferences.getString("id");
    parentname = myServices.sharedPreferences.getString("name_en") ?? '';
    parentnamear = myServices.sharedPreferences.getString("name_ar") ?? '';
  }

  Future<void> getstudent(String id) async {
    if (rides.isNotEmpty) {
      return;
    }
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await homeData.getData(id);
      statusRequest = handilingData(response);

      if (statusRequest == StatusRequest.success && response['items'] != null) {
        List<dynamic> jsonData = response['items'];
        rides.assignAll(jsonData.map((item) => Items.fromJson(item)).toList());
      }
    } catch (e) {
      print("Error fetching data: $e");
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  Future<void> getdata() async {
    await homeData.getData(id!);
    await Future.delayed(const Duration(seconds: 1));
    update();
  }

  void goToItems(String stdId, String stdname) async {
    await Get.toNamed(
      AppRoute.rides,
      arguments: {'stdId': stdId, 'stdname': stdname},
    );
  }

  logout() {
    Get.defaultDialog(
      title: "Are you sure?".tr,
      middleText: "Do you want to logout?".tr,
      onCancel: () => Get.back(),
      onConfirm: () async {
        try {
          final prefs = myServices.sharedPreferences;
          final userid = prefs.getString("id");

          if (userid == null) {
            Get.back();
            return;
          }
          var response = await homeData.deleteFcmToken(userid);
          print("Server response: $response");
          await FirebaseMessaging.instance.unsubscribeFromTopic("users");
          await FirebaseMessaging.instance.unsubscribeFromTopic("users$userid");
          await FirebaseMessaging.instance.deleteToken();
          prefs.remove("name");
          prefs.remove("id");
          prefs.remove("idschool");
          prefs.remove("password");
          prefs.remove("name_en");
          prefs.remove("name_ar");
          prefs.remove("phone");
          prefs.remove("nationalNumber");
          prefs.remove("address");
          prefs.remove("step");
          prefs.remove("phone");
          Get.offAllNamed(AppRoute.login);
        } catch (e) {
          print("Logout failed: $e");
          Get.back();
        }
      },
      textConfirm: "Yes".tr,
      textCancel: "Cancel".tr,
      confirmTextColor: Colors.white,
      cancelTextColor: AppColor.primaryColor,
      buttonColor: AppColor.primaryColor,
    );
  }

  void markAsNotGoing(String studentId) async {
    var response = await childStatus.psotdata(studentId, "0");
    print("=================$response");

    isNotGoingMap[studentId] = true;
    update();
  }

  void resetNotGoingStatus() async {
    isNotGoingMap.clear();
    update();
  }

  void markAsPresent(String studentId) async {
    var response = await childStatus.psotdata(studentId, "1");
    print("=================$response");
    isNotGoingMap[studentId] = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initialData();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
