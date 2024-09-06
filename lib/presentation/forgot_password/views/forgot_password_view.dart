import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/config/app_font.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/app/shared_widgets/custom_button.dart';
import 'package:salamah/app/shared_widgets/header.dart';
import 'package:salamah/app/shared_widgets/text_field.dart';
import 'package:sizer/sizer.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.loginBack,
            body:SafeArea(
              child: Column(
                children: [
                  backgroundBox(back: true,),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyText(
                          title: "Forget Password",
                          clr: AppColors.black,
                          size: 16.sp,
                          weight: FontWeight.w600,
                          family: AppFonts.urban700,
                        ).paddingOnly(top: 2.h),
                        MyText(
                          title: "Email Address",
                          clr: AppColors.textFieldLabel,
                          size: 10.5.sp,
                          weight: FontWeight.w500,
                          family: AppFonts.urban700,
                        ).paddingOnly(top: 2.h),
                        InputTextField(
                            validation: (v) => GetUtils.isEmail(v!)
                                ? null
                                : "Enter a valid email",
                            hint: "Email Address",
                            controller: controller.emailController).paddingOnly(top: 2.h),
                        CustomButton(
                            height: 5.9.h,
                            text: "Submit",
                            onPress: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.resetPassword();
                              }
                            },
                            textColor: AppColors.black,
                            boxColor: AppColors.secondary).paddingOnly(top: 4.h),
                      ],
                    ).paddingOnly(left: 24, right: 24),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
