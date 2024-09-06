import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:salamah/app/config/global_var.dart';

class RequestsController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isOnline=false.obs;

  @override
  void onInit() {
    isOnline.value= Globals.userProfile?.isOnline ?? false;
    super.onInit();
  }


  void updateOnlineStatus(bool newValue) {
    firestore.collection('police').doc(Globals.userProfile?.user_id!).update({"isOnline": newValue}).then((_) {
    }).catchError((error) {
      isOnline.value=!newValue;
    });
  }

}
