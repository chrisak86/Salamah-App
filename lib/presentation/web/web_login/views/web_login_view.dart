import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../controllers/web_login_controller.dart';

class WebLoginView extends GetView<WebLoginController> {
  const WebLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebLoginController>(
        builder: (_) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Utils.getImagePath('web_background')),fit: BoxFit.fill)
                  ),
                  child:  Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Center(
                            child: Container(
                              width: constraints.maxWidth > 600 ? 400 : constraints.maxWidth * 0.9,
                              padding: EdgeInsets.all(24.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Form(
                                key: controller.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Image.asset(Utils.getIconPath("salamah_icon"),width: 15.w,height: 11.2.h),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'Please fill following information to procced further.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 5.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 1.5.h),
                                    TextFormField(
                                      controller: controller.emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email Address',
                                        hintText: 'xyz@gmail.com',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 1.5.h),
                                    TextFormField(
                                      controller: controller.passController,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        hintText: '********',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        } else if (value.length < 6) {
                                          return 'Password must be at least 6 characters long';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 2.h),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.yellow[600],
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                      ),
                                      onPressed: () {
                                        if (controller.formKey.currentState!.validate()) {
                                          if(controller.emailController.text=="salamah@gmail.com" &&
                                          controller.passController.text=="12345678"){
                                            Get.toNamed(Routes.WEB_DASHBOARD);
                                          } else {
                                            controller.showErrorMessage(context, 'Email and password do not match.');
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  )),
            ),
          );
        }
    );
  }
}
