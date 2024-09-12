import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/models/user.dart';
import 'package:salamah/app/shared_widgets/custom_dilague.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:salamah/data/repositories/profile_repository.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class RegisterController extends GetxController {


  RequestRepository requestRepository=RequestRepository();
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
    dialog.show(indicatorColor: AppColors.primary, message: 'Loading...', type: SimpleFontelicoProgressDialogType.normal);
    var response;
    try {
      response = await requestRepository.registerUser(
        UserProfile(
          name: firstNameController.text,
          civilId:  lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          gender: isFemale.isTrue ? "FEMALE" : "MALE",
          type: isPolice.isTrue ? "POLICE" : "USER",
          isApproved: false,
          isOnline: false
        )
      );
      if (response != null && response['status']==true) {
        dialog.hide();
        Utils.showToast(message: "User Created");
        Get.back();
        update();
      }else if(response != null && response['success']==false ){
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
      Get.log('Sign Up ${e.toString()}');
    }
  }

}
