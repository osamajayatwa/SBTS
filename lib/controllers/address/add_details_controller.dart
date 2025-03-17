import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bus_tracking_users/core/class/statusrequest.dart';
import 'package:bus_tracking_users/data/data_source/remote/address_data.dart';

class AddressAddController extends GetxController {
  final AddressData addressData = AddressData(Get.find());
  final Completer<GoogleMapController> mapController = Completer();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(24.7136, 46.6753),
    zoom: 16,
  );
  Set<Marker> markers = {};
  LatLng? selectedPosition;
  StatusRequest statusRequest = StatusRequest.loading;

  @override
  void onInit() {
    initializeLocation();
    super.onInit();
  }

  Future<void> initializeLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      _updateCameraPosition(position);
      addMarkers(LatLng(position.latitude, position.longitude));
      statusRequest = StatusRequest.none;
      update();
    } catch (e) {
      Get.snackbar('Error', 'Could not fetch initial location');
      _updateCameraPosition(null);
    }
  }

  Future<void> goToCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition();
      final GoogleMapController controller = await mapController.future;

      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          16,
        ),
      );

      addMarkers(LatLng(position.latitude, position.longitude));
      Get.snackbar('Success', 'Location updated');
    } catch (e) {
      Get.snackbar('Error', 'Could not fetch current location');
    }
  }

  void _updateCameraPosition(Position? position) {
    initialCameraPosition = CameraPosition(
      target: position != null
          ? LatLng(position.latitude, position.longitude)
          : initialCameraPosition.target,
      zoom: 16,
    );
    update();
  }

  void addMarkers(LatLng position) {
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId('selected_location'),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));
    selectedPosition = position;
    update();
  }

  Future<void> saveAddress() async {
    if (streetController.text.isEmpty || buildingController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    if (selectedPosition == null) {
      Get.snackbar('Error', 'Please select a location on the map');
      return;
    }

    try {
      final response = await addressData.addData(
        buildingController.text,
        streetController.text,
        selectedPosition!.latitude.toString(),
        selectedPosition!.longitude.toString(),
      );

      if (response['status'] == 'Successfull') {
        Get.back();
        Get.snackbar('Success', 'Address saved successfully');
      } else {
        Get.snackbar('Error', 'Failed to save address');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    }
  }

  @override
  void onClose() {
    streetController.dispose();
    buildingController.dispose();
    super.onClose();
  }
}
