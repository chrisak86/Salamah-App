import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/config/global_var.dart';
import 'package:salamah/app/config/local_keys.dart';
import 'package:salamah/app/models/user.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/shared_widgets/custom_dilague.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:salamah/data/provider/local_storage/local_db.dart';
import 'package:salamah/data/repositories/profile_repository.dart';
import 'package:salamah/presentation/police/requests/views/pending.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginController extends GetxController {
  final fireStore = FirebaseFirestore.instance;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  RequestRepository requestRepository =RequestRepository();
  RxBool showPassword=true.obs;
  RxBool isPolice=false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }


  userNotExist() async {
    showDialog<void>(
        context: Get.context!,
        builder: (BuildContext context) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomDialog(
                title: "This user does not exist",
                message: "Please create an account.",
              ),
            ],
          );
        });
  }

  login() async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: Get.context!);
    dialog.show(indicatorColor: AppColors.primary, message: 'Loading...', type: SimpleFontelicoProgressDialogType.normal);
    var response;
    try {
      response = await requestRepository.login(
          email: emailController.text.replaceAll(" ", ""),
          pass: passwordController.text
      );
      if (response != null && response['status']==true) {
        dialog.hide();
        Globals.userProfile=UserProfile.fromJson(response['data']);
        Globals.userId=Globals.userProfile?.user_id;
        Globals.authToken = response['auth'];
        await LocalDB.setData(LocalDataKey.userData.name, jsonEncode( Globals.userProfile?.toJson()));
        await LocalDB.setData(LocalDataKey.authToken.name, response['auth']);
        await LocalDB.setData(LocalDataKey.loggedIn.name, true);
        await LocalDB.setData(LocalDataKey.userId.name, Globals.userProfile?.user_id);
        if(Globals.userProfile?.type=="USER") {
          Get.offAllNamed(Routes.LANDING);
        }else if(Globals.userProfile?.isApproved==true && Globals.userProfile?.type=="POLICE" ){
          Get.offAllNamed(Routes.REQUESTS);
        }else if(Globals.userProfile?.isApproved==false && Globals.userProfile?.type=="POLICE" ){
          Get.to(const Pending());
        }
        update();
      }else if(response!= null && response['success']==false ){
        dialog.hide();
        Utils.showToast(message: response['message']);
        update();
      }else{
        dialog.hide();
        Utils.showToast(message: response['message']);
        update();
      }
    } on Exception catch (e) {
      dialog.hide();
      userNotExist();
      Get.log('Sign Up ${e.toString()}');
    }
  }

}
