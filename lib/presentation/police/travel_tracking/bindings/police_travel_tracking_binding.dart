import 'package:get/get.dart';
import 'package:salamah/presentation/police/travel_tracking/controllers/police_travel_tracking_controller.dart';


class PoliceTravelTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PoliceTravelTrackingController>(
      () => PoliceTravelTrackingController(),
    );
  }
}
