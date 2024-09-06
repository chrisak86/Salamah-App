import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:sizer/sizer.dart';

Widget backgroundBox({bool? back,String? title}){
  bool hasBack = back ?? true;
  return  Stack(
    children: [
      Image.asset(Utils.getImagePath('header'),width: double.infinity,),
      if(hasBack)
        Positioned(
          top: 30,
          left: 20,
          child: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppColors.lightGrey),
              child: const Icon(Icons.arrow_back_ios_new_rounded,size: 15),
            ),
          ),
        ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child:   Image.asset(Utils.getIconPath('salamah'),scale: 4,),
          ).paddingOnly(top: 3.h),
         if(title != null)
               MyText(title: title,size: 15.sp,clr: AppColors.kWhite,)
        ],
      )
    ],
  );
}