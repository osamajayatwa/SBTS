// ignore_for_file: deprecated_member_use

import 'package:bus_tracking_users/controllers/reides_controller.dart';
import 'package:bus_tracking_users/core/class/handilingdataview.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/constant/imageassests.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/functions/translatefatabase.dart';
import 'package:bus_tracking_users/view/screen/Drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ListRides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;

    RidesControllerImp controller = Get.put(RidesControllerImp());

    var arguments = Get.arguments;
    String stdname = arguments != null && arguments['stdname'] != null
        ? arguments['stdname']
        : 'No Name';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightSize * 0.11),
        child: AppBar(
          backgroundColor: AppColor.primaryColor,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              SizedBox(width: widthSize * 0.01),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoute.homepage);
                  Get.delete<RidesControllerImp>();
                },
                child: Image.asset(
                  width: widthSize * 0.14,
                  height: heightSize * 0.06,
                  ImageAssest.logo,
                ),
              ),
              SizedBox(width: widthSize * 0.05),
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                controller.parentname!,
              ),
            ],
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    color: Colors.black,
                    icon: Icon(
                      Icons.menu,
                      size: 35,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: GetBuilder<RidesControllerImp>(
        builder: (controller) {
          return HandilingDataView(
            statusrequest: controller.statusRequest,
            widget: Container(
              color: Colors.grey[150],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Today Rounds".tr,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          Text(
                            "for".tr + "$stdname",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.rides.isEmpty)
                    Center(
                      child: Text(
                        "No Rounds For Today".tr,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: controller.rides.length,
                        itemBuilder: (context, index) {
                          final ride = controller.rides[index];
                          final isActive = ride.isActive;

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      if (isActive == 1) {
                                        controller
                                            .gototrackingpage(ride.roundId!);
                                      } else {
                                        controller.showAlert("Alert".tr,
                                            "Round Is Not Active".tr);
                                      }
                                    },
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: isActive == 1
                                              ? Colors.green.withOpacity(0.2)
                                              : AppColor.primaryColor
                                                  .withOpacity(0.2),
                                        ),
                                        height: heightSize * 0.13,
                                        width: widthSize * 0.9,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              isActive == 1
                                                  ? Icons.check_circle_outline
                                                  : Icons.cancel_outlined,
                                              color: isActive == 1
                                                  ? Colors.green
                                                  : Colors.red,
                                              size: 30,
                                            ),
                                            SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  translateDatabase(
                                                      ride.roundNameAr,
                                                      ride.roundNameEn),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: isActive == 1
                                                        ? Colors.green
                                                        : AppColor.primaryColor,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      ride.startDate.toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: isActive == 1
                                                            ? Colors.green
                                                            : AppColor
                                                                .primaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: isActive == 1
                                                  ? Colors.green
                                                  : AppColor.primaryColor,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      endDrawer: Drawer(
        child: CustomDrawer(),
      ),
    );
  }
}
