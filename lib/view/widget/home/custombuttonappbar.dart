import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomButtonAppBar extends StatelessWidget {
  final void Function()? onPressed;
  final String textbutton;
  final IconData icondata;
  final bool active;

  const CustomButtonAppBar({
    super.key,
    required this.textbutton,
    required this.icondata,
    required this.onPressed,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      minWidth: 1,
      elevation: 18.0,
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icondata,
            color: active ? AppColor.primaryColor : AppColor.grey2,
            size: 25,
          ),
          Text(
            textbutton,
            style: TextStyle(
              color: active ? AppColor.primaryColor : AppColor.grey2,
              fontSize: 8,
            ),
          )
        ],
      ),
    );
  }
}
