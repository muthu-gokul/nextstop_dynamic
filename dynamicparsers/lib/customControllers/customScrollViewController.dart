import 'package:flutter/material.dart';

import '../widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class CustomScrollViewController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;

  List widgets=[];
  Widget? tempAppbar;

  CustomScrollViewController({required this.map,required this.myCallback})
  {
    if(map.containsKey('children')){
      widgets=getWidgets(map['children'], myCallback);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: false,
      slivers: [
        for(int i=0;i<widgets.length;i++)
          widgets[i]
        /*SliverAppBar(
          pinned: true,
          floating: false,
          expandedHeight: 0,
          elevation: 0,
          toolbarHeight:map.containsKey('tempAppbar')? 35:0,
          backgroundColor: Colors.white,
          flexibleSpace: tempAppbar,
        ),
        isSliverFillRemaining?SliverFillRemaining(
          hasScrollBody: map['hasScrollBody'],
          child: widget
        ):widget!,
        *//*SliverFillRemaining(
            hasScrollBody: map['hasScrollBody'],
            child:map.containsKey('tempFooter')? tempFooter:Container()
        )*/
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


class SliverFillRemainingController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;

  Widget? widget;

  SliverFillRemainingController({required this.map,required this.myCallback})
  {
      widget=map.containsKey('child')?getChild(map['child'],myCallback: myCallback):Container();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        hasScrollBody: map['hasScrollBody'],
        child: widget
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
class SliverAppBarController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;

  Widget? widget;

  SliverAppBarController({required this.map,required this.myCallback})
  {
      widget=map.containsKey('child')?getChild(map['child'],myCallback: myCallback):Container();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: map.containsKey('pinned')? map['pinned']: true,
      floating: map.containsKey('floating')? map['floating']: false,
      expandedHeight: map.containsKey('expandedHeight')? map['expandedHeight']: 0,
      elevation:map.containsKey('elevation')? map['elevation']: 0,
      toolbarHeight:map.containsKey('toolbarHeight')? map['toolbarHeight']:35.0,
      backgroundColor:map.containsKey('backgroundColor')?parseHexColor(map['backgroundColor'], myCallback): Colors.white,
      flexibleSpace: widget,
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