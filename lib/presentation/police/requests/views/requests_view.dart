import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:sizer/sizer.dart';
import '../controllers/requests_controller.dart';

class RequestsView extends GetView<RequestsController> {
  const RequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestsController>(
      init: RequestsController(),
      builder: (controller) {
        return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const MyText(title: "Requests"),
            actions: [
              PopupMenuButton<int>(
                icon: const Icon(Icons.settings, color: AppColors.primary),  // Settings button icon
                onSelected: (value) {
                  if (value == 0) {
                    controller.logout();
                  } else if (value == 1) {
                    controller.showDeleteAccountDialog();
                  }
                },
                itemBuilder: (context) => [
                  // Menu item for logout
                  const PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  // Menu item for delete account
                  const PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text('Delete Account'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Switch(
                    value: controller.isOnline.value,
                    onChanged: (value) {
                      controller.isOnline.value = value;
                      controller.updateOnlineStatus(value);
                    },
                    activeColor: Colors.blue,
                  ),
                ).paddingOnly(right: 24),
                Expanded(
                  child: controller.isOnline.isFalse
                      ? const Center(child: MyText(title: "You are offline"))
                      : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: controller.ticketsList.length,
                      itemBuilder: (context, index) {
                        final ticket = controller.ticketsList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: AppColors.primary,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Upper part with data
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        title: "ID :  ${ticket.id}",
                                        clr: AppColors.kWhite,
                                      ),
                                      MyText(
                                        title: "Name :  ${ticket.user_name}",
                                        clr: AppColors.kWhite,
                                      ),
                                      MyText(
                                        title: "Police Station :  ${ticket.police_station_name}",
                                        clr: AppColors.kWhite,
                                      ),
                                      MyText(
                                        title: "Time :  ${ticket.ETA}",
                                        clr: AppColors.kWhite,
                                      ),
                                      MyText(
                                        title: "Distance :  ${ticket.distance}",
                                        clr: AppColors.kWhite,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Bottom part with buttons
                                  InkWell(
                                    onTap: () {
                                      if (ticket.attend_id == null) {
                                        controller.attendEmergency(ticket);
                                      } else {
                                        Get.toNamed(Routes.POLICE_TRAVEL, arguments: ticket);
                                      }
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        color: AppColors.secondary,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Center(
                                        child: MyText(
                                          title: "Attend",
                                          clr: AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          ,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
