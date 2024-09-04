import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/app_colors.dart';


class Utils {
  static String getImagePath(String name, {String format= 'png'}) {
    return 'assets/pngImages/$name.$format';
  }
  static String getIconPath(String name, {String format= 'png'}) {
    return 'assets/pngs/$name.$format';
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

  static Future getImageFromGallery() async {
    final file = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (file != null) {
      File? returnFile = await refineImage(File(file.path));
      Get.log('${DateTime.now()} [RefineImage.getImageFromGallery] $returnFile');
      return returnFile;
    }
  }

  static Future getImageFromCamera() async {
    final pickedFile =
    await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File? returnFile = await refineImage(File(pickedFile.path));
      Get.log(
          '${DateTime.now()} [RefineImage.getImageFromGallery] $returnFile');
      return returnFile;
    }
  }


 // static bool validatePhoneNumber(String phoneNumber, String isoCode)  {
 //    try {
 //      bool isValid = CountryUtils.validatePhoneNumber(phoneNumber.replaceAll(' ', ''), isoCode);
 //      return isValid;
 //    } catch (e) {
 //      return false;
 //    }
 //  }



  static Future<File?> refineImage(File pickedFile) async {
    // final tempDir = await getTemporaryDirectory();

    File toCompress = pickedFile;

    print(toCompress.path);

    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: toCompress.path,aspectRatio: CropAspectRatio(ratioX: 9, ratioY: 16),
      // aspectRatioPresets: Platform.isAndroid
      //     ? [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9
      // ]
      //     : [
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio5x3,
      //   CropAspectRatioPreset.ratio5x4,
      //   CropAspectRatioPreset.ratio7x5,
      //   CropAspectRatioPreset.ratio16x9
      // ],
      uiSettings:[ AndroidUiSettings(
          toolbarTitle: 'Refine Image',
          toolbarColor: AppColors.secondary,
          toolbarWidgetColor:AppColors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          activeControlsWidgetColor: AppColors.secondary,
          backgroundColor: AppColors.secondary,
          statusBarColor: AppColors.secondary,
          lockAspectRatio: false), IOSUiSettings(
        title: 'Refine Image',

      )],
    );

    if (croppedFile != null) {
      pickedFile = File(croppedFile.path);
      return pickedFile;
    }else{
      return null;
    }
  }
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