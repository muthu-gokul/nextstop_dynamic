import 'dart:developer';

import 'package:dynamicparsers/widgets/arc/arc.dart';
import 'package:dynamicparsers/widgets/arc/edge.dart';
import 'package:dynamicparsers/widgets/sizeLocal.dart';
import 'package:flutter/material.dart';

import 'callBack/general.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';




class ArcContainer extends StatelessWidget {
  Map map;
  MyCallback ontap;
  ArcContainer({required this.map,required this.ontap}){
    widget=map.containsKey('child')?getChild(map['child'],myCallback: ontap):Container();
  }
  Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Arc(
      edge: Edge.TOP,
      arcType: ArcType.CONVEX,
      height: map['arcHeight'],
      child: Container(
        margin: parseEdgeInsetsGeometry(map['margin']),
        padding: parseEdgeInsetsGeometry(map['padding']),
        height: map.containsKey('height')?double.parse(map['height'].toString()):
        map.containsKey('reducedHeight')?SizeConfig.screenHeight!-double.parse(map['reducedHeight'].toString()):
        map.containsKey('screenHeight')?SizeConfig.screenHeight!-topPad:null,
      //  map.containsKey('screenHeight')?SizeConfig.screenHeight!:null,

        // height: double.parse(map['height'].toString()),
        width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:double.maxFinite,
        //width:map.containsKey('width')? double.parse(map['width'].toString()):double.maxFinite,
        alignment: parseAlignment(map['alignment']),
        decoration: BoxDecoration(
            borderRadius:map.containsKey('shape')?null: parseBorderRadius(map['borderRadius']),
            color: parseHexColor(map['color'],ontap),
            shape: parseBoxShape(map['shape']),
            border: Border.all(color: parseHexColor(map['borderColor'],ontap)!)
        ),
        child: widget,
      ),
    );
  }
}
