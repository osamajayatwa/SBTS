import 'package:bus_tracking_users/view/widget/home/customappbar.dart';
import 'package:bus_tracking_users/core/functions/translatefatabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_tracking_users/controllers/home/home_controller.dart';
import 'package:bus_tracking_users/core/class/handilingdataview.dart';
import 'package:bus_tracking_users/view/screen/Drawer/drawer.dart';
import 'package:bus_tracking_users/view/widget/home/customcardhome.dart';
import 'package:bus_tracking_users/view/widget/home/customtitlehome.dart';
import 'package:bus_tracking_users/view/widget/home/listichildshome.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<HomeControllerImp>(HomeControllerImp());
    final heightSize = MediaQuery.of(context).size.height;

    return GetBuilder<HomeControllerImp>(
      builder: (controller) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(heightSize * 0.11),
          child: const CustmeAppBar(),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getdata();
            controller.update();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Container(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: HandilingDataView(
                    statusrequest: controller.statusRequest,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: heightSize * 0.02),
                        _buildWelcomeCard(controller, heightSize),
                        _buildStudentsSection(heightSize),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        endDrawer: const Drawer(child: CustomDrawer()),
      ),
    );
  }

  Widget _buildWelcomeCard(HomeControllerImp controller, double heightSize) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomCardHome(
        title: "Welcome to SBTS".tr,
        body:
            translateDatabase(controller.parentnamear!, controller.parentname),
      ),
    );
  }

  Widget _buildStudentsSection(double heightSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: CustomTitleHome(title: "My Children".tr),
        ),
        SizedBox(height: heightSize * 0.02),
        const ListChildsHome(),
        SizedBox(height: heightSize * 0.05),
      ],
    );
  }
}
