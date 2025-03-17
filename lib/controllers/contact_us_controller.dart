import 'package:bus_tracking_users/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContactUsController extends GetxController {
  String? lang;
  String? lang2;
  String? parentname;
  MyServices myServices = Get.find();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        final parentid = myServices.sharedPreferences.getString("id");

        if (parentid == null || parentid.isEmpty) {
          Get.snackbar("Error", "School ID not found.".tr);
          return;
        }

        final parameters = 'name=${Uri.encodeComponent(nameController.text)}'
            '&phone=${Uri.encodeComponent(phoneController.text)}'
            '&message=${Uri.encodeComponent(messageController.text)}'
            '&parentId=${Uri.encodeComponent(parentid.toString())}';
        print("====================================");
        print("$nameController");
        print("$phoneController");
        print("$messageController");
        print("$parentid");
        print("====================================");

        final response = await http.post(
          Uri.parse(
              'https://apex.oracle.com/pls/apex/mohammad99/TrackingApp/SendMessageForSchool'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: parameters,
        );

        if (response.statusCode == 200) {
          Get.snackbar("Success", "Submission successful!".tr);
          clearForm();
          print("$response============================");
        } else {
          Get.snackbar("Error", "Failed to submit. Please try again.".tr);
        }
      } catch (e) {
        Get.snackbar("Error", "An error occurred: $e".tr);
      }
    }
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    messageController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    parentname = myServices.sharedPreferences.getString("name_en");

    lang = myServices.sharedPreferences.getString("lang");
    lang2 = myServices.sharedPreferences.getString("lang2");

    super.onInit();
  }
}
