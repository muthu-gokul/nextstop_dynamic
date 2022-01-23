import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class StackController extends StatelessWidget {
  Map map;
  MyCallback myCallback;
  List widgets=[];
  StackController({required this.map,required this.myCallback})
  {

    if(map.containsKey('children')){
      widgets=getWidgets(map['children'], myCallback);
    }
   // log("stavk $widgets");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Container(),
        for(int i=0;i<widgets.length;i++)
          widgets[i],

      ],
    );
  }


}