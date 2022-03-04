import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class UserRoleController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback ontap;
  var selectedIndex=(-1).obs;
  List columnWidgets=[];
  List mainWidget=[];



  UserRoleController({required this.map,required this.ontap}){
    log("Constructor");
    selectedIndex.value=map['selectedIndex'];
    if(map.containsKey('children')){
      map['value'].forEach((e){
        columnWidgets=[];
        List temp=jsonDecode(jsonEncode(map['children']));
        columnWidgets=getWidgets(temp, ontap);
        columnWidgets.forEach((element) {
          if(element.map['type']=='text'){
          //  element.map['value']=e['title'];
            element.map['value']=e[element.map['valueKey']];
            element.text.value=e[element.map['valueKey']];
          }
          if(element.map.containsKey('child')){
           // log("true");
           if(element.map['child']['type']=='svgController'){
             //element.map['image']=clickEvent!['value']['image'];
             element.widget.image.value=e[element.map['child']['valueKey']];
           // element.map['child']['image']=e[element.map['child']['valueKey']];
           }
          }

          //log("e ${element.map}");
        });
        mainWidget.add(columnWidgets);
       // log("${e}");
      });
      if(selectedIndex.value!=-1){
        mainWidget[selectedIndex.value].forEach((e){
          if(e.map['type']=='button' && e.map['isChangeColor']){
            e.color.value=map['selectedColor'];
          }
          else if(e.map['type']=='text' && e.map['isChangeColor']){
            e.ts.value=map['selectedTextStyle'];
          }
         /* else if(e.map['type']=='opacityController'){
            e.opacity.value=1;
          }*/
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: double.parse(map['parentHeight'].toString()),
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: map['value'].length,
        itemBuilder: (ctx,i){
          return  GestureDetector(
            onTap: (){
              selectedIndex.value=i;
              map['selectedIndex']=selectedIndex.value;
              //log("tap ${map.containsKey("unSelectOpacity")? i==selectedIndex.value?1:map["unSelectOpacity"] :1}");
              int k=0;
              mainWidget.forEach((ele){
                ele.forEach((e){
                  if(e.map['type']=='button' && e.map['isChangeColor']){
                    if(k==selectedIndex.value) {
                      e.color.value=map['selectedColor'];
                    }
                    else{
                      e.color.value=map['unselectColor'];
                    }
                  }
                 else if(e.map['type']=='text' && e.map['isChangeColor']){
                    if(k==selectedIndex.value) {
                      e.ts.value=map['selectedTextStyle'];
                    }
                    else{
                      e.ts.value=map['unselectedTextStyle'];
                    }
                  }
                 /*else if(e.map['type']=='opacityController'){
                    if(k==selectedIndex.value) {
                      e.opacity.value=1;
                    }
                    else{
                      if( e.map.containsKey("opacity")){
                        e.opacity.value=map['opacity'];
                      }
                      else{
                        e.opacity.value=1;
                      }
                    }
                  }*/
                });
                k++;
              });

              // ontap.ontap(map['eventName']);
            //  ontap.ontap(map['clickEvent']);
            },
            child: Obx(
                ()=>AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  curve: i==selectedIndex.value?Curves.easeIn:Curves.easeIn,
                  opacity: map.containsKey("unSelectOpacity")? i==selectedIndex.value?1:map["unSelectOpacity"] :1,
                  child: Container(
                    color: Colors.transparent,
                    margin: parseEdgeInsetsGeometry(map['margin']),
                    child: Column(
                      children: [
                        for(int j=0;j<mainWidget[i].length;j++)
                          mainWidget[i][j]
                      ],
                    ),
                  ),
                )
            ),
            /*child: Container(
              margin: parseEdgeInsetsGeometry(map['margin']),
              height: double.parse(map['height'].toString()),
              width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:double.maxFinite,
              //width:map.containsKey('width')? double.parse(map['width'].toString()):double.maxFinite,
              alignment: parseAlignment(map['alignment']),
              decoration: BoxDecoration(
                //borderRadius: parseBorderRadius(map['borderRadius']),
                color: parseHexColor(map['color']),
                shape: BoxShape.circle
              ),
              child: map.containsKey('child')?getChild(map['child']):Container(),
            ),*/
          );
        },
      ),
    );
  }

  @override
  validate(){
    if(selectedIndex.value==-1){
      return false;
    }
    return true;
  }

  @override
  getValue(){
    if(selectedIndex.value==-1){
     return "";
    }
    return map['value'][selectedIndex.value]['value'];
  }

  @override
  getType() {
    return map['type'];
  }

}