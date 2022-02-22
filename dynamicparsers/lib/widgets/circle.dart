import 'package:flutter/material.dart';
class Circle extends StatelessWidget {
  double hei;
  Color color;
  Widget? widget;
  EdgeInsetsGeometry? margin;
  List<BoxShadow> bs;
  Circle({required this.hei,required this.color,this.widget=null,this.margin,
  this.bs=const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hei,
      width: hei,
      margin: margin,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: bs
      ),
      child: widget==null?Container():widget,
    );
  }
}
