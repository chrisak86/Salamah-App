import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/shared_widgets/Text.dart';

import '../controllers/requests_controller.dart';

class RequestsView extends GetView<RequestsController> {
  const RequestsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestsController>(
      init: RequestsController(),
      builder: (controller) {
        return Obx(()=>Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const MyText(title:  "Requests",),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Switch(
                    value: controller.isOnline.value,
                    onChanged: (value) {
                      controller.isOnline.value=value;
                      controller.updateOnlineStatus(value);
                    },
                    activeColor: Colors.blue,
                  ),
                ).paddingOnly(right: 24),
                Expanded(
                  child: controller.isOnline.isFalse ?
                      const Center(child: MyText(title: "You are offline",),)
                  :Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: AppColors.primary,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText(title: "2024-07-14   20:08",clr: AppColors.kWhite,),
                                      SizedBox(height: 8),
                                      MyText(title:"Police",clr: AppColors.kWhite,),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const MyText(title: "2.3 km away",clr: AppColors.black,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    );
  }
}
