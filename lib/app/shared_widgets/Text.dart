import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salamah/app/config/app_font.dart';

class MyText extends StatelessWidget {
  final String? title,family;
  final FontWeight? weight;
  final double? size;
  final Color? clr;
  final bool? lineThrough;
  final int? line;
  final TextAlign? textAlign;
  final Paint? bgColor;
  final double? letterSpacing;
  final double? wordsSpacing;
  final TextOverflow? overFLow;
  final TextDirection? textDirection;


  const MyText(
      {super.key, this.title,
        this.size,
        this.clr,
        this.textDirection,
        this.overFLow,
        this.weight,
        this.family,
        this.bgColor,
        this.lineThrough=false,
        this.line,
        this.letterSpacing,
        this.wordsSpacing,
        this.textAlign
      });

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = TextStyle(
      fontWeight: weight,
      fontSize: size,
      fontFamily: AppFonts.urban700,
      wordSpacing: wordsSpacing,
      letterSpacing: letterSpacing,
      color: clr,
    );

    return Text(
        title!,
        textDirection: textDirection ?? TextDirection.ltr,
        maxLines: line,
        overflow:overFLow ,
        style: textStyle,
        textAlign: textAlign
    );
  }
}