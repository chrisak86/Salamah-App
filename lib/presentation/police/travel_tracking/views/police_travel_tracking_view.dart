import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/presentation/police/travel_tracking/controllers/police_travel_tracking_controller.dart';
import 'package:salamah/presentation/victom/travel_tracking/controllers/travel_tracking_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../app/shared_widgets/Text.dart';
import 'dart:io' show Platform;

class PoliceTravelTrackingView extends GetView<PoliceTravelTrackingController> {
  const PoliceTravelTrackingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  MyText(title:'Traveling Detail', size: 16.sp,clr: AppColors.primary,),
        centerTitle: true,
      ),
      body: controller.isLoaded.isTrue ?
          const Center(
            child: CircularProgressIndicator(),
          ):
      Column(
        children: [
          Expanded(
            child: Obx(() {
              return GoogleMap(
                compassEnabled: Platform.isAndroid ? false : false,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                polylines: Set<Polyline>.of(controller.polylines),
                markers: Set<Marker>.of(controller.markers),
                // tileOverlays: c.tileOverlays,
                mapToolbarEnabled: false,
                onMapCreated: (GoogleMapController mController) {
                  controller.mapController = mController;
                  controller.update();
                },
                initialCameraPosition:
                CameraPosition(
                  target: LatLng(controller.userData?.latitude ?? 29.3759,controller.userData?.longitude ?? 47.9774), //Multan
                  zoom: 14.5,
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.updateTicketStatus();
                      },
                      child: const Text('Mark as Completed'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
