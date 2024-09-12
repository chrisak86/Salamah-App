import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/models/fire_station.dart';
import 'package:salamah/presentation/web/web_dashboard/controllers/web_dashboard_controller.dart';

class FireStationView extends StatelessWidget {
  final controller = Get.find<WebDashboardController>();
  @override
  Widget build(BuildContext context) {
    return  Obx(() => Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.primary.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Station Name',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Station Address',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Status',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.fireStations.length,
              itemBuilder: (context, index) {
                FireStation fireStation = controller.fireStations[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(fireStation.fire_station_name.toString()),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(fireStation.location.toString()),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              fireStation.status=!fireStation.status!;
                              controller.updateFireStation(fireStation);
                            },
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: fireStation.status == true ? AppColors.primary : Colors.grey,
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: fireStation.status == true ? Alignment.centerRight : Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width: 27,
                                        height: 27,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0,right: 4),
                                    child: Align(
                                      alignment: fireStation.status == true ?  Alignment.centerLeft : Alignment.centerRight,
                                      child: Text(
                                        fireStation.status==true ? "Online" : "Offline",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
