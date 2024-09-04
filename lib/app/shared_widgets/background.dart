
import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../utils/utils.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final ImageProvider? img;
  const BackgroundWidget({super.key, required this.child, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
            image: DecorationImage(image: AssetImage(Utils.getImagePath('background')), fit: BoxFit.fill)),
        child: child,
        );
   }
}