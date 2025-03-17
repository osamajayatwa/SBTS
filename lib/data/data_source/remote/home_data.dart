import 'package:bus_tracking_users/core/class/crud.dart';
import 'package:bus_tracking_users/linkapi.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);
  getData() async {
    var response = await crud.postData(AppLink.homepage, {});
    return response.fold((l) => 1, (r) => r);
  }

  deleteFcmToken(String parentId) async {
    var response = await crud.postData(AppLink.deleteFcmToken, {
      "parentId": parentId,
    });
    return response.fold((l) => 1, (r) => r);
  }
}
