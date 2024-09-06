import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/config/app_font.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/app/shared_widgets/custom_button.dart';
import 'package:salamah/app/shared_widgets/header.dart';
import 'package:salamah/app/shared_widgets/text_field.dart';
import 'package:sizer/sizer.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (context) {
          return Obx(() => Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  backgroundBox(back: false,title: "Login"),
                  Form(
                      key: controller.formKey,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 58.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 2.h,),
                                MyText(
                                  title: "Email Address",
                                  size: 10.5.sp,
                                  weight: FontWeight.w500,
                                  family: AppFonts.urban700,
                                ).paddingOnly(top: 2.9.h),
                                InputTextField(
                                    validation: (v)=>GetUtils.isEmail(v!)?null:"Enter a valid email",
                                    hint: "Email Address",
                                    controller: controller.emailController).paddingOnly(top: 0.8.h),
                                MyText(
                                  title: "Password",
                                  clr: AppColors.textFieldLabel,
                                  size: 10.5.sp,
                                  weight: FontWeight.w500,
                                  family: AppFonts.urban700,
                                ).paddingOnly(top: 0.9.h),
                                PasswordTextField(
                                    validation: (v)=>v!.isNotEmpty?null:"Enter Password",
                                    hint: "Password",
                                    isObscure: controller.showPassword.value,
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          controller.showPassword.value =
                                          !controller.showPassword.value;
                                        },
                                        child: Icon(controller.showPassword.value
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    controller: controller.passwordController).paddingOnly(top: 0.8.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: controller.isPolice.value,
                                          onChanged: ( value) {
                                            controller.isPolice.value=value!;
                                          },
                                        ),
                                        MyText(
                                          title: "Signing as Police",
                                          clr: AppColors.textFieldLabel,
                                          size: 9.sp,
                                          weight: FontWeight.w500,
                                          family: AppFonts.urban700,
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Get.toNamed(Routes.FORGOT_PASSWORD);
                                      },
                                      child: MyText(
                                        title: "Forget Password?",
                                        clr: AppColors.primary,
                                        size: 10.5.sp,
                                        weight: FontWeight.w500,
                                        family: AppFonts.urban700,
                                      ),
                                    )
              
                                  ],
                                ),
                                CustomButton(
                                    height: 5.9.h,
                                    text: "Login",
                                    onPress: (){
                                      if (controller.formKey.currentState!.validate()) {
                                        controller.login();
                                      }
                                    },
                                    textColor: AppColors.black,
                                    boxColor: AppColors.secondary).paddingOnly(top: 16.h),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                title: "Don’t have an account? ",
                                clr: AppColors.lightGrey,
                                size: 10.5.sp,
                                weight: FontWeight.w700,
                                family: AppFonts.urban700,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(Routes.REGISTER);
                                },
                                child: MyText(
                                  title: "SignUp",
                                  clr: AppColors.primary,
                                  size: 10.5.sp,
                                  weight: FontWeight.w700,
                                  family: AppFonts.urban700,
                                ),
                              ),
                            ],
                          ).paddingOnly(top: 3.h),
                        ],
                      )).paddingOnly(left: 24, right: 24),
                ],
              ),
            ),
          ));
        });
  }
}
