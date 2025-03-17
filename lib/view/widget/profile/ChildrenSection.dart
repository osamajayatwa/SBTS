import 'package:bus_tracking_users/controllers/home/home_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/view/widget/profile/ChildListItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChildrenSection extends StatelessWidget {
  final HomeControllerImp controller;

  const ChildrenSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.child_care, color: AppColor.primaryColor),
                  const SizedBox(width: 12),
                  Text(
                    'My Children'.tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (controller.rides.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'No children registered'.tr,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ...controller.rides
                  .map((student) => ChildListItem(student: student)),
            ],
          ),
        ),
      ),
    );
  }
}
