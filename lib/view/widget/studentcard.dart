import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/constant/imageassests.dart';
import 'package:bus_tracking_users/core/functions/translatefatabase.dart';
import 'package:bus_tracking_users/data/model/student_for_parent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentCard extends StatelessWidget {
  final Items student;
  final bool isNotGoing;
  final VoidCallback? onTap;
  final VoidCallback onMarkAbsent;
  final VoidCallback onMarkPresent;

  const StudentCard({
    Key? key,
    required this.student,
    required this.isNotGoing,
    this.onTap,
    required this.onMarkAbsent,
    required this.onMarkPresent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isNotGoing
                ? [Colors.grey, Colors.grey.shade400]
                : [
                    AppColor.primaryColor.withOpacity(0.8),
                    AppColor.primaryColor.withOpacity(0.2)
                  ],
            begin: Get.locale?.languageCode == 'ar'
                ? Alignment.topRight
                : Alignment.topLeft,
            end: Get.locale?.languageCode == 'ar'
                ? Alignment.bottomCenter
                : Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    color: AppColor.grey3,
                    child: Image.asset(
                      ImageAssest.avatar,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Icon(Icons.person, size: 40, color: AppColor.grey3),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translateDatabase(
                            student.nameAr ?? "", student.nameEn ?? ""),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                          "${translateDatabase(student.schoolNameAr, student.schoolNameEn)}",
                          style: TextStyle(color: AppColor.grey3)),
                      Text(
                          "${translateDatabase(student.branchNameAr, student.branchNameEn)}",
                          style: TextStyle(color: AppColor.grey3)),
                      Text("Education Level".tr + " : " + "${student.eduLevel}",
                          style: TextStyle(color: AppColor.grey3)),
                      Text("Age".tr + " : " + "${student.age}",
                          style: TextStyle(color: AppColor.grey3)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          // Icon(Icons.circle,
                          //     size: 10,
                          //     color: isNotGoing ? Colors.red : Colors.green),
                          // const SizedBox(width: 5),
                          // Text(
                          //   isNotGoing ? "At Home".tr : "In Bus".tr,
                          //   style: TextStyle(color: AppColor.grey3),
                          // ),
                          Spacer(),
                          ElevatedButton(
                            onPressed:
                                isNotGoing ? onMarkPresent : onMarkAbsent,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: isNotGoing
                                  ? Colors.white
                                  : AppColor.primaryColor,
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              isNotGoing ? "Mark Present".tr : "Mark Absent".tr,
                              style: TextStyle(
                                color: isNotGoing
                                    ? AppColor.primaryColor
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
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
