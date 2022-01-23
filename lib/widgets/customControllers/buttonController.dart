import 'dart:developer';

import 'package:flutter/material.dart';
import '../sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class ButtonController extends StatelessWidget {
  Map map;
  MyCallback ontap;

  Rxn color=Rxn();
  Widget? widget;

  ButtonController({required this.map,required this.ontap}){
    color.value=map['color'];
    widget=map.containsKey('child')?getChild(map['child'],myCallback: ontap):Container();
 //  log("Button Constructor");
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: map.containsKey('clickEvent')?(){
       // ontap.ontap(map['eventName']);
        ontap.ontap(map['clickEvent']);
      }:null,
      child: Obx(
          ()=>Container(
            margin: parseEdgeInsetsGeometry(map['margin']),
            height: map.containsKey('height')?double.parse(map['height'].toString()):
            map.containsKey('reducedHeight')?SizeConfig.screenHeight!-double.parse(map['reducedHeight'].toString()):
            map.containsKey('screenHeight')?SizeConfig.screenHeight!-24:null,
           // height: double.parse(map['height'].toString()),
            width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:double.maxFinite,
            //width:map.containsKey('width')? double.parse(map['width'].toString()):double.maxFinite,
            alignment: parseAlignment(map['alignment']),
            decoration: BoxDecoration(
                borderRadius:map.containsKey('shape')?null: parseBorderRadius(map['borderRadius']),
                color: parseHexColor(color.value),
                shape: parseBoxShape(map['shape']),
                border: Border.all(color: parseHexColor(map['borderColor']))
            ),
            child: widget
          ),
      )
    );
  }
}