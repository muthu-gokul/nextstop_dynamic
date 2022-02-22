import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:get/get.dart';

class CustomCheckBox extends StatelessWidget {
  Map map;
  MyCallback myCallback;
  CustomCheckBox({required this.map,required this.myCallback}) {
    color.value = isSelect.value ? parseHexColor(map['selectColor'],myCallback) : parseHexColor(
        map['unSelectColor'],myCallback);
    isSelect.value = map['isSelect'];
  }

  Rxn color = Rxn();
  var isSelect = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: map['height'],
        width: map['height'],
        margin: parseEdgeInsetsGeometry(map['margin']),
        alignment: parseAlignment(map['alignment']),
        decoration: BoxDecoration(
            borderRadius: map.containsKey('shape') ? null : parseBorderRadius(
                map['borderRadius']),
            color: (color.value),
            shape: parseBoxShape(map['shape']),
            border: Border.all(color: parseHexColor(map['borderColor'],myCallback)!)
        ),
       child: Icon(Icons.done, color:parseHexColor(map['borderColor'],myCallback), size: 15,),
       /* child: isSelect.value
            ? Icon(Icons.done, color:parseHexColor(map['borderColor']), size: 20,)
            : Container(),*/
      );
    });
  }
}
