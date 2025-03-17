import 'package:bus_tracking_users/core/constant/app.dart';
import 'package:bus_tracking_users/core/functions/fcmconfig.dart';
import 'package:bus_tracking_users/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();
  ThemeData appTheme = themeEnglish;
  String languageCode = 'en';
  void changeLang(String langCode) {
    Locale locale = Locale(langCode);
    myServices.sharedPreferences.setString("lang", langCode);
    appTheme = langCode == "ar" ? themeArabic : themeEnglish;
    Get.updateLocale(locale);
    Get.changeTheme(appTheme);
    update();
  }

  Future<void> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Alert".tr, "الرجاء تشغيل خدمة تحديد الموقع.");
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Alert".tr, "الرجاء إعطاء صلاحية الموقع للتطبيق.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.defaultDialog(
          title: "Alert".tr,
          middleText:
              "تم رفض صلاحية الموقع بشكل دائم. الرجاء تفعيل الصلاحيات من الإعدادات.",
          textCancel: "إغلاق",
          textConfirm: "فتح الإعدادات",
          onConfirm: () async {
            await openAppSettings();
            Get.back();
          },
        );
        return;
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء طلب صلاحية الموقع: $e");
    }
  }

  void _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    languageCode = prefs.getString('lang') ?? 'en';
    update();
  }

  void changeLanguage(String langCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', langCode);

    languageCode = langCode;
    update();

    Locale locale = Locale(langCode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    requestLocationPermission();
    requestPermissionNotification();
    checkNotificationOnLaunch();
    setupFirebaseMessaging();
    update();

    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang != null) {
      language = Locale(sharedPrefLang);
      appTheme = sharedPrefLang == "ar" ? themeArabic : themeEnglish;
      update();
    } else {
      Locale deviceLocale = Get.deviceLocale ?? const Locale('en');
      language = Locale(deviceLocale.languageCode);
      appTheme = themeEnglish;
      _loadLanguagePreference();

      update();
      super.onInit();
    }

    Get.changeTheme(appTheme);
    Get.updateLocale(language!);
    update();
  }
}
