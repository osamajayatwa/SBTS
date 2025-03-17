import 'package:bus_tracking_users/core/class/crud.dart';
import 'package:bus_tracking_users/linkapi.dart';

class CheckEmailData {
  Crud crud;
  CheckEmailData(this.crud);
  loginpostdata(
    String email,
  ) async {
    var response = await crud.postData(AppLink.checkEmail, {
      "email ": email,
    });
    return response.fold((l) => 1, (r) => r);
  }
}
