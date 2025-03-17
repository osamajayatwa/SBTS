import 'package:bus_tracking_users/core/class/crud.dart';
import 'package:bus_tracking_users/linkapi.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);

  saveFcmTokenAndLogin(
      String username, String password, String fcmToken) async {
    var response = await crud.postData(AppLink.logindata,
        {"username": username, "password": password, "token": fcmToken});
    print(response);
    return response.fold((l) => 1, (r) => r);
  }
}
