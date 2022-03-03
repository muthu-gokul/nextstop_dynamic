import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class PaddingController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  Widget? widget;
  PaddingController({required this.map,required this.myCallback}){
    widget=map.containsKey('child')?getChild(map['child'],myCallback: myCallback):Container();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: parseEdgeInsetsGeometry(map['padding'])!,
      child: widget,
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