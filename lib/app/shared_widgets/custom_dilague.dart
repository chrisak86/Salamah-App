import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/config/app_font.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/app/shared_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  const CustomDialog({super.key,required this.title,required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: AppColors.kWhite,
        surfaceTintColor: AppColors.kWhite,
        contentPadding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: 327,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(title: title,
                  family: AppFonts.urban700,size: 10.7.sp,clr: AppColors.black,letterSpacing: 0.5).paddingOnly(top: 12),
              MyText(title: message,
                family: AppFonts.urban700,size: 10.7,clr: AppColors.lightGrey,letterSpacing: 0.5,).paddingOnly(top: 12),
              CustomButton(
                height: 36,
                width: 90,
                text: "OK",
                textColor: AppColors.kWhite,
                onPress: () async {
                  Get.back();
                },
                boxColor: AppColors.secondary,
              ).paddingOnly(top: 15),
            ],
          ),
        ));
  }
}