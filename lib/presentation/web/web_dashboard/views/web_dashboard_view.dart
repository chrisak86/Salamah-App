import 'package:dio_log/http_log_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:salamah/presentation/web/web_dashboard/views/dashboard_view.dart';
import 'package:salamah/presentation/web/web_dashboard/views/fire_station_view.dart';
import 'package:salamah/presentation/web/web_dashboard/views/hospital_view.dart';
import 'package:salamah/presentation/web/web_dashboard/views/police_station_view.dart';
import 'package:salamah/presentation/web/web_dashboard/views/police_user_view.dart';
import 'package:salamah/presentation/web/web_dashboard/views/tickets_view.dart';
import 'package:sizer/sizer.dart';

import '../controllers/web_dashboard_controller.dart';

class WebDashboardView extends GetView<WebDashboardController> {
  const WebDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebDashboardController>(
      init: WebDashboardController(),
      builder: (context) {
        return Scaffold(
          body: Row(
            children: [
              NavigationPanel(controller.selectedIndex),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              color: AppColors.primary,
                              child: const Text(
                                'Dashboard',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CircleAvatar(
                                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                              ),
                              const SizedBox(width: 8.0),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Salamah',
                                    style: TextStyle(color: AppColors.primary, fontSize: 18),
                                  ),
                                  GestureDetector(
                                    onLongPress: (){
                                      Navigator.of(Get.context!).push(
                                        MaterialPageRoute(
                                          builder: (context) => HttpLogListWidget(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Super Admin',
                                      style: TextStyle(color: AppColors.primary),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16.0),
                              IconButton(onPressed: (){
                                Get.offAllNamed(Routes.WEB_LOGIN);
                              },
                                  icon: const Icon(Icons.logout, color: AppColors.primary))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Obx(() {
                        switch (controller.selectedIndex.value) {
                          case 0:
                            return DashboardView();
                          case 1:
                            return TicketsView();
                          case 2:
                            return PoliceStationView();
                          case 3:
                            return FireStationView();
                          case 4:
                            return HospitalsView();
                          case 5:
                            return PoliceView();
                          default:
                            return DashboardView();
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class NavigationPanel extends StatelessWidget {
  final RxInt selectedIndex;

  const NavigationPanel(this.selectedIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width < 600 ? 100 : 250,
      color: AppColors.primary,
      child: Column(
        children: [
          Image.asset(Utils.getIconPath("salamah"),width: 44.2.w,height: 11.2.h,).paddingOnly(top: 1.h,bottom: 2.h),
          _buildMenuItem('Dashboard', Icons.dashboard, 0),
          _buildMenuItem('Tickets', Icons.receipt_long, 1),
          _buildMenuItem('Police Station', Icons.local_police, 2),
          _buildMenuItem('Fire Station', Icons.fire_truck, 3),
          _buildMenuItem('Hospitals', Icons.local_hospital, 4),
          _buildMenuItem('Police Officers', Icons.security, 5),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, int index) {
    return Obx(() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: selectedIndex.value == index ? AppColors.secondary : AppColors.primary ,
        border: Border(
          left: BorderSide(
            color:selectedIndex.value == index ? AppColors.secondary : AppColors.primary ,
            width: 5.0,
          ),
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: selectedIndex.value == index ? AppColors.primary : AppColors.secondary,
          size: MediaQuery.of(Get.context!).size.width < 600 ? 20 : 30,
        ),
        title: MediaQuery.of(Get.context!).size.width < 600
            ? Container()
            : Text(
          title,
          style: TextStyle(
            color: selectedIndex.value == index ? AppColors.primary : AppColors.secondary,
          ),
        ),
        selected: selectedIndex.value == index,
        onTap: () => selectedIndex.value = index,
      ),
    ));
  }
}

