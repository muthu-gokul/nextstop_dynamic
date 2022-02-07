import 'dart:developer';

import 'package:flutter/material.dart';
import '../sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class VisibilityController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback ontap;

  Rxn isVisible=Rxn();
  Widget? widget;

  VisibilityController({required this.map,required this.ontap}){
    isVisible.value=map['isVisible'];
    widget=map.containsKey('child')?getChild(map['child'],myCallback: ontap):Container();
    //  log("Button Constructor");
  }

  @override
  Widget build(BuildContext context) {
    return  Obx(
              ()=>Visibility(
                  visible: isVisible.value,
                  child: widget!
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