import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'utils.dart';

class SizedBoxController extends StatelessWidget implements MyCallback2{
  Map map;
  SizedBoxController({required this.map});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: map.containsKey('width')?double.parse(map['width'].toString()):0.0,
      height: map.containsKey('height')?double.parse(map['height'].toString()):0.0,
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