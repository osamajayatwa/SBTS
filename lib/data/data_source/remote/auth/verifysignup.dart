import 'package:bus_tracking_users/core/class/crud.dart';
import 'package:bus_tracking_users/linkapi.dart';

class VerifySignUpData {
  Crud crud;
  VerifySignUpData(this.crud);
  postverifydata(String email, String verifycode) async {
    var response = await crud.postData(
        AppLink.verifysignupdata, {"email": email, "verifycode": verifycode});
    return response.fold((l) => 1, (r) => r);
  }

  resendData(String email) async {
    var response = await crud.postData(AppLink.resend, {"email": email});
    return response.fold((l) => l, (r) => r);
  }
}
