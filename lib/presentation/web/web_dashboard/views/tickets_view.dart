import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/models/tickets.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/presentation/web/web_dashboard/controllers/web_dashboard_controller.dart';

class TicketsView extends StatelessWidget {
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
                      'ID',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
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
                      'Type',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Type Name',
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
                      'View',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.allTicket.length,
              itemBuilder: (context, index) {
                final ticket = controller.allTicket[index];
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
                          child: Text(ticket.id.toString()),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(ticket.user_name.toString()),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(ticket.type.toString()),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(ticket.police_station_name  ?? ticket.hospital_name ?? ticket.fire_station_name ?? ""),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if(ticket.cancel == null) {
                                ticket.completed = !ticket.completed!;
                                controller.updateTicketStatus(ticket);
                              }if(ticket.cancel==true){
                                controller.showReasonPopup(context,ticket.reason ?? "No reason");
                              }
                            },
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: ticket.cancel == true ? Colors.blue :ticket.completed == true ? AppColors.errorColor : Colors.grey,
                              ),
                              child: Center(
                                child: MyText(title:ticket.cancel == true ? "Cancelled" : ticket.completed == true ? "Closed" : "Close",),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.PANEL_TRAVEL,arguments: ticket);
                            },
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color:  AppColors.primary,
                              ),
                              child: Center(
                                child: Icon(Icons.remove_red_eye,),
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