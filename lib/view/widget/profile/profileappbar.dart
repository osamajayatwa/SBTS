import 'package:flutter/material.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:get/get.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColor.primaryColor,
      title: Text(
        "Profile".tr,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        Builder(
          builder: (BuildContext scaffoldContext) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => Scaffold.of(scaffoldContext).openEndDrawer(),
          ),
        ),
      ],
    );
  }
}
