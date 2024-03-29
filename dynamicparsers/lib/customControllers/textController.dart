import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'callBack/myCallback.dart';


import '../widgets/sizeLocal.dart';
import 'utils.dart';

class TextBoxController extends StatelessWidget implements MyCallback2{
  Map map;
  Rxn ts=Rxn();
  Rxn text=Rxn();

  bool onlyText=false;
  MyCallback myCallback;

  TextBoxController({required this.map,required this.myCallback}){
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
        style: map.containsKey('style') ? parseTextStyle(ts.value,myCallback) : null,
            textAlign: parseTextAlign(map['textAlign']),
      ),
    ):
    Container(
      margin: parseEdgeInsetsGeometry(map['margin']),
      width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:
      map.containsKey("reducedWidth")?SizeConfig.screenWidth!-map['reducedWidth']:null,
      alignment: parseAlignment(map['alignment']),
      padding: parseEdgeInsetsGeometry(map['padding']),
      child: Obx(
        ()=> Text(
          "${text.value??""}",
          style: map.containsKey('style') ? parseTextStyle(ts.value,myCallback) : null,
          textAlign: parseTextAlign(map['textAlign']),

        ),
      ),
    );
  }

  @override
  getType() {
    return map['type'];
  }

  @override
  getValue() {
    return text.value;
  }

  @override
  validate() {
    return true;
  }
}