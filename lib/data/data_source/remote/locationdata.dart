import 'package:bus_tracking_users/core/class/crud.dart';
import 'package:bus_tracking_users/linkapi.dart';

class Locationdata {
  Crud crud;
  Locationdata(this.crud);
  getData(
    String parent,
    String lng,
    String lat,
  ) async {
    var response = await crud.postData(AppLink.location, {
      parent: "parent",
      lng: "lng",
      lat: "lat",
    });
    return response.fold((l) => 1, (r) => r);
  }

  getlocation(String roundid, String time) async {
    var response = await crud.getData(AppLink.trackingpage, {
      'roundId': roundid,
      'time': time.toString(),
    });
    return response.fold((l) => 1, (r) => r);
  }

  getRouteDetails(
    String roundid,
  ) async {
    var response = await crud.getData(AppLink.trackingpage, {
      'roundId': roundid,
    });
    return response.fold((l) => 1, (r) => r);
  }
}
