import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/pages/dynamicPageInitiater.dart';
import 'package:nextstop_dynamic/styles/style.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:nextstop_dynamic/widgets/customControllers/utils.dart';
class GetxTabController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  late Function(int)? voidCallback;

  GetxTabController(int length,{Function(int)? vb}){
    tabController=new TabController(length: length, vsync: this);
    voidCallback=vb;
  }
  listener(){
    tabController.addListener(() {
      if(voidCallback!=null){
        voidCallback!(tabController.index);
      }
      //print("tabController.index ${tabController.index}");
    });
    //  return tabController.index;
  }

  @override
  void onReady() {
    super.onReady();
  }
}


class TabbarController extends StatelessWidget implements MyCallback2,TabPageViewCallback{
  Map map;
  MyCallback myCallback;
  TabbarController({required this.map,required this.myCallback}){

    List values=map['value'];
    tabController=GetxTabController(values.length);
    values.forEach((element) {
      widgets.add(map.containsKey('tab')?getChild(map['tab'],myCallback: myCallback):Container());
      element.forEach((k, v) {
        print("$k $v ${widgets[widgets.length-1].map}");
        func1ByKey(widgets[widgets.length-1], {"key":"$k"}, (wid){
          print("wid $wid");
          updateByWidgetType(wid.getType(),widget: wid,clickEvent: {"key":"$k","value":"$v"});
        });
      });
    });

  }

  List widgets=[];

  late GetxTabController tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: parseEdgeInsetsGeometry(map['margin']),
      padding: parseEdgeInsetsGeometry(map['padding']),
      height: map['height'],
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: parseHexColor(map['borderColor'])!),
        borderRadius: parseBorderRadius(map['borderRadius']),
        color:parseHexColor(map['backgroundColor'])!.withOpacity(map.containsKey('backgroundColorOpacity')?map['backgroundColorOpacity']:1),
      ),

      child: TabBar(
        controller: tabController.tabController,
        isScrollable: map.containsKey('isScrollable')?map['isScrollable']:false,
        indicatorSize: TabBarIndicatorSize.label,
        // indicatorColor: theme,
        labelColor: parseHexColor(map['labelColor']),
        unselectedLabelColor: parseHexColor(map['unselectedLabelColor']),
        labelStyle: TextStyle(fontSize: 14),
        unselectedLabelStyle: TextStyle(fontSize: 14),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: parseHexColor(map['indicatorColor'])
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.symmetric(horizontal: 0),
        onTap: (i){
            onChanged(i);
        },

        tabs: [
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

  @override
  onChanged(int index) {
    findWidgetByKey(myCallback.getCurrentPageWidgets(), {"key":"${map['toFindKey']}"}, (wid){
      wid.changeControllerIndex(index);
    });
  }

  @override
  changeControllerIndex(int index) {
    tabController.tabController.animateTo(index,duration: Duration(milliseconds: 300));
  }
}
