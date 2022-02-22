import 'package:flutter/material.dart';
import 'callBack/myCallback.dart';

import 'callBack/myCallback.dart';
class HiddenController extends StatelessWidget implements MyCallback2{
  Map map;
  HiddenController({required this.map});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,height: 0,
    );
  }


  @override
  validate(){
    return true;
  }

  @override
  getValue(){
    return map['value'];
  }

  @override
  getType() {
    return map['type'];
  }
}
