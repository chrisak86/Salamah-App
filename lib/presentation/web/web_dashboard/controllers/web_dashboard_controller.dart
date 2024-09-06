import 'package:get/get.dart';

class WebDashboardController extends GetxController {

  RxInt selectedIndex = 0.obs;
  var fireStations = [
    {'name': 'Medicare', 'address': 'New York Street #201', 'status': true.obs},
    {'name': 'Medicare', 'address': 'New York Street #202', 'status': false.obs},
    {'name': 'Medicare', 'address': 'New York Street #203', 'status': true.obs},
    {'name': 'Medicare', 'address': 'New York Street #204', 'status': false.obs},
    {'name': 'Medicare', 'address': 'New York Street #205', 'status': true.obs},
    {'name': 'Medicare', 'address': 'New York Street #206', 'status': false.obs},
  ].obs;


  @override
  void onInit() {
    super.onInit();
  }
  void toggleStatus(int index) {
    fireStations[index]['status'] = fireStations[index]['status'] == true ? false : true;
    update();
  }

}
