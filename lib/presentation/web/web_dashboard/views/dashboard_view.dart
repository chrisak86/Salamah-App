import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:salamah/presentation/web/web_dashboard/controllers/web_dashboard_controller.dart';
import 'package:salamah/presentation/web/web_dashboard/views/map_ticket.dart';

class DashboardView extends StatelessWidget {

  final controller = Get.find<WebDashboardController>();

  @override
  Widget build(BuildContext context) {
    return  ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.isDesktop) {
                return Obx(()=>Scaffold(
                  body: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(29.3759, 47.9774), // Centered on Kuwait
                            zoom: 13.0,
                          ),
                          markers: Set<Marker>.of(controller.markers),
                          onMapCreated: (GoogleMapController mapController) {
                            controller.mapController = mapController;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TicketsPanel(), // Your ticket list widget
                      ),
                    ],
                  ),
                ));
              } else {
                return Obx(()=>Scaffold(
                  appBar: AppBar(
                    title: Text('Salamah Dashboard'),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.list),
                        onPressed: () => controller.showTickets(context),
                      ),
                    ],
                  ),
                  body: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(29.3759, 47.9774), // Centered on Kuwait
                      zoom: 13.0,
                    ),
                    markers: Set<Marker>.of(controller.markers),
                    onMapCreated: (GoogleMapController mapController) {
                      controller.mapController = mapController;
                    },
                  ),
                ));
              }
            },
          );
  }
}