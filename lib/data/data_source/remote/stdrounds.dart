import 'package:bus_tracking_users/core/class/crud.dart';
import 'package:bus_tracking_users/linkapi.dart';

class StdroundsData {
  Crud crud;
  StdroundsData(this.crud);
  getData(String id) async {
    var response = await crud.getData(AppLink.getroundsstd, {"std_id": id});

    print("$response");
    return response.fold((l) => 1, (r) => r);
  }

  getlocation(String roundid, String time) async {
    var response = await crud.getData(AppLink.trackingpage, {
      'roundId': roundid,
      'time': time.toString(),
    });

    return response.fold((l) => 1, (r) => r);
  }
}
