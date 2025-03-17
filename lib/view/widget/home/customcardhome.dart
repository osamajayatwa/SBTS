// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:bus_tracking_users/core/constant/color.dart';

class CustomCardHome extends StatelessWidget {
  final String title;
  final String body;

  const CustomCardHome({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.primaryColor.withOpacity(0.8),
              AppColor.primaryColor.withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        height: heightSize * 0.229,
        padding: EdgeInsets.symmetric(
            horizontal: widthSize * 0.05, vertical: heightSize * 0.03),
        child: Row(
          children: [
            Icon(
              Icons.school,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(width: widthSize * 0.04),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: heightSize * 0.001),
                Text(
                  body,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
