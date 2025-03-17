import 'package:flutter/material.dart';
import 'package:bus_tracking_users/core/constant/color.dart';

class CustomContactAppBar extends StatelessWidget {
  final String title;
  final Widget icon;

  const CustomContactAppBar(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.primaryColor.withOpacity(0.8),
              AppColor.primaryColor,
            ],
          ),
        ),
      ),
      title: Row(
        children: [
          icon, // Custom icon for communication
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Roboto', // Custom font
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ), // Menu icon
          onPressed: () {
            Scaffold.of(context).openEndDrawer(); // Open the end drawer
          },
        ),
      ],
    );
  }
}
