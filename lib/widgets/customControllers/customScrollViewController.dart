import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/pages/dynamicPageInitiater.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class CustomScrollViewController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;

  Widget? widget;
  CustomScrollViewController({required this.map,required this.myCallback})
  {

      widget=map.containsKey('child')?getChild(map['child'],myCallback: myCallback):Container();


  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: false,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: map['hasScrollBody'],
          child: widget
        )
      ],
    );

    // return Stack(
    //   children: [
    //     Container(),
    //     for(int i=0;i<widgets.length;i++)
    //       widgets[i],
    //
    //   ],
    // );
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