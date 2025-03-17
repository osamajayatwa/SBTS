import 'package:bus_tracking_users/core/class/statusrequest.dart';
import 'package:bus_tracking_users/core/functions/handilingdata.dart';
import 'package:bus_tracking_users/core/services/services.dart';
import 'package:bus_tracking_users/data/data_source/remote/notification_data.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  NotificationData notificationData = NotificationData(Get.find());

  List data = [];
  String? lang;
  String? lang2;
  String? parentname;

  late StatusRequest statusrequest;

  MyServices myServices = Get.find();

  getData() async {
    statusrequest = StatusRequest.loading;
    var response = await notificationData
        .getData(myServices.sharedPreferences.getString("id")!);

    print("=============================== Controller $response ");
    statusrequest = handilingData(response);
    if (StatusRequest.success == statusrequest) {
      if (response['status'] == "success") {
        data.addAll(response['data']);
      } else {
        statusrequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    parentname = myServices.sharedPreferences.getString("name_en");

    lang = myServices.sharedPreferences.getString("lang");
    lang2 = myServices.sharedPreferences.getString("lang2");

    getData();
    super.onInit();
  }
}
