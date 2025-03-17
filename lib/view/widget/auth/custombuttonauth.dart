import 'package:flutter/material.dart';
import 'package:bus_tracking_users/core/constant/color.dart';

class CustomBottunAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  const CustomBottunAuth({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(30),
        // gradient: LinearGradient(
        //   colors: [AppColor.primaryColor, Colors.blueAccent],
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        // ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 5,
        //     spreadRadius: 2,
        //   ),
        // ],
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 15),
        onPressed: onPressed,
        textColor: Colors.white,
        elevation: 0,
        highlightElevation: 10,
        disabledColor: Colors.grey,
        child: isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),
      ),
    );
  }
}
