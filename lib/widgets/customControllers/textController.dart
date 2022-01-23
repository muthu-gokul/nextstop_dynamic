import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../sizeLocal.dart';
import 'utils.dart';

class TextBoxController extends StatelessWidget {
  Map map;
  Rxn ts=Rxn();
  Rxn text=Rxn();

  bool onlyText=false;

  TextBoxController({required this.map}){
//    log("map['style'] ${map['style']}");
    ts.value=map['style'];
    text.value=map['value'];
    if(map.containsKey('onlyText')){
      onlyText=map['onlyText'];
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return onlyText?Obx(
          ()=> Text(
        "${text.value??""}",
        style: map.containsKey('style') ? parseTextStyle(ts.value) : null,
      ),
    ):
    Container(
      margin: parseEdgeInsetsGeometry(map['margin']),
      width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:null,
      alignment: parseAlignment(map['alignment']),
      padding: parseEdgeInsetsGeometry(map['padding']),
      child: Obx(
        ()=> Text(
          "${text.value??""}",
          style: map.containsKey('style') ? parseTextStyle(ts.value) : null,
        ),
      ),
    );
  }
}