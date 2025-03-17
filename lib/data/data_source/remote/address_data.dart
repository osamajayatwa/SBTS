import 'package:bus_tracking_users/core/class/crud.dart';
import 'package:bus_tracking_users/linkapi.dart';

class AddressData {
  Crud crud;
  AddressData(this.crud);

  addData(
      String building_no, String street_name, String lat, String long) async {
    var response = await crud.postData(AppLink.location, {
      "street_name": street_name,
      "building_no": building_no,
      "lat": lat,
      "lng": long,
    });
    return response.fold((l) => l, (r) => r);
  }
}
