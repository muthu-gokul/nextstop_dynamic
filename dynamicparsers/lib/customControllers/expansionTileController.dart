import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../widgets/customExpansionTile.dart';
import 'callBack/myCallback.dart';

class ExpansionTileController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  Widget? widget;

  var expand=false.obs;
  ExpansionTileController({required this.map,required this.myCallback}){
    expand.value=map.containsKey("expand")?map['expand']:false;
    widget=getChild(map['child'],myCallback: myCallback);
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>CustomExpansionTile(
          expand: expand.value,
          child: widget,
        )
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
