import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'callBack/general.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class PageViewController extends StatelessWidget implements MyCallback2,TabPageViewCallback{
  Map map;
  MyCallback myCallback;
  late PageController pageController;

  var fromTab=false.obs;
  dynamic tabbarWidget;

  PageViewController({required this.map,required this.myCallback}){
    List values=map['children'];
    //tabController=GetxTabController(values.length);
    widgets=[];
    values.forEach((element) {
      widgets.add(getChild(element,myCallback: myCallback));
      /*element.forEach((k, v) {
        print("$k $v ${widgets[widgets.length-1].map}");
        func1ByKey(widgets[widgets.length-1], {"key":"$k"}, (wid){
          updateByWidgetType(wid.getType(),widget: wid,clickEvent: {"key":"$k","value":"$v"});
        });
      });*/
    });
    pageController=PageController(initialPage: 0,keepPage: false);
    tabbarWidget=null;
    log("pvCtl ${widgets.length}");
  }
  List widgets=[];
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: parseScrollPhysics(map['physics']),
      scrollDirection: map.containsKey('direction')?parseAxis(map['direction']):Axis.horizontal,

      children: [
        /*ListView.builder(
          itemCount: 100,
          itemBuilder: (ctx,i){
            return Text("$i");
          },
        )*/
        for(int i=0;i<widgets.length;i++)
          widgets[i]
      ],
      onPageChanged: (index){
        onChanged(index);
      },
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
  changeControllerIndex(int index) {
    fromTab.value=true;
    pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeIn).then((value){
      fromTab.value=false;
    });
  }

  jumpToInitial(){
    pageController.jumpToPage(0);
  }

  @override
  onChanged(int index) {
    if(!fromTab.value){
      log("tabbarWidget $tabbarWidget");
      if(tabbarWidget==null){
        findWidgetByKey(myCallback.getCurrentPageWidgets(), {"key":"${map['toFindKey']}"}, (wid){
          tabbarWidget=wid;
          log("from pvCont $wid ${wid.runtimeType} $tabbarWidget");
          wid.changeControllerIndex(index);
        });
      }
      else{
        log("from pvCont  $tabbarWidget");
        tabbarWidget.changeControllerIndex(index);
      }

    }
  }
}
