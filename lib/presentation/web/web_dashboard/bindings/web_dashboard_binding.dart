import 'package:get/get.dart';

import '../controllers/web_dashboard_controller.dart';

class WebDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebDashboardController>(
      () => WebDashboardController(),
    );
  }
}
