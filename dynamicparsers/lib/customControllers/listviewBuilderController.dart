import 'dart:async';

import 'package:flutter/material.dart';
import 'callBack/general.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class ListViewBuilderController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  ListViewBuilderController({required this.map,required this.myCallback})
  {
    updateValues(map['value']);
  }

  var isLoad=false.obs;

  updateValues(List values){
    isLoad.value=true;
    widgets.clear();
    Timer(Duration(milliseconds: 100), (){
      values.forEach((element) {
        widgets.add(map.containsKey('childd')?getChild(map['childd'],myCallback: myCallback):Container());
        element.forEach((k, v) {
          func1ByKey(widgets[widgets.length-1], {"key":"$k"}, (wid){
            updateByWidgetType(wid.getType(),widget: wid,clickEvent: {"key":"$k","value":v});
          });
        });
      });
      isLoad.value=false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>ListView.builder(
          itemCount: widgets.length,
          shrinkWrap:isLoad.value? true:true,
          physics: map.containsKey('physics')?parseScrollPhysics(map['physics']):NeverScrollableScrollPhysics(),
          scrollDirection: map.containsKey('direction')?parseAxis(map['direction']):Axis.vertical,
          itemBuilder: (ctx,i){
            return widgets[i];
          },
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


  getValueByIndex(int index){
    return widgets[index];
  }


}


class SliverListController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  SliverListController({required this.map,required this.myCallback})
  {
    updateValues(map['value']);
  }
  updateValues(List values){
    values.forEach((element) {
      widgets.add(map.containsKey('childd')?getChild(map['childd'],myCallback: myCallback):Container());
      element.forEach((k, v) {
        func1ByKey(widgets[widgets.length-1], {"key":"$k"}, (wid){
          updateByWidgetType(wid.getType(),widget: wid,clickEvent: {"key":"$k","value":v});
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => widgets[index],
        childCount: widgets.length,
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