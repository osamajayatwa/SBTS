import 'package:bus_tracking_users/controllers/home/home_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/constant/imageassests.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/functions/translatefatabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    HomeControllerImp controller = Get.put(HomeControllerImp());
    bool? isarab = Get.locale?.languageCode == "ar";
    return Drawer(
      width: widthSize * 0.75,
      elevation: 20,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primaryColor.withOpacity(0.1), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: heightSize * 0.25,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.seconedcolor],
                  begin: Get.locale?.languageCode == 'ar'
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  end: Get.locale?.languageCode == 'ar'
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: isarab ? Radius.zero : Radius.circular(65),
                  bottomLeft: isarab ? Radius.circular(65) : Radius.zero,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -widthSize * 0.1,
                    top: -heightSize * 0.05,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Iconsax.profile_2user,
                          size: heightSize * 0.2, color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(widthSize * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                ImageAssest.avatar,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: heightSize * 0.01),
                          Text(
                            translateDatabase(
                                controller.parentnamear, controller.parentname),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(2, 2),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: heightSize * 0.005),
                          Text(
                            controller.username!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widthSize * 0.03, vertical: heightSize * 0.04),
              child: Column(
                children: [
                  _buildDrawerItem(
                    title: "Profile".tr,
                    icon: Iconsax.profile_circle,
                    onTap: () => Get.toNamed(AppRoute.profile),
                    color: AppColor.primaryColor,
                  ),
                  SizedBox(height: heightSize * 0.01),
                  _buildDrawerItem(
                    title: "Terms Of Services".tr,
                    icon: Iconsax.document,
                    onTap: () => Get.toNamed(AppRoute.terms),
                    color: AppColor.primaryColor,
                  ),
                  SizedBox(height: heightSize * 0.01),
                  _buildDrawerItem(
                    title: "About Us".tr,
                    icon: Iconsax.info_circle,
                    onTap: () => Get.toNamed(AppRoute.aboutus),
                    color: AppColor.primaryColor,
                  ),
                  SizedBox(height: heightSize * 0.03),
                  Divider(color: AppColor.primaryColor, thickness: 2),
                  SizedBox(height: heightSize * 0.02),
                  _buildDrawerItem(
                    title: "Logout".tr,
                    icon: Iconsax.logout,
                    onTap: () => controller.logout(),
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(widthSize * 0.05),
              child: Column(
                children: [
                  Divider(color: Colors.grey[300], thickness: 1),
                  SizedBox(height: heightSize * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.code, size: 14, color: Colors.grey),
                      SizedBox(width: widthSize * 0.02),
                      Text(
                        "App Version".tr + " 1.0.0",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        splashColor: color.withOpacity(0.1),
        highlightColor: color.withOpacity(0.05),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color.withOpacity(0.09),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
              const Spacer(),
              Icon(Iconsax.arrow_right_3, size: 18, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
