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

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          return Obx(() => Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  backgroundBox(back: true,title: "Create an account"),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                              title: "Name",
                              clr: AppColors.textFieldLabel,
                              size: 10.5.sp,
                              weight: FontWeight.w500,
                              family: AppFonts.urban700,
                            ).paddingOnly(top: 1.h),
                            InputTextField(
                                validation: (v)=>v!.isNotEmpty?null:"Enter name",
                                hint: "Name",
                                controller: controller.firstNameController).paddingOnly(top: 0.8.h),
                            MyText(
                              title: "Civil Id",
                              clr: AppColors.textFieldLabel,
                              size: 10.5.sp,
                              weight: FontWeight.w500,
                              family: AppFonts.urban700,
                            ).paddingOnly(top: 0.8.h),
                            InputTextField(
                                validation: (v)=>v!.isNotEmpty?null:"Enter civil id",
                                hint: "Civil Id",
                                controller: controller.lastNameController).paddingOnly(top: 0.8.h),
                            MyText(
                              title: "Email Address",
                              clr: AppColors.textFieldLabel,
                              size: 10.5.sp,
                              weight: FontWeight.w500,
                              family: AppFonts.urban700,
                            ).paddingOnly(top: 0.8.h),
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
                            ).paddingOnly(top: 0.8.h),
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
                                controller: controller.passwordController).paddingOnly(top: 0.2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: controller.isPolice.isTrue,
                                      onChanged: ( value) {
                                        controller.isPolice.value=value!;
                                        controller.update();
                                      },
                                    ),
                                    MyText(
                                      title: "Sing up as Police",
                                      clr: AppColors.textFieldLabel,
                                      size: 9.sp,
                                      weight: FontWeight.w500,
                                      family: AppFonts.urban700,
                                    )
                                  ],
                                ),
                                Container()

                              ],
                            ).paddingOnly(top: 0.8.h),
                            Row(
                              children: [
                                Checkbox(
                                  value: controller.isMale.value,
                                  onChanged: (bool? value) {
                                    controller.isMale.value = value!;
                                    if (value) controller.isFemale.value = false;
                                  },
                                ),
                                const MyText(title:'Male'),
                                const SizedBox(width: 20),
                                Checkbox(
                                  value: controller.isFemale.value,
                                  onChanged: (bool? value) {
                                    controller.isFemale.value = value!;
                                    if (value) controller.isMale.value = false;
                                  },
                                ),
                                const MyText(title:'Female'),
                              ],
                            ).paddingOnly(top: 2.h),
                            CustomButton(
                                height: 5.9.h,
                                text: "Sign Up",
                                onPress: (){
                                  if (controller.formKey.currentState!.validate()) {
                                    controller.signUp();
                                  }
                                },
                                textColor: AppColors.kWhite,
                                boxColor: AppColors.secondary).paddingOnly(top: 5.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                  title: "Already have an account? ",
                                  clr: AppColors.lightGrey,
                                  size: 10.5.sp,
                                  weight: FontWeight.w700,
                                  family: AppFonts.urban700,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Get.offAndToNamed(Routes.LOGIN);
                                  },
                                  child: MyText(
                                    title: "Login",
                                    clr: AppColors.pinkColor,
                                    size: 10.5.sp,
                                    weight: FontWeight.w700,
                                    family: AppFonts.urban700,
                                  ),
                                ),
                              ],
                            ).paddingOnly(top: 5.h)
                          ],
                        ).paddingOnly(left: 24, right: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }
}
