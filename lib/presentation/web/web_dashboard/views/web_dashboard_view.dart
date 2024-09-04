import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/web_dashboard_controller.dart';

class WebDashboardView extends GetView<WebDashboardController> {
  const WebDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebDashboardView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WebDashboardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
