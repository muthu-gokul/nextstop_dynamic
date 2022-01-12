import 'package:flutter/material.dart';
import '../sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class ButtonController extends StatelessWidget {
  Map map;
  MyCallback ontap;
  ButtonController({required this.map,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
       // ontap.ontap(map['eventName']);
        ontap.ontap(map['clickEvent']);
      },
      child: Container(
        margin: parseEdgeInsetsGeometry(map['margin']),
        height: double.parse(map['height'].toString()),
        width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:double.maxFinite,
        //width:map.containsKey('width')? double.parse(map['width'].toString()):double.maxFinite,
        alignment: parseAlignment(map['alignment']),
        decoration: BoxDecoration(
          borderRadius: parseBorderRadius(map['borderRadius']),
          color: parseHexColor(map['color']),
        ),
        child: map.containsKey('child')?getChild(map['child']):Container(),
      ),
    );
  }
}