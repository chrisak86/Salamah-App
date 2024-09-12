import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/app_colors.dart';


class Utils {
  static String getImagePath(String name, {String format= 'png'}) {
    return 'assets/images/$name.$format';
  }
  static String getIconPath(String name, {String format= 'png'}) {
    return 'assets/icons/$name.$format';
  }
  static String getSvgPath(String name, {String format= 'svg'}) {
    return 'assets/svgIcons/$name.$format';
  }
  static bool validateEmail(String value) {
    String pattern= r'^[a-zA-Z0-9][a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
  static String? getTableByNumber(String tableNumber) {
    switch(tableNumber){
      case "1":
        return 'assets/svgs/four-capacity.svg';
      case "2":
        return 'assets/svgs/two-capacity.svg';
      case "3":
        return 'assets/svgs/four-capacity.svg';
      case "4":
        return 'assets/svgs/six-capacity-h.svg';
      case "5":
        return 'assets/svgs/four-capacity.svg';
      case "6":
        return 'assets/svgs/four-capacity.svg';
      case "7":
        return 'assets/svgs/six-capacity-v.svg';
      case "8":
        return 'assets/svgs/two-capacity.svg';
      case "9":
        return 'assets/svgs/six-capacity-v.svg';
    }
  }
  static String getProfilePath(String name, {String format= 'png'}) {
    return 'assets/icons/profile_icons/$name.$format';
  }
  static showToast({ required String message,int time=2}) {
    Fluttertoast.showToast(
        msg: message,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.primary,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG);
  }


  static bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }




 // static bool validatePhoneNumber(String phoneNumber, String isoCode)  {
 //    try {
 //      bool isValid = CountryUtils.validatePhoneNumber(phoneNumber.replaceAll(' ', ''), isoCode);
 //      return isValid;
 //    } catch (e) {
 //      return false;
 //    }
 //  }



  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<bool> getPermissionStatus({Permission permission=Permission.photos }) async {
    var status = await permission.status;
    print(status.isDenied);

    if (status.isGranted) {
      return true;

      // onNewCameraSelected(cameras[0]);
      // refreshAlreadyCapturedImages();
    } else if(status.isDenied) {
      await permission.request();
      status = await permission.status;
      if(status.isGranted){
        return true;}else{
        return false;
      }
    }else{
      await openAppSettings();
      status = await permission.status;
      if(status.isGranted){
        return true;

      }else {
        return false;
      }
    }
    return false;
  }
  static String getDay(DateTime createdAt) {
    //DateTime currentDate = DateTime.now();
    final today = DateTime.now().subtract(const Duration(days: 0));
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final thisWeek7 = DateTime.now().subtract(const Duration(days: 7));
    final thisWeek6 = DateTime.now().subtract(const Duration(days: 6));
    final thisWeek5 = DateTime.now().subtract(const Duration(days: 5));
    final thisWeek4 = DateTime.now().subtract(const Duration(days: 4));
    final thisWeek3 = DateTime.now().subtract(const Duration(days: 3));
    final thisWeek2 = DateTime.now().subtract(const Duration(days: 2));

    if (today.day == createdAt.day) {
      return "Today";
    }

    // else if ((currentDate.day - createdAt.day <= 1) || (currentDate.day - createdAt.day == -29)  || (currentDate.day - createdAt.day == -30) || (currentDate.day - createdAt.day == -27)) {
    //   return "Yesterday";
    // }

    else if (yesterday.day == createdAt.day) {
      return "Yesterday";
    }
    // else if (currentDate.day - createdAt.day == 7 ||
    //     currentDate.day - createdAt.day < 0) {
    //   return "This Week";
    // }
    else if (thisWeek7.day == createdAt.day) {
      return "This Week";
    } else if (thisWeek6.day == createdAt.day) {
      return "This Week";
    } else if (thisWeek5.day == createdAt.day) {
      return "This Week";
    } else if (thisWeek4.day == createdAt.day) {
      return "This Week";
    } else if (thisWeek3.day == createdAt.day) {
      return "This Week";
    } else if (thisWeek2.day == createdAt.day) {
      return "This Week";
    }
    // else if (currentDate.day - createdAt.day > 7 &&
    //     currentDate.month - createdAt.month >= 1) {
    //   return "Earlier";
    // }
    return "Earlier";
  }

  // static Future<String> getFileUrl(String fileName) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return "${directory.path}/$fileName";
  // }
}