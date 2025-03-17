import 'package:bus_tracking_users/core/class/statusrequest.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/functions/handilingdata.dart';
import 'package:bus_tracking_users/core/services/services.dart';
import 'package:bus_tracking_users/data/data_source/remote/stdrounds.dart';
import 'package:bus_tracking_users/data/model/rounds_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RidesControllerImp extends GetxController {
  late StatusRequest statusRequest = StatusRequest.none;
  List<Items> rides = [];
  MyServices myServices = Get.find();
  StdroundsData stdroundsData = StdroundsData(Get.find());
  var arguments = Get.arguments;
  String? idstd;
  String? stdId;
  String? stdname;
  String? time;
  String? lang;
  String? parentname;
  Future<void> fetchRidesData(String stdId) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      var response = await stdroundsData.getData(stdId);
      print("Controller Response: $response");

      statusRequest = handilingData(response);
      print("===========$response");
      if (statusRequest == StatusRequest.success) {
        if (response != null && response['items'] != null) {
          List<dynamic> jsonData = response['items'];
          rides
              .assignAll(jsonData.map((item) => Items.fromJson(item)).toList());
        } else {
          print("No 'items' key in response or response is null");
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  showAlert(String title, String content) {
    Get.dialog(
      AlertDialog(
        shadowColor: AppColor.primaryColor,
        surfaceTintColor: AppColor.primaryColor,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColor.primaryColor, fontSize: 25),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: AppColor.grey2),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "OK",
              style: TextStyle(color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  gototrackingpage(String roundid) async {
    try {
      String formattedTime =
          DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
      print("Formatted Time: $formattedTime");

      var data = await stdroundsData.getlocation(roundid, formattedTime);

      print("Location data: $data");
      Get.toNamed(AppRoute.ridestracking, arguments: roundid);
    } catch (e) {
      print("Exception occurred while fetching data: $e");
    }
    update();
  }

  Future<void> intialData() async {
    parentname = myServices.sharedPreferences.getString("name_en");
    lang = myServices.sharedPreferences.getString("lang");

    var arguments = Get.arguments;
    if (arguments != null && arguments['stdId'] != null) {
      String stdId = arguments['stdId'];

      statusRequest = StatusRequest.loading;
      await fetchRidesData(stdId);
    } else {
      print("Error: stdId is missing or arguments are null");
    }
    update();
  }

  @override
  void onInit() {
    var arguments = Get.arguments;
    print("Arguments: $arguments");
    intialData();
    update();
    super.onInit();
  }

  @override
  void onClose() {
    stdId = null;
    stdname = null;

    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    intialData();
    update();
  }
}
