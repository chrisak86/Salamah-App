
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/config/app_font.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onPress;
  final double? height;
  final double? width;
  final Color textColor;
  final Color boxColor;
  const CustomButton({super.key,this.width,this.height ,required this.text, required this.onPress, required this.textColor, required this.boxColor});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onPress,
      child: Container(
        width:widget.width ?? double.infinity,
        height:widget.height ?? Get.height/14.5,
        decoration: BoxDecoration(
          color: widget.boxColor,
          border: Border.all(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(widget.text,
            style: TextStyle(fontWeight:FontWeight.bold,fontSize:10.sp,color: widget.textColor,fontFamily: AppFonts.urban700))),
      ),
    );
  }
}