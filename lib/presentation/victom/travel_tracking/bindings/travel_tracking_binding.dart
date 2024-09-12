import 'package:get/get.dart';
import 'package:salamah/presentation/victom/travel_tracking/controllers/travel_tracking_controller.dart';


class TravelTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelTrackingController>(
      () => TravelTrackingController(),
    );
  }
}
