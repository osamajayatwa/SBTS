import 'package:bus_tracking_users/controllers/tracking_controller.dart';
import 'package:bus_tracking_users/core/class/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Tracking extends StatelessWidget {
  const Tracking({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TrackingController());

    return Scaffold(
      body: GetBuilder<TrackingController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.failure) {
            return _ErrorView(onRetry: controller.initializeTracking);
          }

          return SizedBox.expand(
            child: Stack(
              children: [
                _buildMap(controller),
                _buildAppBar(controller),
                _buildBottomSheet(controller),
                _buildMapControls(controller),
                if (controller.statusRequest == StatusRequest.loading)
                  _buildLoadingOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black54,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }

  Widget _buildMap(TrackingController controller) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: controller.cameraPosition ??
          const CameraPosition(
            target: LatLng(24.7136, 46.6753),
            zoom: 15,
          ),
      markers: controller.markerSet,
      polylines: controller.polylines,
      onMapCreated: (mapController) {
        controller.mapController = mapController;
        if (controller.busLat != null && controller.busLng != null) {
          mapController.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(controller.busLat!, controller.busLng!),
            ),
          );
        }
      },
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
    );
  }

  Widget _buildAppBar(TrackingController controller) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
              Expanded(
                child: Text(
                  'Live Bus Tracking'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _ConnectionStatusWidget(controller: controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(TrackingController controller) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(Get.context!).size.height * 0.8,
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.25,
          minChildSize: 0.15,
          maxChildSize: 0.4,
          snap: true,
          snapSizes: const [0.15, 0.25, 0.4],
          builder: (_, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ListView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildRouteInfo(controller),
                  const SizedBox(height: 20),
                  _buildSpeedInfo(controller),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRouteInfo(TrackingController controller) {
    return Row(
      children: [
        const Icon(Icons.route, color: Colors.blue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Route'.tr,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
            Text(controller.routeName ?? 'Loading...',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _buildSpeedInfo(TrackingController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricItem(
            label: 'Speed'.tr,
            value: '${controller.currentSpeed.toStringAsFixed(1)} km/h',
            icon: Icons.speed,
          ),
          _buildMetricItem(
            label: 'Distance'.tr,
            value: '${controller.totalDistance.toStringAsFixed(2)} km',
            icon: Icons.linear_scale,
          ),
          _buildMetricItem(
            label: 'ETA'.tr,
            value: controller.eta ?? 'Calculating...',
            icon: Icons.access_time,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(
      {required String label, required String value, required IconData icon}) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildMapControls(TrackingController controller) {
    return Positioned(
      bottom: 150,
      right: 16,
      child: Column(
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: 'btn_zoom_in',
            onPressed: () => controller.zoomIn(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            mini: true,
            heroTag: 'btn_zoom_out',
            onPressed: () => controller.zoomOut(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'btn_center',
            onPressed: () => controller.centerMap(),
            child: const Icon(Icons.gps_fixed),
          ),
        ],
      ),
    );
  }
}

class _ConnectionStatusWidget extends StatelessWidget {
  final TrackingController controller;

  const _ConnectionStatusWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackingController>(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: controller.statusRequest == StatusRequest.success
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: controller.statusRequest == StatusRequest.success
                      ? Colors.green
                      : Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                controller.statusRequest == StatusRequest.success
                    ? 'Connected'.tr
                    : 'Disconnected'.tr,
                style: TextStyle(
                  color: controller.statusRequest == StatusRequest.success
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/connection_lost.png', height: 150),
          const SizedBox(height: 20),
          Text('connection_error'.tr,
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: Text("reconnect".tr),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
