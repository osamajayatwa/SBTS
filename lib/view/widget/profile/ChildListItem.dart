import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/functions/translatefatabase.dart';
import 'package:bus_tracking_users/data/model/student_for_parent.dart';
import 'package:flutter/material.dart';

class ChildListItem extends StatelessWidget {
  final Items student;

  const ChildListItem({required this.student});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline,
                size: 20, color: AppColor.primaryColor),
          ),
          const SizedBox(width: 12),
          Text(
            translateDatabase(student.nameAr, student.nameEn),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
