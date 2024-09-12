import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/presentation/web/dash_board_tracking/controllers/panel_tracking_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../app/shared_widgets/Text.dart';

class PanelTrackingView extends GetView<PanelTrackingController> {
  const PanelTrackingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return GoogleMap(
                compassEnabled: false,
                zoomControlsEnabled: false,
                myLocationEnabled: false,
                mapType: MapType.normal,
                polylines: Set<Polyline>.of(controller.polylines),
                markers: Set<Marker>.of(controller.markers),
                // tileOverlays: c.tileOverlays,
                mapToolbarEnabled: true,
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
                      child: const Text('Closed'),
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
