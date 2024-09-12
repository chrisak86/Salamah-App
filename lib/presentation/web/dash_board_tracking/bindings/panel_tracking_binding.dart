import 'package:get/get.dart';
import 'package:salamah/presentation/police/travel_tracking/controllers/police_travel_tracking_controller.dart';
import 'package:salamah/presentation/web/dash_board_tracking/controllers/panel_tracking_controller.dart';


class PanelTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PanelTrackingController>(
      () => PanelTrackingController(),
    );
  }
}
