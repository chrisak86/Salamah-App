import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/models/user.dart';
import 'package:salamah/presentation/web/web_dashboard/controllers/web_dashboard_controller.dart';
import 'package:intl/intl.dart';

class PoliceView extends StatelessWidget {
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
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Email',
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
                Expanded(
                  child: Center(
                    child: Text(
                      'Police Station',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Join Date',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.allPolice.length,
              itemBuilder: (context, index) {
                UserProfile policeOfficer = controller.allPolice[index];
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
                          child: Text(policeOfficer.name.toString()),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(policeOfficer.email.toString()),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              policeOfficer.isApproved=!policeOfficer.isApproved!;
                                  controller.updatePoliceOfficer(policeOfficer);
                            },
                            child: Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: policeOfficer.isApproved == true ? AppColors.primary : Colors.grey,
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: policeOfficer.isApproved == true ? Alignment.centerRight : Alignment.centerLeft,
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
                                      alignment: policeOfficer.isApproved == true ?  Alignment.centerLeft : Alignment.centerRight,
                                      child: Text(
                                        policeOfficer.isApproved==true ? "Approved" : "Disapproved",
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
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                                   controller.showAssignPoliceDialog(context, policeOfficer.user_id!,policeOfficer.policeStations!);
                            },
                            child: Container(
                              width:100,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: AppColors.primary,
                              ),
                              child: Center(
                                child: Text(
                                  policeOfficer.policeStations!.isNotEmpty ? "Police Station" : "Assign Station",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(policeOfficer.created_at.toString()))),
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