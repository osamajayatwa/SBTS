import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NotificationAppBar extends StatelessWidget {
  final String title;
  final Widget icon;
  const NotificationAppBar(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: screenHeight * 0.09,
      automaticallyImplyLeading: false,
      flexibleSpace: Column(
        children: [
          Container(
            height: screenHeight * 0.13,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.backgroundcolor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: icon,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenHeight * 0.035,
                  fontWeight: FontWeight.w800,
                  color: AppColor.backgroundcolor,
                  letterSpacing: 0.8,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10, left: 10),
          child: IconButton(
            icon: Icon(Iconsax.menu_1, size: screenHeight * 0.035),
            color: AppColor.backgroundcolor,
            style: IconButton.styleFrom(
              backgroundColor: AppColor.primaryColor.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
      ],
    );
  }
}
