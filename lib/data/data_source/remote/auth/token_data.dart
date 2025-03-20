import 'package:bus_tracking_users/core/class/crud.dart';
import 'package:bus_tracking_users/linkapi.dart';

class TokenData {
  Crud crud;
  TokenData(this.crud);
  postdata(String table, String parent, String token) async {
    var response = await crud.postData(
        AppLink.token, {"table ": table, "parent": parent, "token": token});
    return response.fold((l) => 1, (r) => r);
  }
}
