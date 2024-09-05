import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (_) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Utils.getImagePath('background')),fit: BoxFit.cover)
                  ),
                  child: Center(child:Image.asset(Utils.getIconPath("salamah"),width: 44.2.w,height: 11.2.h,) )),
            ),
          );
        }
    );
  }
}
