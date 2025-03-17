import 'package:bus_tracking_users/data/data_source/static/static.dart';
import 'package:flutter/material.dart';
import 'package:bus_tracking_users/controllers/onbording_controller.dart';
import 'package:get/get.dart';

class CustomSliderOnBording extends GetView<OnBordingControllerImp> {
  const CustomSliderOnBording({super.key});

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    return PageView.builder(
        controller: controller.pagecontroller,
        onPageChanged: (val) {
          controller.onPageChanged(val);
        },
        itemCount: onBoardingList.length,
        itemBuilder: (context, i) => Column(
              children: [
                Image.asset(
                  width: widthSize * 1,
                  height: heightSize * 0.6,
                  fit: BoxFit.fill,
                  onBoardingList[i].image!,
                ),
                SizedBox(
                  height: heightSize * 0.08,
                ),
                Text(
                  onBoardingList[i].title!,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: heightSize * 0.01,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    onBoardingList[i].body!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ));
  }
}
