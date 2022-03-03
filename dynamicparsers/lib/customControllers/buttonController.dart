import 'dart:convert';
import 'dart:developer';


import 'package:dynamicparsers/customControllers/callBack/general.dart';
import 'package:flutter/material.dart';

import '../widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class ButtonController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback ontap;


  Rxn color=Rxn();
  Widget? widget;



  ButtonController({required this.map,required this.ontap}){
    color.value=map['color'];
    widget=map.containsKey('child')?getChild(map['child'],myCallback: ontap):Container();

   //log("Button Constructor $topPad");
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: map.containsKey('clickEvent')?(){
       // ontap.ontap(map['eventName']);
        ontap.ontap(map['clickEvent']);
     //   log("button Ctl ${widget} ${map['child']}");
     //  printMap();
      }:null,
      child: Obx(
          ()=>Container(
            margin: parseEdgeInsetsGeometry(map['margin']),
            padding: parseEdgeInsetsGeometry(map['padding']),

            height: map.containsKey('height')?double.parse(map['height'].toString()):
            map.containsKey('reducedHeight')?SizeConfig.screenHeight!-double.parse(map['reducedHeight'].toString()):
            map.containsKey('screenHeight')?SizeConfig.screenHeight!-topPad:null,
           // height: double.parse(map['height'].toString()),
            width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:
            map.containsKey("reducedWidth")?SizeConfig.screenWidth!-map['reducedWidth']:null,
            //width:map.containsKey('width')? double.parse(map['width'].toString()):double.maxFinite,
            alignment: parseAlignment(map['alignment']),
            decoration: BoxDecoration(
                borderRadius:map.containsKey('shape')?null: parseBorderRadius(map['borderRadius']),
                color:map.containsKey('opacity')? parseHexColor(color.value,ontap)!.withOpacity(map['opacity']):parseHexColor(color.value,ontap),
                shape: parseBoxShape(map['shape']),
                border: Border.all(color: parseHexColor(map['borderColor'],ontap)!),
                boxShadow:map.containsKey('boxShadow')? [
                    parseBoxShadow(map['boxShadow'],ontap)
                ]:null
            ),
            child: widget
          ),
      )
    );
  }




  @override
  getValue() {
    // TODO: implement getValue
    throw UnimplementedError();
  }

  @override
  validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }

  @override
  getType() {
    return map['type'];
  }



}