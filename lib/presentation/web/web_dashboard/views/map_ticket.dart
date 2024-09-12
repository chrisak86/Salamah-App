import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/models/tickets.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/presentation/web/web_dashboard/controllers/web_dashboard_controller.dart';

class TicketsPanel extends StatelessWidget {
  final controller = Get.find<WebDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Active Tickets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: controller.pendingTicket.length,
              itemBuilder: (context, index) {
                final ticket = controller.pendingTicket[index];
                return TicketCard(ticket);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final Tickets? tickets;
  TicketCard(this.tickets);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.PANEL_TRAVEL,arguments: tickets);
      },
      child: Card(
        color: AppColors.primary.withOpacity(0.5),
        child: ListTile(
          leading: const Icon(Icons.label, color: AppColors.secondary), // Change icon based on ticket type
          title: MyText(title: tickets?.type,size: 18,),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText(title:tickets?.user_name, size: 14,),
              MyText(title:tickets?.distance, size: 12,),
              MyText(title:tickets?.ETA, size: 12,),
            ],
          ),
        ),
      ),
    );
  }
}