// ignore_for_file: unused_local_variable, unused_element

import 'package:bus_tracking_users/controllers/notification_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/view/screen/Drawer/drawer.dart';
import 'package:bus_tracking_users/view/widget/nitification_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Get.put(NotificationController());
    return GetBuilder<NotificationController>(
      builder: (controller) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.11),
          child: NotificationAppBar(
            icon: Icon(Iconsax.notification),
            title: "Notifications".tr,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.update();
          },
          // Body Content
          // Expanded(
          //   child:
          //       //  controller.data.isNotEmpty
          //       //     ? _buildEmptyState(height)
          //       //     :
          //       ListView.separated(
          //     padding: const EdgeInsets.all(20),
          //     itemCount: controller.data.length,
          //     separatorBuilder: (context, index) =>
          //         const SizedBox(height: 15),
          //     itemBuilder: (context, index) => _buildNotificationCard(
          //       context,
          //       title: "controller.data[index]['notification_title']",
          //       body: "controller.data[index]['notification_body']",
          //       time: "controller.data[index]['notification_datetime']",
          //       isUnread: true, // Add your read/unread logic here
          //     ),
          //   ),
          // ),
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                _buildNotificationCard(context,
                    title: "alert",
                    body:
                        "how to know the know for knowing the know is knowing the know",
                    time: "time"),
                SizedBox(
                  height: height * 0.02,
                ),
                _buildNotificationCard(context,
                    title: "alert",
                    body:
                        "how to know the know for knowing the know is knowing the know",
                    time: "time"),
                SizedBox(
                  height: height * 0.01,
                ),
                _buildNotificationCard(context,
                    title: "alert",
                    body:
                        "how to know the know for knowing the know is knowing the know",
                    time: "time"),
                SizedBox(
                  height: height * 0.02,
                ),
                _buildNotificationCard(context,
                    title: "alert",
                    body:
                        "how to know the know for knowing the know is knowing the know",
                    time: "time"),
                SizedBox(
                  height: height * 0.02,
                ),
                _buildNotificationCard(context,
                    title: "alert",
                    body:
                        "how to know the know for knowing the know is knowing the know",
                    time: "time"),
                SizedBox(
                  height: height * 0.02,
                ),
                _buildNotificationCard(context,
                    title: "alert",
                    body:
                        "how to know the know for knowing the know is knowing the know",
                    time: "time"),
                SizedBox(
                  height: height * 0.02,
                ),
                _buildNotificationCard(context,
                    title: "alert",
                    body:
                        "how to know the know for knowing the know is knowing the know",
                    time: "time"),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        ),
        endDrawer: const Drawer(child: CustomDrawer()),
      ),
    );
  }

  Widget _buildEmptyState(double height) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.notification_bing,
              size: 80, color: AppColor.primaryColor.withOpacity(0.3)),
          const SizedBox(height: 20),
          Text(
            "All Caught Up!".tr,
            style: TextStyle(
              fontSize: 24,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "You don't have any notifications right now".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColor.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context,
      {required String title,
      required String body,
      required String time,
      bool isUnread = false}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.backgroundcolor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (isUnread)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 12,
                decoration: BoxDecoration(
                  color: AppColor.seconedcolor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.notification, color: AppColor.primaryColor),
            ),
            title: Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                  fontSize: 16,
                )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(body,
                    style: TextStyle(
                      color: AppColor.grey,
                      fontSize: 14,
                    )),
                const SizedBox(height: 10),
                // Text(
                //   Jiffy.parse(time, pattern: "yyyy-MM-dd").fromNow(),
                //   style: TextStyle(
                //     color: AppColor.grey.withOpacity(0.7),
                //     fontSize: 12,
                //     fontStyle: FontStyle.italic,
                //   ),
                // ),
              ],
            ),
            // trailing: Icon(Iconsax.arrow_right_3, color: AppColor.primaryColor),
            // onTap: () {
            //   // Handle notification tap
            // },
          ),
        ],
      ),
    );
  }
}
