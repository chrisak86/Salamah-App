import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/web_login_controller.dart';

class WebLoginView extends GetView<WebLoginController> {
  const WebLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebLoginView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WebLoginView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
