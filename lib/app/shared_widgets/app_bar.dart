import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../routes/app_pages.dart';
import '../utils/utils.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? trailing;
  final VoidCallback? onLeadingPressed;

  const AppBarCustom({
    super.key,
    required this.title,
    this.onLeadingPressed, this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.trans,
      systemOverlayStyle:const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ) ,
      title: Text(
        title,
        style: AppTextStyles.heading,
      ),
      automaticallyImplyLeading: false,
      leading: IconButton(
        color: AppColors.white,
        onPressed: () {
          Get.back();
        }, // Call the callback function here
        icon: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.white.withOpacity(0.15),
                blurRadius: 32,
                spreadRadius: 0,
                offset: Offset(6, 5),
              ),
            ],
          ),
          child: Icon(
            CupertinoIcons.back,
            color: AppColors.black,
          ),
        ),
      ),
      actions:trailing==null?null: [
        IconButton(
          color: AppColors.white,
          onPressed: () {
            // Get.toNamed(Routes.NOTIFICATIONS);
          },
          icon: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.black
                            .withOpacity(0.15),
                        blurRadius: 32,
                        spreadRadius: 0,
                        offset: const Offset(6, 5))
                  ]),
              child: Image.asset(Utils.getIconPath('Bell'),scale: 4.0,)),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
