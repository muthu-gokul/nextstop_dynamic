import 'package:flutter/material.dart';


import '../sizeLocal.dart';
import 'utils.dart';

class TextBoxController extends StatelessWidget {
  Map map;
  TextBoxController({required this.map});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: parseEdgeInsetsGeometry(map['margin']),
      width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:double.maxFinite,
      alignment: parseAlignment(map['alignment']),
      padding: parseEdgeInsetsGeometry(map['padding']),
      child: Text(
        "${map['value']}",
        style: map.containsKey('style') ? parseTextStyle(map['style']) : null,
      ),
    );
  }
}