// ignore_for_file: unused_field
import 'dart:async';
import 'dart:convert';
import 'package:bus_tracking_users/core/class/statusrequest.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/functions/handilingdata.dart';
import 'package:bus_tracking_users/core/localization/changelocal.dart';
import 'package:bus_tracking_users/core/services/services.dart';
import 'package:bus_tracking_users/data/data_source/remote/auth/logindata.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  LocaleController localeController = Get.find();
  LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find();
  StreamSubscription? _tokenRefreshSub;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController password;

  bool isshowpassword = true;
  List data = [];

  StatusRequest statusRequest = StatusRequest.none;
  String? fcmToken;
  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      fcmToken = await FirebaseMessaging.instance.getToken();
      try {
        var response = await loginData.saveFcmTokenAndLogin(
            username.text, password.text, fcmToken!);
        statusRequest = handilingData(response);
        print("===================================================");

        print("Controller username: $username");
        print("Controller password: $password");
        print("Controller fcmToken: $fcmToken");
        print("Controller Response: $response");

        print("===================================================");
        if (statusRequest == StatusRequest.success &&
            response['status'] == 'Successfull') {
          final parentId = response['parent_id']?.toString() ?? "";
          final schoolId = response['school']?.toString() ?? "";
          final nameEn = response['EnglishName']?.toString() ?? "";
          final phone = response['phone']?.toString() ?? "";
          String namear = response['ArabicName']?.toString() ?? "";
          namear = utf8.decode(namear.runes.toList());
          final nationalNumber = response['National_no']?.toString() ?? "";
          final address = response['address']?.toString() ?? "";
          myServices.sharedPreferences
            ..setString("name", username.text)
            ..setString("id", parentId)
            ..setString("idschool", schoolId)
            ..setString("name_en", nameEn)
            ..setString("name_ar", namear)
            ..setString("phone", phone)
            ..setString("nationalNumber", nationalNumber)
            ..setString("address", address)
            ..setString("step", "2");

          final userid = myServices.sharedPreferences.getString("id")!;
          FirebaseMessaging.instance.subscribeToTopic("users");
          FirebaseMessaging.instance.subscribeToTopic("users$userid");
          Get.offNamed(AppRoute.homepage);
        } else {
          showErrorDialog();
        }
      } catch (e, stackTrace) {
        print("Login error: $e");
        print(stackTrace);
        showErrorDialog();
      }

      update();
    }
  }

  void showErrorDialog() {
    Get.defaultDialog(
      title: "Warning",
      middleText: "Email or Password not correct",
    );
    statusRequest = StatusRequest.failure;
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }

  goToPageHome() {
    Get.offAllNamed(AppRoute.homepage);
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((value) {});
    username = TextEditingController();
    password = TextEditingController();
    _tokenRefreshSub =
        FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      if (myServices.sharedPreferences.containsKey("id")) {
        login();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}
