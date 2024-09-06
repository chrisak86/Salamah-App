import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebLoginController extends GetxController {

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }


}
