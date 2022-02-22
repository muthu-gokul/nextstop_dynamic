import 'dart:developer';

import 'package:flutter/material.dart';

import '../widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class FlexibleController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  Widget? widget;
  FlexibleController({required this.map,required this.myCallback}){
    widget=map.containsKey('child')?getChild(map['child'],myCallback: myCallback):Container();
    //  log("Button Constructor");
  }

  @override
  Widget build(BuildContext context) {
    return  Flexible(
      flex: map.containsKey('flex')?map['flex']:1,
      child: widget!,
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