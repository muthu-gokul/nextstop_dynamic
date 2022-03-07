import 'dart:async';
import 'dart:developer';

import 'package:dynamicparsers/widgets/swipe2/core/cell.dart';
import 'package:flutter/material.dart';
import 'callBack/general.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class ListViewBuilderController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  // List widgets=[];
  var widgets=[].obs;
  ListViewBuilderController({required this.map,required this.myCallback})
  {
    updateValues(map['value']);
  }

  var isLoad=false.obs;

  updateValues(List values){
    widgets.clear();
   // isLoad.value=true;
    //Timer(Duration(milliseconds: 200), (){
      values.forEach((element) {
        widgets.add(map.containsKey('childd')?getChild(map['childd'],myCallback: myCallback):Container());
        element.forEach((k, v) {
          func1ByKey(widgets[widgets.length-1], {"key":"$k"}, (wid){
            updateByWidgetType(wid.getType(),widget: wid,clickEvent: {"key":"$k","value":v});
          });
        });
      });
   //   isLoad.value=false;
   // });
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>ListView.builder(
      //    itemCount:isLoad.value?0: widgets.length,
          itemCount: widgets.length,
          shrinkWrap: true,
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
  var isLoad=false.obs;
  updateValues(List values){
    widgets.clear();
    isLoad.value=true;
    Timer(Duration(milliseconds: 200), (){
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
        ()=>SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => widgets[index],
            childCount:isLoad.value?0: widgets.length,
          ),
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

class SwipeListViewBuilderController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  SwipeListViewBuilderController({required this.map,required this.myCallback})
  {
    updateValues(map['value']);
  }

  var isLoad=false.obs;

  updateValues(List values){
    widgets.clear();
    isLoad.value=true;

    Timer(Duration(milliseconds: 200), (){
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
            return SwipeActionCell(
                key: ValueKey(i),
                child: widgets[i],
                swipeCallBack: (i){
                  log("swipe $i");
                },
                closeCallBack: (i){
                  log("close");
                }
            );
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


class SwipeSliverListController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  SwipeSliverListController({required this.map,required this.myCallback})
  {
    updateValues(map['value']);
  }
  var isLoad=false.obs;

  updateValues(List values,{int? millisecons}){
    widgets.clear();
    isLoad.value=true;
    Timer(Duration(milliseconds: millisecons??200), (){
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
        ()=>SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => SwipeActionCell(
                key: ValueKey(index),
                child: widgets[index],
                index: index,
                firstActionWillCoverAllSpaceOnDeleting: false,
                normalAnimationDuration: 500,
                deleteAnimationDuration: 400,
                trailingActions: [
                   SwipeAction(
                        title: "",
                        style: TextStyle(height: 0),
                        index: index,
                        icon: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red.withOpacity(0.2)
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.delete_outline,color: Colors.red,size: 20,),
                        ),
                        onTap: (handler,i) async {
                          print("cc $index");
                          if(map["swipeDeleteButtonEvent"].containsKey("changeValuesArray")){
                            map["swipeDeleteButtonEvent"]['changeValuesArray'].forEach((ele){
                              func1ByKey(widgets[index], {"key":"${ele['toFindKey']}"}, (wid){
                                ele["value"]=wid.getValue();
                              });
                            });
                          }
                          myCallback.ontap(map['swipeDeleteButtonEvent']);
                          updateValues(map['value'],millisecons: 50);
                        },
                        color: Colors.white,

                      ),
                ],

                swipeCallBack: (i){
                  // log("swipeSl $i ${map['swipeChangeValueArray']}");
                  map['swipeChangeValueArray'].forEach((ele){
                    func1ByKey(widgets[i], {"key":"${ele['key']}"}, (wid){
                      updateByWidgetType(wid.getType(),widget: wid,clickEvent: ele);
                    });
                  });
                },
                closeCallBack: (i){
                  //log("closeSl $i");//notSelectedChangeValueArray
                  map['notSelectedChangeValueArray'].forEach((ele){
                    func1ByKey(widgets[i], {"key":"${ele['key']}"}, (wid){
                      updateByWidgetType(wid.getType(),widget: wid,clickEvent: ele);
                    });
                  });
               //   updateValues(map['value']);
                }
            ),
            childCount:isLoad.value?0: widgets.length,
          ),
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