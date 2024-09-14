import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/global_var.dart';
import 'package:salamah/app/models/tickets.dart';
import 'package:salamah/app/models/police_officer.dart';
import 'package:salamah/app/models/user.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:salamah/data/repositories/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestsController extends GetxController {

  RequestRepository requestRepository=RequestRepository();
  RxBool isOnline = true.obs;
  RxList<Tickets> ticketsList = <Tickets>[].obs;
  PoliceOfficer? currentOfficer;

  @override
  void onInit() async{
    super.onInit();
    await fetchTicketsStream();
  }


  // Stream to fetch tickets assigned to the police stations of the officer
  Future fetchTicketsStream() async{
    ticketsList.clear();
    var response;
    response = await requestRepository.getPoliceOfficerTicket();
    if (response != null && response['success']==true) {
      var data = response['data'] as List;
      if(data!=[]){
        ticketsList.addAll(data.map((e) => Tickets.fromJson(e)).toList());
      }
      update();
    }else if(response != null && response['success']==false &&response['message']=='Invalid page.' ){
      update();
    }
  }
  Future<void> updateOnlineStatus(value) async {
    isOnline.value=value;
    var response;
    try {
      response = await requestRepository.onlineStatus(email:Globals.userProfile?.email,status: isOnline.value);
      if (response != null && response['status']==true) {
        Globals.userProfile=UserProfile.fromJson(response['data']);
        if(Globals.userProfile?.isOnline==true){
         await  fetchTicketsStream();
        }
        update();
      }else if(response != null && response['status']==false ){
        update();
      }else{
        update();
      }
    } on Exception catch (e) {
      Get.log('Sign Up ${e.toString()}');
    }
  }

  Future<void> attendEmergency(Tickets tickets) async {
    var response;
    try {
      response = await requestRepository.attendTicket(id: tickets.id);
      if (response != null && response['success']==true) {
        ticketsList.clear();
        ticketsList.add(Tickets.fromJson(response["data"]));
        Get.toNamed(Routes.POLICE_TRAVEL,arguments:ticketsList.elementAt(0));
        update();
      }else if(response != null && response['success']==false ){
        update();
      }else{
        update();
      }
    } on Exception catch (e) {
      Get.log('Sign Up ${e.toString()}');
    }
  }



  void logout() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAndToNamed(Routes.LOGIN);
  }

   showDeleteAccountDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const MyText(title: "Delete Account"),
          content: const MyText(title: "Are you sure you want to delete your account?"),
          actions: [
            TextButton(
              child: const MyText(title: "Cancel"),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const MyText(title: "Delete"),
              onPressed: () {
                deleteStation();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteStation() async {
    var response;
    try {
      response = await requestRepository.unAssignPoliceStation(id:Globals.userProfile?.user_id);
      if (response['success']==true) {
        logout();
        Utils.showToast(message: "You are account has been deleted.");
      }else if(response != null && response['status']==false ){
        update();
      }else{
        update();
      }
    } on Exception catch (e) {
      Get.log('Sign Up ${e.toString()}');
    }
  }


}
