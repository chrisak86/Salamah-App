
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_colors.dart';

class AppTextStyles {
  static  TextStyle headingExtraLarge = TextStyle(
  fontSize: 26.sp,
  fontFamily: 'Urbanist-800',
  color: AppColors.primary,
      overflow: TextOverflow.ellipsis
  );
  static  TextStyle primaryClrHeading = TextStyle(
  fontSize: 15.sp,
  fontFamily: 'Urbanist-600',
  fontWeight: FontWeight.w600,
  color: AppColors.primary, overflow: TextOverflow.ellipsis
  );
  static  TextStyle heading = TextStyle(
  fontSize: 17.sp,
  fontFamily: 'Urbanist-600',
  color: AppColors.black,
      overflow: TextOverflow.ellipsis
  );

  static  TextStyle semiBold = TextStyle(
    fontSize: 11.sp,
    fontFamily: 'Urbanist-600',
    color: AppColors.black,
      overflow: TextOverflow.ellipsis
  );

  static const TextStyle bodyText = TextStyle(
  fontSize: 16,
  fontFamily: 'Urbanist-400',
  color: AppColors.kWhite, overflow: TextOverflow.ellipsis
  );
  static const TextStyle bodyTextBold = TextStyle(
  fontSize: 16,
  fontFamily: 'Urbanist-500',
  color: AppColors.black,
      overflow: TextOverflow.ellipsis
  );
  static  TextStyle mediumHeading = TextStyle(
  fontSize: 16.sp,
  fontFamily: 'Urbanist-500',
  color: AppColors.black,
    overflow: TextOverflow.ellipsis
  );
  static  TextStyle twentySemiBoldText = TextStyle(
  fontSize: 15.sp,
  fontFamily: 'Urbanist-600',
  color: AppColors.black,
      overflow: TextOverflow.ellipsis,
  );
  static  TextStyle twentyNormalText = TextStyle(
  fontSize: 15.sp,
  fontFamily: 'Urbanist-400',
  color: AppColors.black,
      overflow: TextOverflow.ellipsis
  );
  static  TextStyle normalText =const TextStyle(
  fontSize: 14,
  fontFamily: 'Urbanist-400',
  color: AppColors.black,
      overflow: TextOverflow.ellipsis
  );


}