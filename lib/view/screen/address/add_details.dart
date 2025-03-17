import 'package:bus_tracking_users/controllers/address/add_details_controller.dart';
import 'package:bus_tracking_users/core/class/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bus_tracking_users/core/constant/color.dart';

class AddressAdd extends StatelessWidget {
  const AddressAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressAddController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.find<AddressAddController>().goToCurrentLocation(),
        backgroundColor: AppColor.primaryColor,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
      appBar: AppBar(
        title: const Text('Add Home Address'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<AddressAddController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              _buildMapSection(controller),
              _buildAddressForm(controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMapSection(AddressAddController controller) {
    return SizedBox.expand(
      child: GoogleMap(
        mapType: MapType.normal,
        markers: controller.markers,
        onTap: controller.addMarkers,
        initialCameraPosition: controller.initialCameraPosition,
        onMapCreated: (GoogleMapController mapController) {
          controller.mapController.complete(mapController);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      ),
    );
  }

  Widget _buildAddressForm(AddressAddController controller) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              TextFormField(
                controller: controller.streetController,
                decoration: InputDecoration(
                    labelText: 'Street Name',
                    prefixIcon: const Icon(Icons.streetview),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.buildingController,
                decoration: InputDecoration(
                    labelText: 'Building Number',
                    prefixIcon: const Icon(Icons.numbers),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.save,
                  color: AppColor.backgroundcolor,
                ),
                label: const Text('Save Address'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                onPressed: controller.saveAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
