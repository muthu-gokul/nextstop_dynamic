import 'package:flutter/material.dart';

import '../widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class CustomScrollViewController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;

  Widget? widget;
  Widget? tempAppbar;
  Widget? tempFooter;
  bool isSliverFillRemaining=true;
  CustomScrollViewController({required this.map,required this.myCallback})
  {

      isSliverFillRemaining=map.containsKey('isSliverFillRemaining')?map['isSliverFillRemaining']:true;
      widget=map.containsKey('child')?getChild(map['child'],myCallback: myCallback):Container();
      tempAppbar=map.containsKey('tempAppbar')?getChild(map['tempAppbar'],myCallback: myCallback):Container();
      tempFooter=map.containsKey('tempFooter')?getChild(map['tempFooter'],myCallback: myCallback):Container();

  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: false,
      slivers: [
        SliverAppBar(
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
        /*SliverFillRemaining(
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