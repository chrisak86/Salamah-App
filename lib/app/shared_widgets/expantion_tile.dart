
import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final ExpansionTileController ctrl;
  final List<Widget> children;

 const CustomExpansionTile({super.key, required this.title, required this.children, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: ctrl,
      // initiallyExpanded: false,
      title: Text(title,style: AppTextStyles.hintText,),
      backgroundColor: AppColors.greyLight.withOpacity(0.50),
    collapsedBackgroundColor: AppColors.greyLight.withOpacity(0.50),
      visualDensity: VisualDensity.comfortable,
      iconColor: AppColors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ) ,
      children: children,
    );
  }
}