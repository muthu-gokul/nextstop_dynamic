import 'package:flutter/material.dart';
import 'utils.dart';

class SizedBoxController extends StatelessWidget {
  Map map;
  SizedBoxController({required this.map});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: map.containsKey('width')?double.parse(map['width'].toString()):0.0,
      height: map.containsKey('height')?double.parse(map['height'].toString()):0.0,
    );
  }
}