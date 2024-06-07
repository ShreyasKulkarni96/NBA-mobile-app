import 'package:flutter/material.dart';

class CustomTextView extends StatefulWidget {
  var title, fontSize, fontWeight,color, textAlign;

  CustomTextView(
      {Key? key,
      required this.title,
      this.fontSize,
        this.fontWeight,
      this.color,
      this.textAlign})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomTextViewState();
}

class CustomTextViewState extends State<CustomTextView> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.title,
        softWrap: true,
        textAlign: widget.textAlign ?? TextAlign.center,
        style: TextStyle(
            fontWeight: widget.fontWeight ?? FontWeight.w400,
            fontSize: widget.fontSize ?? 19.0,

            color: widget.color ?? Theme.of(context).primaryColor,
            fontFamily: 'Inter'));
  }
}
