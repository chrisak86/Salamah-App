import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/config/global_var.dart';
import 'package:salamah/app/shared_widgets/custom_button.dart';
import 'package:salamah/presentation/victom/travel_tracking/controllers/travel_tracking_controller.dart';
import 'package:sizer/sizer.dart';
import 'dart:io' show Platform;
import '../../../../app/shared_widgets/Text.dart';

class TravelTrackingView extends GetView<TravelTrackingController> {
  const TravelTrackingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title:Globals.userProfile?.name ?? "",size: 12.sp,    clr: AppColors.primary,),
                MyText(
                  title: 'Traveling Detail',
                  size: 16.sp,
                  clr: AppColors.primary,
                ),
                MyText(
                  title:  Globals.userProfile?.civilId != null && Globals.userProfile!.civilId!.length > 6
                      ? '**${Globals.userProfile!.civilId!.substring(Globals.userProfile!.civilId!.length - 6)}'
                      : "**${Globals.userProfile!.civilId!}",
                  size: 12.sp,
                  clr: AppColors.primary,
                ),
              ],
            ).paddingOnly(top: 1.h,bottom: 1.h,left: 2.w,right: 2.w),
            controller.index.value==1 ?
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
              ],
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MyText(title: 'Accident'),
                ),
              ],
            ):
            controller.index.value==2 ?
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
              ],
            )
            :ToggleButtons(
              color: AppColors.black,
              borderColor: Colors.transparent,
              fillColor: AppColors.primary,
              borderWidth: 2,
              selectedBorderColor: Colors.transparent,
              selectedColor: AppColors.kWhite,
              borderRadius: BorderRadius.circular(8),
              onPressed: (index) {
                if(index==0){
                  controller.startFetchingTimer();
                }else{
                  controller.fetchTimer?.cancel();
                }
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
              child:  Obx(() {
                return GoogleMap(
                  compassEnabled: Platform.isAndroid ? false : false,
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
              })
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: controller.tickets?.police_station_name!=null,
                    child:  Obx(() => MyText(
                      title:"Police is on the way from ${controller.name.value}")),),
                  Visibility(
                    visible: controller.tickets?.hospital_name!=null,
                    child:  Obx(() => MyText(
                        title: "Ambulance is on the way from ${controller.name.value}")),),
                  Visibility(
                    visible: controller.tickets?.fire_station_name!=null,
                    child:  Obx(() => MyText(
                        title:"Fire truck is on the way from ${controller.name.value}")),),
                  Obx(() => MyText(
                      title:"Distance: ${controller.distance.value}")),
                  Obx(() => MyText(
                      title: "Estimate Time: ${controller.eta.value}.")),
                  Visibility(
                    visible:controller.tickets?.attend_id!=null ,
                    child:MyText(
                        title: "Officer: ${controller.tickets?.officer_name} on his way."),
                  ),
                  Visibility(
                    visible: controller.tickets!=null && controller.tickets?.completed==false,
                    child: CustomButton(
                        height: 5.9.h,
                        text: "Cancel",
                        onPress: (){
                          controller.showCustomInputDialog(context);
                        },
                        textColor: AppColors.kWhite,
                        boxColor: AppColors.primary).paddingOnly(top: 0.5.h),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
