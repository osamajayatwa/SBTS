import 'package:bus_tracking_users/controllers/home/home_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/view/widget/profile/InfoTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoSection extends StatelessWidget {
  final HomeControllerImp controller;

  const UserInfoSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          InfoTile(
            icon: Icons.person_outline,
            title: 'Username'.tr,
            value: controller.username ?? "N/A",
            color: AppColor.primaryColor,
          ),
          const SizedBox(height: 12),
          InfoTile(
            icon: Icons.phone_android_outlined,
            title: 'Phone'.tr,
            value: controller.phone ?? "No Phone Added",
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          InfoTile(
            icon: Icons.numbers,
            title: 'National Number'.tr,
            value: controller.nationalNumber ?? "No Address Added",
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          InfoTile(
            icon: Icons.home_outlined,
            title: 'Home Address'.tr,
            value: controller.address ?? "No Address Added",
            color: Colors.purple,
            onTap: () => Get.toNamed(AppRoute.homeaddress),
          ),
        ],
      ),
    );
  }
}
