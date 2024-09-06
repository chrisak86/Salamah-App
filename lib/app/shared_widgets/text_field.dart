import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/config/app_font.dart';
import 'package:sizer/sizer.dart';
class InputTextField extends StatefulWidget {
  final String? hint;
  final String? label;
  final String? errorText;
  final FocusNode? focusNode;
  final Icon? pre;
  final bool? fromLogin;
  final bool? errorEnabled;
  final int?   maxLines;
  final double? height;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String? Function(String?)? onchange;
  final String? Function(String?)? onSaved;
  const InputTextField( {super.key,this.maxLines,this.height ,this.errorText ,this.focusNode,this.fromLogin=false ,this.hint,  this.textInputType ,this.onSaved,  this.controller,this.label, this.validation, this.onchange, this.pre,this.errorEnabled=false});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType??  TextInputType.text,
      validator: widget.validation,
      onSaved: widget.onSaved,
      focusNode: widget.focusNode,
      onChanged: widget.onchange,
      controller: widget.controller,
      cursorColor: AppColors.secondary,
      maxLines: widget.maxLines ??  1,
      style:  TextStyle(color: AppColors.black,fontSize: 12.sp),
      decoration: InputDecoration(
          errorText: widget.errorEnabled==true ? widget.errorText : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 20),
          labelText: widget.label,
          prefixIcon: widget.pre,
          labelStyle:  TextStyle(fontFamily: AppFonts.urban700, color: AppColors.black,fontSize: 10.sp,fontWeight: FontWeight.w500),
          hintText: widget.hint ,
          filled: true,
          fillColor: AppColors.lightGrey.withOpacity(0.5),
          errorBorder: widget.errorEnabled==true ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.errorColor)) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor)),
          focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor)),
          hintStyle:  TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: AppColors.lightGrey,fontFamily: AppFonts.urban700),
          focusedErrorBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor)),
          enabledBorder:  OutlineInputBorder(
              borderRadius:BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor))),
    );
  }
}




class PasswordTextField extends StatefulWidget {
  final String? hint;
  final String? label;
  final Widget? suffixIcon;
  final bool isObscure;
  final bool passError;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String? Function(String?)? onchange;
  final String? Function(String?)? onSave;
  const PasswordTextField( {super.key,this.suffixIcon, this.isObscure=false,this.passError=false, this.hint, this.controller,this.onSave,this.label, this.validation, this.onchange});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validation,
      onChanged: widget.onchange,
      controller: widget.controller,
      obscureText: widget.isObscure,
      onSaved: widget.onSave,
      style:  TextStyle(color: AppColors.black,fontSize: 10.sp),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 20),
          labelText: widget.label,
          labelStyle:  TextStyle(fontFamily: AppFonts.urban700, color: AppColors.black,fontSize: 10.sp,fontWeight: FontWeight.w500),
          hintText: widget.hint,
          suffixIcon:widget.suffixIcon,
          filled: true,
          fillColor: AppColors.lightGrey.withOpacity(0.5),
          errorBorder: widget.passError==true ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.errorColor)) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor)),
          focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor)),
          hintStyle:  TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: AppColors.lightGrey,fontFamily: AppFonts.urban700),
          focusedErrorBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor)),
          enabledBorder:  OutlineInputBorder(
              borderRadius:BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor))),
    );
  }
}


class SearchTextField extends StatefulWidget {
  final String? hint;
  final String? label;
  final Widget? pre;
  final bool isEnabled;
  final Color? fillColor;
  final TextEditingController controller;
  final String? Function(String?)? validation;
  final String? Function(String?)? onchange;
  const SearchTextField( {super.key,this.isEnabled=true ,this.fillColor=AppColors.pinColor ,this.hint,required this.controller,this.label, this.validation, this.onchange, this.pre});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.isEnabled,
      cursorColor: AppColors.secondary,
      validator: widget.validation,
      onChanged: widget.onchange,
      controller: widget.controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          labelText: widget.label,
          prefixIcon:  const Padding(
            padding:EdgeInsets.only(left: 14),
            child: Icon(CupertinoIcons.search,color: AppColors.secondary,size: 24),
          ),
          fillColor: widget.fillColor,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 50,
            minHeight: 50,
          ),
          filled: true,
          labelStyle:  TextStyle(color: AppColors.lightGrey,fontSize: 9.sp,fontWeight:FontWeight.w400),
          hintText: widget.hint ,
          // focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: AppColors.button)),
          hintStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.lightGrey),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1,color: AppColors.pinColor))),
    );
  }
}