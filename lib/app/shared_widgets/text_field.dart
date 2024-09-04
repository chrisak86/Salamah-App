
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';


class InputTextField extends StatefulWidget {
  final String hint;
  final String? errorText;
  final bool readOnly;
  final bool? isError;
  final Color? clr;
  final int? lines;
  final int? length;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final TextEditingController ctrl;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onChange;
   InputTextField( {required this.hint,this.inputFormatters ,required this.ctrl, this.validator, required this.keyboardType, required this.readOnly, this.onChange, this.clr, this.lines, this.length, this.errorText, this.isError,});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength:widget.length ,
      onChanged: widget.onChange,
      readOnly:widget.readOnly ,
      controller:widget.ctrl ,
      inputFormatters: widget.inputFormatters ?? [],
    keyboardType:widget.keyboardType ,
    validator:widget.validator ,
    cursorColor:AppColors.primary ,
    maxLines: widget.lines,
    decoration: InputDecoration(
      hintText: widget.hint ,
      counterText: '',
      errorText:widget.errorText,
      contentPadding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      fillColor:widget.clr ?? AppColors.trans,
      filled: true,
      enabledBorder: OutlineInputBorder(borderSide:const BorderSide(color:AppColors.white,width: 1),
          borderRadius: BorderRadius.circular(8)),
      hintStyle:const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.hintColor),
    focusedBorder: OutlineInputBorder( borderSide:const BorderSide(color:AppColors.primary,width: 1),
        borderRadius: BorderRadius.circular(8)),
      focusedErrorBorder: OutlineInputBorder( borderSide:const BorderSide(color:AppColors.primary,width: 1),
        borderRadius: BorderRadius.circular(8)),
      errorBorder: OutlineInputBorder( borderSide:const BorderSide(color:AppColors.red,width: 1),
          borderRadius: BorderRadius.circular(8)),
    ),
    );
  }
}

class InputPasswordField extends StatefulWidget {
  final String hint;
  final bool readOnly;
  final bool obSecure;
  final List<TextInputFormatter>? inputFormatters;
  final IconButton eye;
  final TextInputType keyboardType;
  final TextEditingController ctrl;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onChange;
 const InputPasswordField( {super.key,this.inputFormatters, required this.hint, required this.ctrl, this.validator, required this.keyboardType, required this.readOnly, this.onChange, required this.eye, required this.obSecure,});

  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obSecure,
      onChanged: widget.onChange,
      readOnly:widget.readOnly ,
      controller:widget.ctrl ,
    inputFormatters: widget.inputFormatters,
    keyboardType:widget.keyboardType ,
    validator:widget.validator ,
    cursorColor:AppColors.primary ,
    decoration: InputDecoration(
      suffixIcon: widget.eye,
      hintText: widget.hint ,
      contentPadding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      fillColor: AppColors.white,
      filled: false,
      enabledBorder: OutlineInputBorder(borderSide:const BorderSide(color:AppColors.white,width: 1),
          borderRadius: BorderRadius.circular(8)),
      errorBorder: OutlineInputBorder(borderSide:const BorderSide(color:AppColors.red,width: 1),
          borderRadius: BorderRadius.circular(8)),
      hintStyle: AppTextStyles.hintText,
    errorStyle:const TextStyle(color: AppColors.red),
        focusedErrorBorder: OutlineInputBorder( borderSide:const BorderSide(color:AppColors.primary,width: 1),
        borderRadius: BorderRadius.circular(8)),

    focusedBorder: OutlineInputBorder( borderSide:const BorderSide(color:AppColors.primary,width: 1),
        borderRadius: BorderRadius.circular(8))
    ),
    );
  }
}


class DropdownInput extends StatelessWidget {
  final String hint;
  final Color? clr;
  final String value;
  final List<String> list;
  final void Function(String?)? onChanged;
  const DropdownInput({super.key, required this.hint, required this.list, required this.value, this.onChanged, this.clr});
  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField(
      value:value ,
      items:list.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
      icon:const Icon(Icons.keyboard_arrow_down,color: AppColors.grey,),
      style:const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.hintColor),
      decoration: InputDecoration(
          hintText: hint ,
          contentPadding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          fillColor:clr ?? AppColors.white,
          filled: true,
          hintStyle: AppTextStyles.hintText,
          enabledBorder: OutlineInputBorder(
              borderSide:const BorderSide(color:AppColors.white,width: 1),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder( borderSide:const BorderSide(color:AppColors.primary,width: 1),
              borderRadius: BorderRadius.circular(8))
      ),
    );
  }
}

