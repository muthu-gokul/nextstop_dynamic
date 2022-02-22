import 'package:flutter/material.dart';
import 'callBack/myCallback.dart';
class SpacerController extends StatelessWidget implements MyCallback2{
  Map map;
  SpacerController({required this.map});
  @override
  Widget build(BuildContext context) {
    return Spacer();
  }

  @override
  getType() {
    return 'spacerController';
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
