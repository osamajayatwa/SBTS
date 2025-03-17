import 'package:bus_tracking_users/controllers/home/home_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/functions/translatefatabase.dart';
import 'package:bus_tracking_users/view/screen/Drawer/drawer.dart';
import 'package:bus_tracking_users/view/widget/profile/ChildrenSection.dart';
import 'package:bus_tracking_users/view/widget/profile/SecuritySection.dart';
import 'package:bus_tracking_users/view/widget/profile/UserInfoSection.dart';
import 'package:bus_tracking_users/view/widget/profile/profileappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());

    return GetBuilder<HomeControllerImp>(
      builder: (controller) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: ProfileAppBar(),
        ),
        body: CustomScrollView(
          slivers: [
            _buildProfileHeader(controller),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 24),
                UserInfoSection(controller: controller),
                const SizedBox(height: 16),
                ChildrenSection(controller: controller),
                const SizedBox(height: 24),
                SecuritySection(),
                const SizedBox(height: 32),
              ]),
            ),
          ],
        ),
        endDrawer: const Drawer(child: CustomDrawer()),
      ),
    );
  }

  Widget _buildProfileHeader(HomeControllerImp controller) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.seconedcolor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 60, color: AppColor.primaryColor),
            ),
            const SizedBox(height: 16),
            Text(
              translateDatabase(
                      controller.parentnamear, controller.parentname) ??
                  "User Name",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
