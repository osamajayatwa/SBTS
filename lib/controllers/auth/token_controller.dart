import 'package:bus_tracking_users/core/services/services.dart';
import 'package:bus_tracking_users/data/data_source/remote/auth/token_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthController extends GetxController {
  TokenData tokenData = TokenData(Get.find());
  final storage = FlutterSecureStorage();
  var token = "".obs;
  String? parent;
  String table = "1";

  MyServices myServices = Get.find();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    parent = myServices.sharedPreferences.getString("id");

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print("FCM Token Refreshed: $newToken");
      if (myServices.sharedPreferences.containsKey("id")) {
        validateToken(newToken);
      }
    });
  }

  Future<void> checkLoginStatus() async {
    String? savedToken = await storage.read(key: "fcmToken");
    parent = myServices.sharedPreferences.getString("id");

    if (savedToken != null && parent != null) {
      bool isValid = await validateToken(savedToken);

      if (isValid) {
        token.value = savedToken;
      } else {
        await storage.delete(key: "fcmToken");
      }
    }
  }

  Future<bool> validateToken(String token) async {
    if (parent == null) {
      print("Parent ID is null. Cannot validate token.");
      return false;
    }

    try {
      parent = myServices.sharedPreferences.getString("id");

      var response = await tokenData.postdata(table, parent!, token);

      if (response["status"] == "success") {
        print("Token is valid.");
        return true;
      } else {
        print("Token validation failed: ${response['status']}");
      }
    } catch (e) {
      print("Token validation error: $e");
    }

    return false;
  }

  Future<void> clearToken() async {
    await storage.delete(key: "fcmToken");
    token.value = "";
  }
}
