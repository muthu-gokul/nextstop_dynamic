import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/pages/dynamicPageInitiater.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class ListViewBuilderController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  Widget? tempChild;
  ListViewBuilderController({required this.map,required this.myCallback})
  {

    if(map.containsKey('value')){
      tempChild=map.containsKey('child')?getChild(map['child'],myCallback: myCallback):Container();
    }
    List values=map['value'];
    values.forEach((element) {
      log("ele $element");
      widgets.add(map.containsKey('child')?getChild(map['child'],myCallback: myCallback):Container());
      element.forEach((k, v) {
        log("key $k $v");
        func1ByKey(widgets[widgets.length-1], {"key":"$k"}, (wid){
          log("found wid $wid ${wid.getType()}");
          updateByWidgetType(wid.getType(),widget: wid,clickEvent: {"key":"$k","value":"$v"});
        });
      });
    });



  }

  @override
  Widget build(BuildContext context) {
/*    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: ListView.builder(
              itemCount: widgets.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx,i){
                return widgets[i];
              },
            ),
        )
      ],
    );*/
    return ListView.builder(
      itemCount: widgets.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (ctx,i){
        return widgets[i];
      },
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