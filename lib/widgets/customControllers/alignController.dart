import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:nextstop_dynamic/widgets/customControllers/utils.dart';
class AlignController extends StatelessWidget {
  Map map;
  MyCallback myCallback;
  AlignController({required this.map,required this.myCallback});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: parseAlignment(map['alignment']),
      child: getChild(map['child'],myCallback: myCallback),
    );
  }
}
