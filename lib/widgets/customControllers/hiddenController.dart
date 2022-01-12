import 'package:flutter/material.dart';
class HiddenController extends StatelessWidget {
  Map map;
  HiddenController({required this.map});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,height: 0,
    );
  }

  validate(){
    return true;
  }

  getValue(){
    return map['value'];
  }
}
