import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:bus_tracking_users/controllers/home/home_screen_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';

class CustomBottomAppBarHome extends StatelessWidget {
  const CustomBottomAppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 3,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          child: SalomonBottomBar(
            currentIndex: controller.currentpage,
            onTap: (index) => controller.changePage(index),
            items: controller.bottomappbar.map((item) {
              return SalomonBottomBarItem(
                icon: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [
                        AppColor.primaryColor.withOpacity(0.6),
                        AppColor.primaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Icon(item['icon'], size: 24),
                ),
                title: Text(
                  item['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                selectedColor: AppColor.primaryColor,
                unselectedColor: Colors.black,
              );
            }).toList(),
            curve: Curves.decelerate,
            backgroundColor: AppColor.backgroundcolor,
          ),
        ),
      ),
    );
  }
}
