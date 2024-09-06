import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:sizer/sizer.dart';

class Pending extends StatelessWidget {
  const Pending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
          onWillPop: ()async => false,
          child:Scaffold(
            body: Column(
              children: [
                Container(
                    height: 27.h,
                    width: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(Utils.getImagePath('approval_pending')),fit: BoxFit.contain)
                    )).paddingOnly(top:20.h),
                Center(
                  child: MyText(title: "Your application is under review".tr,weight: FontWeight.w600,size: 15.sp,clr: AppColors.primary,textAlign: TextAlign.center,),
                ).paddingOnly(top: 6.h),
                Center(
                  child: MyText(title: "It may take up to some time for the approval of your Application you will get the confirmation via SMS after approval".tr,
                    weight: FontWeight.w400,size: 9.sp,textAlign: TextAlign.center,),
                ).paddingOnly(top: 1.h),
              ],
            ).paddingOnly(left: 24,right: 24),
          )),
    );
  }
}
