import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/view/screen/Drawer/drawer.dart';
import 'package:bus_tracking_users/view/widget/customappbarcontactus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightSize * 0.1),
        child: CustomContactAppBar(
          title: "About Us".tr,
          icon: Icon(Iconsax.info_circle, color: Colors.white, size: 26),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryColor, Colors.blueAccent.shade200],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widthSize * 0.05, vertical: heightSize * 0.12),
            child: ListView(
              children: [
                _buildHeader(),
                SizedBox(height: heightSize * 0.03),
                _buildFeatureCard(
                  icon: Iconsax.security_safe,
                  title: "Enhanced Safety".tr,
                  description:
                      "Real-time tracking ensures your child’s safe journey to and from school."
                          .tr,
                  color: Colors.orangeAccent,
                ),
                _buildFeatureCard(
                  icon: Iconsax.notification,
                  title: "Instant Notifications".tr,
                  description:
                      "Stay updated with real-time alerts on bus arrival and departure times."
                          .tr,
                  color: Colors.greenAccent,
                ),
                _buildFeatureCard(
                  icon: Iconsax.clock,
                  title: "Peace of Mind".tr,
                  description:
                      "Enjoy peace of mind knowing where your child is throughout their school commute."
                          .tr,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: CustomDrawer(),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Iconsax.scroll, size: 60, color: Colors.white),
        SizedBox(height: 12),
        Text(
          "Welcome to School Bus Tracking System App!".tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Your child's safety is our priority. With real-time tracking, notifications, and enhanced security, we provide a reliable school bus monitoring experience."
              .tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
