import 'package:bus_tracking_users/core/class/crud.dart';
import 'package:bus_tracking_users/linkapi.dart';

class ResetData {
  Crud crud;
  ResetData(this.crud);
  resetdata(String parent, String newpassword) async {
    var response = await crud.postData(AppLink.reset, {
      "parent": parent,
      "newpassword": newpassword,
    });
    return response.fold((l) => 1, (r) => r);
  }
}
