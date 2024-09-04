//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// class CountryPickerField extends StatelessWidget {
//  final TextEditingController phoneController;
//  final Function(String)? dialCode;
//  final Function(IntPhoneNumber)? onInputChanged;
//  final Future<String?> Function() loadJson;
//  final bool? checkValidate;
//  final double? height;
//  final String? Function(IntPhoneNumber)? validator;
//   final bool? error;
//
//    const CountryPickerField({super.key,this.validator,this.onInputChanged,this.checkValidate=true,this.dialCode,this.height,this.error=false,required this.phoneController, required this.loadJson});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  Container(
//       decoration:  BoxDecoration(
//           color: AppColors.trans,
//           borderRadius: BorderRadius.circular(8)
//       ),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           InternationalPhoneNumberInput(
//             height:height?? 60,
//             controller: phoneController,
//             validator: validator,
//             inputFormatters: const [],
//              initCountry: CountryCodeModel( name: "United State", dial_code: "(+1)", code: "US"),
//             betweenPadding: 0,
//             onInputChanged: onInputChanged,
//             loadFromJson: loadJson,
//             formatter: MaskedInputFormatter('###############'),
//             dialogConfig: DialogConfig(
//               backgroundColor:  AppColors.white,
//               searchBoxBackgroundColor:AppColors.white,
//               searchBoxIconColor:const Color(0xFF56565a),
//               countryItemHeight: 55,
//               flatFlag: true,
//               topBarColor: const Color(0xFF1B1C24),
//               selectedItemColor:  AppColors.white,
//               textStyle: AppTextStyles.bodyTextBold,
//               searchBoxTextStyle:AppTextStyles.bodyTextBold ,
//               titleStyle: AppTextStyles.twentyNormalText,
//               searchBoxHintStyle: AppTextStyles.hintText,
//             ),
//             countryConfig: CountryConfig(
//                 decoration:const BoxDecoration(
//                   color: AppColors.trans,
//                   border: Border(left: BorderSide( color: AppColors.white)
//                       ,right: BorderSide( color: AppColors.white)
//                       ,top: BorderSide( color: AppColors.white),bottom:BorderSide( color: AppColors.white)),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     bottomLeft: Radius.circular(10),
//                   ),
//                 ),
//                 flatFlag: true,
//                 noFlag: false,
//                 textStyle: AppTextStyles.bodyTextBold.copyWith(color: AppColors.grey.withOpacity(0.50))),
//             phoneConfig: PhoneConfig(
//
//               focusedColor: AppColors.trans,
//               enabledColor:  AppColors.trans,
//               errorColor: Colors.transparent,
//               floatingLabelStyle: null,
//               focusNode: null,
//               radius: 8,
//               hintText: error==true ? "Enter Phone Number" : "Phone Number".tr,
//               backgroundColor:  AppColors.trans,
//               popUpErrorText: true,
//               decoration:const BoxDecoration(
//                 border: Border(bottom: BorderSide(
//                     color: AppColors.white),right: BorderSide( color: AppColors.white),top: BorderSide( color: AppColors.white),left: BorderSide.none),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(10),
//                   bottomRight: Radius.circular(10),
//                 ),
//               ),
//               autoFocus: false,
//               showCursor: true,
//               textInputAction: TextInputAction.done,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               errorTextMaxLength: 2,
//               errorStyle: const TextStyle(
//                   color: Colors.red,
//                   fontSize: 12, height: 1),
//               textStyle: AppTextStyles.bodyTextBold.copyWith(color: AppColors.grey.withOpacity(0.50)),
//               hintStyle: AppTextStyles.hintText.copyWith(color: error==true ? AppColors.red : AppColors.hintColor ),
//             ),
//           ),
//           // Positioned(
//           //   left: 16.w,
//           //   child: Container(
//           //     height: 33,
//           //     width: 1.5,
//           //     color: AppColors.white,
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
// }
