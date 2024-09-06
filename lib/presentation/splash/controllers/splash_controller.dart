import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/global_var.dart';
import 'package:salamah/app/config/local_keys.dart';
import 'package:salamah/app/models/user.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/data/provider/local_storage/local_db.dart';
import 'package:salamah/presentation/police/requests/views/pending.dart';

class SplashController extends GetxController {
  final StreamController<DocumentSnapshot> streamController = StreamController<DocumentSnapshot>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool loading=true.obs;

  @override
  void onInit()async {
    Globals.loggedIn = await LocalDB.getData(LocalDataKey.loggedIn.name) ?? false;
    Globals.userData = await LocalDB.getData(LocalDataKey.userData.name) ?? null;
    Globals.userId = await LocalDB.getData(LocalDataKey.userId.name) ?? null;
    Globals.userProfile=Globals.userData!=null ? UserProfile.fromJson(jsonDecode(Globals.userData.toString())) : null;
    if(Globals.loggedIn){
      if(Globals.userProfile?.type=="USER") {
        Future.delayed(const Duration(seconds: 2)).then((value) {
          Get.offAllNamed(Routes.LANDING);
        });
      }else{
        await  fetchDataById(Globals.userProfile!.user_id!);
        if(Globals.userProfile?.type=="POLICE" && Globals.userProfile?.isApproved==true) {
          Future.delayed(const Duration(seconds: 2)).then((value) {
            Get.offAllNamed(Routes.REQUESTS);
          });
        }else{
          Get.to(const Pending());
        }
      }
    }else{
      Future.delayed(const Duration(seconds: 10)).then((value) => Get.offAllNamed(Routes.LOGIN));
    }
    super.onInit();
  }

   fetchDataById(String id) {
    firestore.collection('police').doc(id).snapshots().listen(
          (documentSnapshot) {
        if (documentSnapshot.exists) {
          LocalDB.setData(LocalDataKey.userData.name, jsonEncode( UserProfile.fromJson(documentSnapshot.data()!).toJson()));
          streamController.add(documentSnapshot);
        } else {
          streamController.addError("Document does not exist");
        }
      },
      onError: (error) {
        streamController.addError("Error fetching document: $error");
      },
    );
  }

}
