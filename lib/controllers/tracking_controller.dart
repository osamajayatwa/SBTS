// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bus_tracking_users/core/constant/imageassests.dart';
import 'package:bus_tracking_users/core/class/statusrequest.dart';
import 'package:bus_tracking_users/core/services/services.dart';
import 'package:bus_tracking_users/data/data_source/remote/locationdata.dart';
import 'package:bus_tracking_users/data/model/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TrackingController extends GetxController {
  late StatusRequest statusRequest;
  CameraPosition? cameraPosition;
  GoogleMapController? mapController;
  Set<Marker> get markerSet => markers.toSet();
  late WebSocketChannel _wsChannel;
  StreamSubscription? _wsSubscription;
  DateTime? _lastUpdate;
  LatLng? _previousPosition;
  double currentSpeed = 0.0;
  double totalDistance = 0.0;
  String? eta;
  String? routeName;
  double _currentZoom = 15.0;
  final Locationdata locationData = Locationdata(Get.find());
  final MyServices myServices = Get.find();
  List<Marker> markers = [];
  Set<Polyline> polylines = {};
  BitmapDescriptor? busIcon;
  String? roundId;
  double? busLat;
  double? busLng;
  final List<LatLng> _routeHistory = [];
  int _retryCount = 0;
  Timer? _retryTimer;
  final double _animationDuration = 1.5;
  LatLng? _animatedPosition;

  @override
  void onInit() {
    super.onInit();
    initializeTracking();
  }

  @override
  void onClose() {
    mapController?.setMapStyle(null);
    _wsSubscription?.cancel();

    _wsSubscription?.cancel();
    try {
      _wsChannel.sink.close();
    } catch (e) {
      print("Error closing WebSocket: $e");
    }
    super.onClose();
  }

  void centerMap() {
    if (busLat != null && busLng != null) {
      mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(busLat!, busLng!)),
      );
    }
  }

  void zoomIn() {
    _currentZoom = min(_currentZoom + 1, 20.0);
    mapController?.animateCamera(CameraUpdate.zoomTo(_currentZoom));
  }

  void zoomOut() {
    _currentZoom = max(_currentZoom - 1, 10.0);
    mapController?.animateCamera(CameraUpdate.zoomTo(_currentZoom));
  }

  void _updateETA() {
    // Implement your actual ETA calculation logic
    final remainingDistance = _calculateTotalDistance();
    final averageSpeed = currentSpeed > 0 ? currentSpeed : 30;
    final etaTime = DateTime.now().add(
      Duration(
          minutes: (remainingDistance / (averageSpeed * 1000) * 60).toInt()),
    );
    eta = DateFormat('hh:mm a').format(etaTime);
  }

  void _updateRouteMetrics(LatLng newPosition) {
    if (_previousPosition != null) {
      final distance = _calculateDistance(
        _previousPosition!.latitude,
        _previousPosition!.longitude,
        newPosition.latitude,
        newPosition.longitude,
      );
      totalDistance += distance;
      _updateETA();
    }
    _previousPosition = newPosition;
    update();
  }

  void handleWebSocketMessage(dynamic data) {
    const updateThreshold = 500; // milliseconds
    final now = DateTime.now();

    if (_lastUpdate != null &&
        now.difference(_lastUpdate!) <
            Duration(milliseconds: updateThreshold)) {
      return;
    }
    try {
      final json = jsonDecode(data);
      final lat = json['lat'] as double?;
      final lng = json['lng'] as double?;
      final speed = json['speed'] as double?;
      final route = json['route'] as String?;

      if (lat == null || lng == null) return;

      // Use null-coalescing with proper speed calculation
      currentSpeed = speed ?? _calculateSpeed(LatLng(lat, lng));
      _updateMarkerColor();
      routeName = route;
      _updateRouteMetrics(LatLng(lat, lng));
      updateBusLocation(lat, lng);
      _updateETA();
      _lastUpdate = now;
      // ignore: unnecessary_null_comparison
      if (lat != null && lng != null) {
        _updateCameraPosition(LatLng(lat, lng));
      }
      update();
    } catch (e) {
      print("Error processing message: $e");
    }
  }

  List<LatLng> parseRouteFromResponse(Map<String, dynamic> response) {
    try {
      final List<dynamic> routeData = response['route']['coordinates'];
      return routeData.map((coord) {
        return LatLng(
          coord['latitude'] as double,
          coord['longitude'] as double,
        );
      }).toList();
    } catch (e) {
      print("Error parsing route: $e");
      return [];
    }
  }

  void initializeTracking() async {
    roundId = Get.arguments as String?;
    if (roundId == null) {
      showErrorSnackbar("Invalid tracking ID");
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    await loadCustomBusIcon();
    _resetMetrics();
    _setupConnections();
  }

  void _resetMetrics() {
    currentSpeed = 0.0;
    totalDistance = 0.0;
    eta = null;
    _routeHistory.clear();
    polylines.clear();
    update();
  }

  Future<void> _loadRouteDetails() async {
    try {
      final response = await locationData.getRouteDetails(roundId!);
      if (response is Map<String, dynamic>) {
        final routePoints = parseRouteFromResponse(response);

        if (routePoints.isNotEmpty) {
          polylines.add(Polyline(
            polylineId: PolylineId("route_$roundId"),
            points: routePoints,
            color: Colors.blue,
            width: 4,
          ));
          update();
        }
      }
    } catch (e) {
      print("Error loading route details: $e");
    }
  }

  Future<void> loadCustomBusIcon() async {
    try {
      busIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(80, 80)),
        ImageAssest.busicon,
      );
    } catch (e) {
      busIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    }
  }

  void setupWebSocketConnection() {
    try {
      _updateConnectionStatus(StatusRequest.loading);
      _wsChannel = WebSocketChannel.connect(
        Uri.parse('wss://your-api-server/live-tracking/$roundId'),
      );

      _wsChannel.ready.then((_) {
        _updateConnectionStatus(StatusRequest.success);
      }).catchError((error) {
        _handleConnectionError(error);
      });
    } catch (e) {
      _handleConnectionError(e);
    }
  }

  void _animateMarkerMovement(LatLng newPosition) {
    if (_animatedPosition == null) {
      _animatedPosition = newPosition;
      return;
    }

    final bearing = _calculateRotation();
    final distance = _calculateDistanceBetween(_animatedPosition!, newPosition);

    // Only animate for significant movements
    if (distance > 5) {
      // meters
      markers.removeWhere((m) => m.markerId.value == "bus");
      markers.add(Marker(
        markerId: const MarkerId("bus"),
        position: newPosition,
        rotation: bearing,
        icon: busIcon!,
        anchor: const Offset(0.5, 0.5),
      ));
      _animatedPosition = newPosition;
    }
  }

  double _calculateRotation() {
    if (_routeHistory.length < 2) return 0;
    final previous = _routeHistory[_routeHistory.length - 2];
    final current = _routeHistory.last;
    return atan2(current.longitude - previous.longitude,
            current.latitude - previous.latitude) *
        180 /
        pi;
  }

  void _updateRouteHistory(LatLng newPosition) {
    _routeHistory.add(newPosition);
    if (_routeHistory.length > 100) _routeHistory.removeAt(0);

    polylines.add(Polyline(
      polylineId: const PolylineId("route"),
      points: List.from(_routeHistory),
      color: Colors.blue,
      width: 4,
    ));
  }

  double _calculateSpeed(LatLng newPosition) {
    if (_lastUpdate == null || _previousPosition == null) {
      _lastUpdate = DateTime.now();
      _previousPosition = newPosition;
      return 0.0;
    }

    final timeDiff = DateTime.now().difference(_lastUpdate!).inSeconds;
    if (timeDiff == 0) return currentSpeed;

    final distance = _calculateDistance(
      _previousPosition!.latitude,
      _previousPosition!.longitude,
      newPosition.latitude,
      newPosition.longitude,
    );

    final calculatedSpeed = (distance / timeDiff) * 3.6; // km/h
    _lastUpdate = DateTime.now();
    _previousPosition = newPosition;

    return calculatedSpeed;
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371e3; // Meters
    final lat1Rad = _degreesToRadians(lat1);
    final lat2Rad = _degreesToRadians(lat2);
    final deltaLat = _degreesToRadians(lat2 - lat1);
    final deltaLon = _degreesToRadians(lon2 - lon1);

    final a = _haversineComponent(deltaLat) +
        cos(lat1Rad) * cos(lat2Rad) * _haversineComponent(deltaLon);

    return earthRadius * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  double _degreesToRadians(double degrees) => degrees * pi / 180;

  double _haversineComponent(double angle) => sin(angle / 2) * sin(angle / 2);

  void _updateCameraPosition(LatLng newPosition) {
    const minMoveThreshold = 50; // meters
    if (busLat == null || busLng == null) return;

    final previousPosition = LatLng(busLat!, busLng!);
    final distance = _calculateDistanceBetween(previousPosition, newPosition);

    if (distance > minMoveThreshold) {
      mapController?.animateCamera(
        CameraUpdate.newLatLng(newPosition),
      );
    }
  }

  void updateBusLocation(double lat, double lng) {
    busLat = lat;
    busLng = lng;
    _animateMarkerMovement(LatLng(lat, lng));
    markers
      ..clear()
      ..add(
        Marker(
          markerId: const MarkerId("bus"),
          position: LatLng(lat, lng),
          icon: busIcon ?? BitmapDescriptor.defaultMarker,
          rotation: _calculateRotation(),
        ),
      );

    _updateRouteHistory(LatLng(lat, lng));
    update();
  }

  void _handleConnectionError(dynamic error) {
    _updateConnectionStatus(StatusRequest.failure);
    _scheduleReconnection();
  }

  void _updateConnectionStatus(StatusRequest status) {
    statusRequest = status;
    update();
  }

  void _scheduleReconnection() {
    const maxRetries = 5;
    if (_retryCount >= maxRetries) {
      _updateConnectionStatus(StatusRequest.failure);
      showErrorSnackbar("Connection lost. Please try again later.");
      return;
    }
    _retryTimer?.cancel();
    _retryCount++;

    final delay = Duration(seconds: pow(2, _retryCount).toInt());
    _retryTimer = Timer(delay, () {
      if (statusRequest != StatusRequest.success) {
        setupWebSocketConnection();
      }
    });
  }

  Future<void> fetchInitialBusLocation(String roundId) async {
    try {
      final response = await locationData.getlocation(
        roundId,
        DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now()),
      );

      if (response is Map<String, dynamic>) {
        final trackBusResponse = trackBus.fromJson(response);
        if (trackBusResponse.items?.isNotEmpty ?? false) {
          final firstItem = trackBusResponse.items!.first;
          updateBusLocation(firstItem.lat!, firstItem.lng!);
          _updateCameraPosition(LatLng(firstItem.lat!, firstItem.lng!));
          statusRequest = StatusRequest.success;
          update();
          return;
        }
      }
      throw Exception("No valid data received");
    } catch (e) {
      print("Initial location error: $e");
      _handleConnectionError(e);
    }
  }

  void setupDefaultCamera() {
    if (busLat != null && busLng != null) {
      cameraPosition = CameraPosition(
        target: LatLng(busLat!, busLng!),
        zoom: 15.0,
      );
      update();
    }
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  double _calculateTotalDistance() {
    double total = 0;
    for (int i = 1; i < _routeHistory.length; i++) {
      total += _calculateDistanceBetween(
        _routeHistory[i - 1],
        _routeHistory[i],
      );
    }
    return total;
  }

  double _calculateDistanceBetween(LatLng start, LatLng end) {
    return _calculateDistance(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  void _setupConnections() async {
    try {
      await fetchInitialBusLocation(roundId!);
      setupWebSocketConnection();
      _loadRouteDetails();
    } catch (e) {
      _handleConnectionError(e);
    }
  }

  void _updateMarkerColor() {
    if (currentSpeed < 5) {
      busIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    } else if (currentSpeed < 20) {
      busIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    } else {
      busIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
    update();
  }
}
