import 'package:flutter/material.dart';

import 'gridWithWidgetParam.dart';




class GridHeaderModel{
  String columnName;
  double width;
  Alignment alignment;
  EdgeInsets edgeInsets;
  TextAlign textAlign;
  bool isActive;
  GridHeaderModel({required this.columnName,this.width=150,this.alignment=Alignment.centerLeft,
    this.edgeInsets=const EdgeInsets.only(left: 10),this.textAlign= TextAlign.left,this.isActive=true});
}

class GridHeader extends StatelessWidget {
  double width;
  EdgeInsets padd;
  Alignment alignment;
  String title;
  TextAlign textAlign;
  GridHeader({required this.width,this.padd=const EdgeInsets.only(left: 10),
    this.alignment=Alignment.centerLeft,required this.title,this.textAlign= TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      alignment: alignment,
      padding: padd, child: Text("$title",style: gridHeaderTS,textAlign:textAlign,),
    );
  }
}

class GridContent extends StatelessWidget {
  double width;
  EdgeInsets padd;
  Alignment alignment;
  dynamic title;
  Color color;
  Widget? widget;
  GridContent({required this.width,this.padd=const EdgeInsets.only(left: 10),
    this.alignment=Alignment.centerLeft,required this.title,this.color=Colors.transparent,this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: width,
      alignment: alignment,
      padding: padd,
      color: color,
      child:widget==null? Text("$title",style: TextStyle(fontSize: 14,color: Color(0xff909090),fontFamily: 'RR'),):widget,
      constraints: BoxConstraints(
        minHeight: 50
      ),
    );
  }
}