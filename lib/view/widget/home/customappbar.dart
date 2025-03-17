// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bus_tracking_users/controllers/home/home_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/constant/imageassests.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/functions/translatefatabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustmeAppBar extends StatelessWidget {
  const CustmeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    HomeControllerImp controller = Get.put(HomeControllerImp());

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: height * 0.12,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
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
              color: AppColor.primaryColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 3),
            )
          ],
        ),
      ),
      title: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Get.toNamed(AppRoute.homepage),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColor.backgroundcolor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    ImageAssest.logo,
                    width: widthSize * 0.11,
                    height: widthSize * 0.11,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: widthSize * 0.02),
              AutoSizeText(
                maxLines: 2,
                minFontSize: 8,
                overflow: TextOverflow.ellipsis,
                translateDatabase(
                        controller.parentnamear, controller.parentname) ??
                    "User Name",
                style: TextStyle(
                  fontSize: 15,
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
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 15, left: 15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: IconButton(
            icon: Icon(Iconsax.menu_1, size: 28),
            color: AppColor.backgroundcolor,
            style: IconButton.styleFrom(
              backgroundColor: AppColor.primaryColor.withOpacity(0.2),
              padding: EdgeInsets.all(12),
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
