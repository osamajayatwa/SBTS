import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custom extends StatelessWidget {
  final String textbottun;
  final void Function()? onPressed;

  const Custom({super.key, required this.textbottun, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: Colors.black,
          fixedSize: const Size(120, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
        ),
        onPressed: onPressed,
        child: Text(
          textbottun,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
