import 'package:bus_tracking_users/core/constant/imageassests.dart';
import 'package:flutter/material.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageAssest.loginLogo,
      height: 170,
    );
  }
}
