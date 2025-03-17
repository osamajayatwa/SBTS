import 'package:bus_tracking_users/view/widget/listchilddialogs.dart';
import 'package:bus_tracking_users/view/widget/studentcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_tracking_users/controllers/home/home_controller.dart';
import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:bus_tracking_users/core/functions/translatefatabase.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListChildsHome extends StatelessWidget {
  const ListChildsHome({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeControllerImp>(() => HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
      builder: (controller) {
        if (controller.rides.isEmpty) {
          return Center(
            child: Text(
              "No Students available.".tr,
              style: TextStyle(fontSize: 18, color: AppColor.primaryColor),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AnimationLimiter(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.rides.length,
              itemBuilder: (context, index) {
                final student = controller.rides[index];
                final isNotGoing =
                    controller.isNotGoingMap[student.stdId] ?? false;
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: StudentCard(
                        student: student,
                        isNotGoing: isNotGoing,
                        onTap: isNotGoing
                            ? null
                            : () => controller.goToItems(
                                  student.stdId!,
                                  translateDatabase(
                                      student.nameAr, student.nameEn),
                                ),
                        onMarkAbsent: () => showMissingDialog(context, student),
                        onMarkPresent: () =>
                            showConfirmDialog(context, student),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
