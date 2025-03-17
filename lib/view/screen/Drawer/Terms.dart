import 'package:bus_tracking_users/view/screen/Drawer/drawer.dart';
import 'package:bus_tracking_users/view/widget/customappbarcontactus.dart';
import 'package:flutter/material.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightSize * 0.12),
        child: CustomContactAppBar(
          title: "Terms Of Services".tr,
          icon: Icon(Iconsax.document_text,
              color: AppColor.backgroundcolor, size: 28),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.primaryColor,
              AppColor.seconedcolor,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: widthSize * 0.03, vertical: heightSize * 0.01),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildSectionHeader(
                icon: Iconsax.book,
                title: "Welcome to School Bus Tracking System App!".tr,
              ),
              _buildContentCard(
                content:
                    "By using this app, you agree to comply with and be bound by the following terms and conditions. Please read them carefully.",
              ),
              SizedBox(
                height: heightSize * 0.05,
              ),
              _buildSection(
                title: "1. Purpose of the App".tr,
                icon: Iconsax.location,
                content:
                    "Our app provides real-time school bus tracking to help parents monitor their child's transportation. Features include:",
                bullets: [
                  "Real-time GPS tracking",
                  "Route optimization",
                  "Instant notifications",
                  "Safety monitoring",
                ],
              ),
              _buildSection(
                title: "2. Data Accuracy".tr,
                icon: Iconsax.gps,
                content:
                    "While we strive for precision, various factors may affect accuracy:",
                bullets: [
                  "Network availability",
                  "GPS signal strength",
                  "Device compatibility",
                  "Environmental conditions",
                ],
              ),
              _buildSection(
                title: "3. User Responsibilities".tr,
                icon: Iconsax.security_user,
                content: "As a user, you agree to:",
                bullets: [
                  "Use the app as a supplementary tool",
                  "Maintain account security",
                  "Update personal information",
                  "Follow school policies",
                ],
              ),
              _buildSection(
                title: "4. Privacy & Security".tr,
                icon: Iconsax.lock,
                content:
                    "We collect only essential data for functionality. Our practices include:",
                bullets: [
                  "End-to-end encryption",
                  "Regular security audits",
                  "Limited data retention",
                  "GDPR compliance",
                ],
              ),
              _buildUpdateFooter(),
              SizedBox(height: heightSize * 0.05),
            ],
          ),
        ),
      ),
      endDrawer: const Drawer(child: CustomDrawer()),
    );
  }

  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Column(
      children: [
        Icon(icon, size: 40, color: AppColor.seconedcolor),
        const SizedBox(height: 15),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _buildContentCard({required String content}) {
    return Card(
      color: AppColor.seconedcolor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: AppColor.primaryColor.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          textAlign: TextAlign.center,
          content.tr,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required String content,
    List<String>? bullets,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 28, color: AppColor.primaryColor),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 38.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content.tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              if (bullets != null) ...[
                const SizedBox(height: 10),
                ...bullets.map((bullet) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ",
                              style: TextStyle(
                                  color: AppColor.primaryColor, fontSize: 16)),
                          Expanded(
                            child: Text(
                              bullet.tr,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
              const SizedBox(height: 25),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateFooter() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Divider(color: Colors.grey[300], thickness: 1.2),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.calendar, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              "Last Updated: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Thank you for choosing our service!".tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppColor.primaryColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
