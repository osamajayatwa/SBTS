import 'dart:convert';

import 'package:bus_tracking_users/core/constant/color.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Set<Polyline> polylineset = {};

List<LatLng> polylineco = [];
PolylinePoints polylinePoints = PolylinePoints();

Future<void> showPolyline(lat, long, destlat, destlong) async {
  String url =
      "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$long&destination=$destlat,$destlong&key=AIzaSyB4uS7R4gVcI9BbkvUYTokQC2aOHm1R5cw";

  var response = await http.post(Uri.parse(url));
  var responsebody = jsonDecode(response.body);

  if (responsebody['routes'] != null && responsebody['routes'].isNotEmpty) {
    var point = responsebody['routes'][0]['overview_polyline']['points'];
    List<PointLatLng> result = polylinePoints.decodePolyline(point);
    if (result.isNotEmpty) {
      result.forEach((PointLatLng pointlatlng) {
        polylineco.add(LatLng(pointlatlng.latitude, pointlatlng.longitude));
      });
    }
  } else {
    print("No routes found");
  }

  Polyline polyline = Polyline(
      polylineId: PolylineId("osama"),
      color: AppColor.primaryColor,
      points: polylineco,
      width: 6);

  polylineset.add(polyline);
}
