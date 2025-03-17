import 'package:auto_size_text/auto_size_text.dart';
import 'package:bus_tracking_users/controllers/home/home_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/constant/imageassests.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/functions/translatefatabase.dart';
import 'package:bus_tracking_users/core/localization/changelocal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp homeController = Get.put(HomeControllerImp());
    final LocaleController localeController = Get.find<LocaleController>();

    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(
          "settings".tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: widthSize * 0.05),
        children: [
          SizedBox(height: heightSize * 0.02),
          Container(
            padding: EdgeInsets.all(widthSize * 0.04),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColor.backgroundcolor,
                  backgroundImage: const AssetImage(ImageAssest.avatar),
                ),
                SizedBox(width: widthSize * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      translateDatabase(homeController.parentnamear,
                              homeController.parentname) ??
                          "Guest".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      minFontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: heightSize * 0.01),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: heightSize * 0.03),
          Text(
            "Account Settings".tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: heightSize * 0.01),
          _buildSettingsItem(
            title: "View Profile".tr,
            icon: Icons.person_outline,
            onTap: () => Get.toNamed(AppRoute.profile),
          ),
          SizedBox(height: heightSize * 0.03),
          Text(
            "App Preferences".tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: heightSize * 0.01),
          _buildSettingsItem(
            title: "Change Language".tr,
            icon: Icons.language_outlined,
            onTap: () => _showLanguageDialog(localeController),
          ),
          SizedBox(height: heightSize * 0.03),
          Text(
            "Help & Support".tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: heightSize * 0.01),
          _buildSettingsItem(
            title: "Terms Of Services".tr,
            icon: Icons.policy_outlined,
            onTap: () => Get.toNamed(AppRoute.terms),
          ),
          _buildSettingsItem(
            title: "About Us".tr,
            icon: Icons.info_outline,
            onTap: () => Get.toNamed(AppRoute.aboutus),
          ),
          SizedBox(height: heightSize * 0.03),
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: widthSize * 0.1,
                  vertical: heightSize * 0.02,
                ),
              ),
              onPressed: () => homeController.logout(),
              icon: Icon(Icons.logout_outlined, color: Colors.white),
              label: Text(
                "Logout".tr,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: heightSize * 0.02),
          Center(
            child: Text(
              "App Version".tr + " 1.0.0",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: heightSize * 0.03),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(icon, color: AppColor.primaryColor, size: 26),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 20),
    );
  }

  void _showLanguageDialog(LocaleController localeController) {
    Get.dialog(
      AlertDialog(
        title: Text("Select Language".tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("English".tr),
              onTap: () {
                localeController.changeLang("en");
                Get.back();
              },
            ),
            ListTile(
              title: Text("Arabic".tr),
              onTap: () {
                localeController.changeLang("ar");
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
