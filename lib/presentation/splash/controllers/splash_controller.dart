import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:salamah/app/config/global_var.dart';
import 'package:salamah/app/config/local_keys.dart';
import 'package:salamah/app/models/tickets.dart';
import 'package:salamah/app/models/user.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:salamah/data/provider/local_storage/local_db.dart';
import 'package:salamah/data/repositories/profile_repository.dart';
import 'package:salamah/presentation/police/requests/views/pending.dart';

class SplashController extends GetxController {
  RxBool loading=true.obs;
  RequestRepository requestRepository =RequestRepository();

  @override
  void onInit()async {
    Globals.authToken = await LocalDB.getData(LocalDataKey.authToken.name) ?? '';
    Globals.loggedIn = await LocalDB.getData(LocalDataKey.loggedIn.name) ?? false;
    Globals.userData = await LocalDB.getData(LocalDataKey.userData.name) ?? null;
    Globals.userProfile=Globals.userData!=null ? UserProfile.fromJson(jsonDecode(Globals.userData.toString())) : null;
    Globals.userId = Globals.userProfile?.user_id;
    if(Globals.authToken!=''){
      await getUser();
    }else{
      Future.delayed(const Duration(seconds: 10)).then((value) => Get.offAllNamed(Routes.LOGIN));
    }
    super.onInit();
  }

  Future<void> getUser() async {
    Map<String, dynamic>? response;
    try {
      response = await requestRepository.getUser();
      if (response != null && response['success'] == true) {
        Globals.userProfile=UserProfile.fromJson(response['data']);
        Globals.userId=Globals.userProfile?.user_id;
        await LocalDB.setData(LocalDataKey.userData.name, jsonEncode( Globals.userProfile?.toJson()));
        await LocalDB.setData(LocalDataKey.loggedIn.name, true);
        await LocalDB.setData(LocalDataKey.userId.name, Globals.userProfile?.user_id);
        if(Globals.userProfile?.type=="USER") {
          fetchData();
        }else if(Globals.userProfile?.isApproved==true && Globals.userProfile?.type=="POLICE" ){
          Get.offAllNamed(Routes.REQUESTS);
        }else if(Globals.userProfile?.isApproved==false && Globals.userProfile?.type=="POLICE" ){
          Get.to(const Pending());
        }
        update();
      } else if (response != null && response['success'] == false) {
        Future.delayed(const Duration(seconds: 10)).then((value) => Get.offAllNamed(Routes.LOGIN));
        Utils.showToast(message: response['message']);
      }else{
        Future.delayed(const Duration(seconds: 10)).then((value) => Get.offAllNamed(Routes.LOGIN));

        Utils.showToast(message: "Please try Again Later".tr);
      }
    } on Exception catch (e) {
      Future.delayed(const Duration(seconds: 10)).then((value) => Get.offAllNamed(Routes.LOGIN));
      Get.log('AuthenticationController.signUp ${e.toString()}');
    }

  }

  Future<void> fetchData() async {
    var response;
    try {
      response = await requestRepository.getUserTicket(type: "ACCIDENT");

      if (response != null && response["data"] != null && (response["data"] as List).isEmpty) {
        Get.offAllNamed(Routes.LANDING);
        update();
      } else {
        List<Tickets> ticketsList = (response["data"] as List).map((ticket) => Tickets.fromJson(ticket)).toList();
        ticketsList.removeWhere((ticket) => ticket.completed == true ||  ticket.cancel==true);

        if (ticketsList.isNotEmpty) {
          Get.toNamed(Routes.TRAVEL,arguments: 1);
          update();
        } else {
          Get.offAllNamed(Routes.LANDING);
          update();
        }
      }
    } catch (e) {
      Get.offAllNamed(Routes.LANDING);
      print('Error fetching data: $e');
    }
  }


}
