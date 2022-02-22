import 'dart:developer';

import 'package:flutter/material.dart';
import '../widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class StackController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  StackController({required this.map,required this.myCallback})
  {

    if(map.containsKey('children')){
      widgets=getWidgets(map['children'], myCallback);
    }
    log("stavk $widgets");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: parseAlignment(map['alignment']),
      children: [
         Container(),
        for(int i=0;i<widgets.length;i++)
          widgets[i],

      ],
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