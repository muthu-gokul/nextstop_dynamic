import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class ColumnController extends StatelessWidget {
  Map map;
  MyCallback myCallback;
  List widgets=[];
  ColumnController({required this.map,required this.myCallback})
  {
   // log("Column Constructor");
    if(map.containsKey('children')){
      widgets=getWidgets(map['children'], myCallback);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: map.containsKey('height')?double.parse(map['height'].toString()):
      map.containsKey('reducedHeight')?SizeConfig.screenHeight!-double.parse(map['reducedHeight'].toString()):null,
     // width: SizeConfig.screenWidth,
      child: Column(
       /* mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,*/
        crossAxisAlignment: parseCrossAxisAlignment(map['crossAxisAlignment']),
        mainAxisAlignment: parseMainAxisAlignment(map['mainAxisAlignment']),
        children: [
          for(int i=0;i<widgets.length;i++)
            widgets[i]
        ],
      ),
    );
  }


}