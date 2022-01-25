import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
class PositionController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  Widget? widget;
  PositionController({required this.map,required this.myCallback}){
    widget=map.containsKey('child')?getChild(map['child'],myCallback: myCallback):Container();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: map.containsKey('left')?double.parse(map['left'].toString()):null,
      right: map.containsKey('right')?double.parse(map['right'].toString()):null,
      top: map.containsKey('top')?double.parse(map['top'].toString()):null,
      bottom: map.containsKey('bottom')?double.parse(map['bottom'].toString()):null,
      child: widget!,
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
