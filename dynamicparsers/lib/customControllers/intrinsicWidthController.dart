import 'package:date_format/date_format.dart';
import 'package:dynamicparsers/customControllers/utils.dart';
import 'package:flutter/material.dart';

import 'callBack/myCallback.dart';

class IntrinsicWidthController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  Widget? widget;
  IntrinsicWidthController({required this.map,required this.myCallback}){
    widget=getChild(map['child'],myCallback: myCallback);
  }
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: widget,
    );
  }

  @override
  getType() {
    return map['type'];
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
}
