import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/shared_widgets/custom_dilague.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class RegisterController extends GetxController {


  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  RxBool showPassword=true.obs,isPolice=false.obs,isMale=true.obs,isFemale=false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }


  userAlreadyExist() async {
    showDialog<void>(
        context: Get.context!,
        builder: (BuildContext context) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomDialog(
                title: "This user already exist",
                message: "Please login account.",
              ),
            ],
          );
        });
  }

  successDialgue() async {
    showDialog<void>(
        context: Get.context!,
        builder: (BuildContext context) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomDialog(
                title: "Congratulation",
                message: "A Verification email has been sent to your Email.",
              ),
            ],
          );
        });
  }

  Future<void> signUp() async {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: Get.context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password:  passwordController.text,
      );
      if(isPolice.isTrue){
        await fireStore.collection('police').doc(userCredential.user!.uid).set({
          'user_id':userCredential.user!.uid,
          'name': firstNameController.text,
          'civilId': lastNameController.text,
          'email': emailController.text,
          "gender": isFemale.isTrue ? "FEMALE" : "MALE",
          "type":"POLICE",
          "isOnline" :false,
          "isApproved":false
        });
      }
      else{
        await fireStore.collection('users').doc(userCredential.user!.uid).set({
          'user_id':userCredential.user!.uid,
          'name': firstNameController.text,
          'civilId': lastNameController.text,
          'email': emailController.text,
          "gender": isFemale.isTrue ? "FEMALE" : "MALE",
          "type": "USER"
        });
      }
      await userCredential.user!.sendEmailVerification();
      dialog.hide();
      successDialgue();
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        dialog.hide();
        userAlreadyExist();
      } else{
        dialog.hide();
        Utils.showToast(message: e.code);
      }
    }finally{
      dialog.hide();
    }
  }

}
