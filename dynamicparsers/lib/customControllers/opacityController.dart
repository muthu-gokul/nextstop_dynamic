import 'dart:developer';

import 'package:flutter/material.dart';

import '../widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class OpacityController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  Widget? widget;
  OpacityController({required this.map,required this.myCallback}){
    widget=map.containsKey('child')?getChild(map['child'],myCallback: myCallback):Container();
    opacity.value=map.containsKey('opacity')?double.parse(map['opacity'].toString()):0.5;
  }

  var opacity=0.5.obs;

  @override
  Widget build(BuildContext context) {
    return  Obx(
      ()=> AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        opacity: opacity.value,
        child: widget!,
      ),
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