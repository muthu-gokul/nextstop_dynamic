import 'package:date_format/date_format.dart';
import 'package:dynamicparsers/customControllers/utils.dart';
import 'package:dynamicparsers/widgets/circle.dart';
import 'package:flutter/material.dart';

import 'callBack/myCallback.dart';

class CircleController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  CircleController({required this.map,required this.myCallback});

  @override
  Widget build(BuildContext context) {
    return Circle(
        hei: map['radius'],
        color: parseHexColor(map['color'], myCallback)!,
        margin: parseEdgeInsetsGeometry(map['margin']),
        widget: map.containsKey("child")?getChild(map['child']):Container(),
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
