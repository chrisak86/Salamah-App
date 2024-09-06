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
import 'package:salamah/presentation/police/requests/views/pending.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginController extends GetxController {
  final fireStore = FirebaseFirestore.instance;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
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
    try {
      dialog.show(
          indicatorColor: AppColors.secondary,
          message: 'Loading...',
          type: SimpleFontelicoProgressDialogType.normal);
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      var document;
      if (isPolice.isFalse){
         document = await fireStore.collection('users').doc(userCredential.user!.uid).get();
      }else{
        document = await fireStore.collection('police').doc(userCredential.user!.uid).get();
      }
      User user = userCredential.user!;
      if (document.exists && isPolice.isFalse) {
        if (!user.emailVerified) {
          await userCredential.user!.sendEmailVerification();
          Utils.showToast(message: "Please verify your account by clicking the link in the verification email sent to your registered email address.");
          return ;
        }else{
          Globals.userId=userCredential.user!.uid;
          Globals.userProfile=UserProfile.fromJson(document.data()!);
          if(isPolice.isTrue) {
            await LocalDB.setData(LocalDataKey.userData.name, jsonEncode( UserProfile.fromJson(document.data()!).toJson()));
            await LocalDB.setData(LocalDataKey.loggedIn.name, true);
            await LocalDB.setData(LocalDataKey.userId.name, userCredential.user!.uid);
          }
          Get.offAllNamed(Routes.LANDING);
        }
        return "true";
      } else if (document.exists && isPolice.isTrue) {
        if (!user.emailVerified) {
          await userCredential.user!.sendEmailVerification();
          Utils.showToast(message: "Please verify your account by clicking the link in the verification email sent to your registered email address.");
          return ;
        }else{
          Globals.userId=userCredential.user!.uid;
          Globals.userProfile=UserProfile.fromJson(document.data()!);
          if(isPolice.isTrue) {
            await LocalDB.setData(LocalDataKey.userData.name, jsonEncode( UserProfile.fromJson(document.data()!).toJson()));
            await LocalDB.setData(LocalDataKey.loggedIn.name, true);
            await LocalDB.setData(LocalDataKey.userId.name, userCredential.user!.uid);
          }
          if(Globals.userProfile?.isApproved==true){
            Get.offAllNamed(Routes.REQUESTS);
          }else{
            Get.to(const Pending());
          }
        }
        return "true";
      }else{
        userNotExist();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        dialog.hide();
        userNotExist();
      } else if (e.code == 'wrong-password') {
        dialog.hide();
        Utils.showToast(message: "Please enter valid password.");
        return 'wrongPassword';
      } else if (e.code == 'invalid-email') {
        dialog.hide();
        Utils.showToast(message: "Please enter valid email.");
        return 'invalid-email';
      } else {
        dialog.hide();
        Utils.showToast(message: "Please Check your credentials");
        return 'false';
      }
    }
  }
}
