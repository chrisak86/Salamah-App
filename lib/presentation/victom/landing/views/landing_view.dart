import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/app/shared_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title:  MyText(title:'Accident', size: 16.sp,clr: AppColors.primary,),
        centerTitle: true,
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
      body: Column(
        children: [
          ToggleButtons(
            color: AppColors.black,
            borderColor: Colors.transparent,
            fillColor: AppColors.primary,
            borderWidth: 2,
            selectedBorderColor: Colors.transparent,
            selectedColor: AppColors.kWhite,
            borderRadius: BorderRadius.circular(8),
            onPressed: (index) {
              controller.changeSelectedIndex(index);
            },
            isSelected: [
              controller.selectedIndex.value == 0,
              controller.selectedIndex.value == 1,
              controller.selectedIndex.value == 2
            ],
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: MyText(title: 'Accident'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: MyText(title: 'Ambulance'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: MyText(title: 'Fire Truck'),
              ),
            ],
          ),
          Expanded(
            child: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
              compassEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              initialCameraPosition: CameraPosition(
                target: controller.currentLocation.value,
                zoom: 14,
              ),
              markers: Set<Marker>.of(controller.markers),
              onMapCreated: (GoogleMapController mapController1) {
                controller.mapController = mapController1;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomButton(
                    height: 5.9.h,
                    text: "Request Now",
                    onPress: controller.isRequesting.value ? null : controller.onRequestNow,
                    textColor: AppColors.kWhite,
                    boxColor: AppColors.primary).paddingOnly(top: 0.5.h),
                CustomButton(
                    height: 5.9.h,
                    text: "Call 112",
                    onPress: controller.isRequesting.value ? null : controller.onRequestNow,
                    textColor: AppColors.black,
                    boxColor: AppColors.secondary).paddingOnly(top: 0.5.h),
                 MyText(
                  title: 'Police Traffic Department has been notified and will contact you shortly!',
                  textAlign: TextAlign.center,
                  size: 7.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
