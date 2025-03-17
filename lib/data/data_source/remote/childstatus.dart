import 'package:bus_tracking_users/core/class/crud.dart';
import 'package:bus_tracking_users/linkapi.dart';

class ChildStatus {
  Crud crud;
  ChildStatus(this.crud);
  psotdata(String std, String is_absence) async {
    var response = await crud.postData(AppLink.childstatus, {
      "std": std,
      "is_absence": is_absence,
    });

    return response.fold((l) => 1, (r) => r);
  }
}
