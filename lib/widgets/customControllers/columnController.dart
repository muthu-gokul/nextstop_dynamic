import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class ColumnController extends StatelessWidget implements MyCallback2{
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
/*    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: parseCrossAxisAlignment(map['crossAxisAlignment']),
            mainAxisAlignment: parseMainAxisAlignment(map['mainAxisAlignment']),
            mainAxisSize: MainAxisSize.min,
            children: [
              for(int i=0;i<widgets.length;i++)
                widgets[i]
            ],
          ),
        ),
      ],
    );*/


    return Container(
      height: map.containsKey('height')?double.parse(map['height'].toString()):
      map.containsKey('reducedHeight')?SizeConfig.screenHeight!-double.parse(map['reducedHeight'].toString()):null,
     // width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: parseCrossAxisAlignment(map['crossAxisAlignment']),
        mainAxisAlignment: parseMainAxisAlignment(map['mainAxisAlignment']),
        mainAxisSize: MainAxisSize.min,
        children: [
          for(int i=0;i<widgets.length;i++)
            widgets[i]
        ],
      ),
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