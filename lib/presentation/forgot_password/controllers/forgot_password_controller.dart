import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/shared_widgets/custom_dilague.dart';
import 'package:salamah/app/utils/utils.dart';

class ForgotPasswordController extends GetxController {

  TextEditingController emailController=TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> resetPassword() async {
    try {
      await  FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      userNotExist();
    } catch (e) {
      print('Password reset failed: $e');
      Utils.showToast(message: "Please provide correct email");

    }
  }

  userNotExist() async {
    showDialog<void>(
        context: Get.context!,
        builder: (BuildContext context) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomDialog(
                title: "Email Link Sent",
                message: "Please check your email address to reset a password.",
              ),
            ],
          );
        });
  }

}
