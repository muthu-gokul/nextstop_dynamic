import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class UserRoleController extends StatelessWidget {
  Map map;
  MyCallback ontap;
  var selectedIndex=(-1).obs;
  List columnWidgets=[];
  List mainWidget=[];
  UserRoleController({required this.map,required this.ontap}){
    selectedIndex.value=map['selectedIndex'];
    if(map.containsKey('children')){
      map['value'].forEach((e){
        columnWidgets=[];
        List temp=jsonDecode(jsonEncode(map['children']));
        columnWidgets=getWidgets(temp, ontap);
        columnWidgets.forEach((element) {
          if(element.map['type']=='text'){
            element.map['value']=e['title'];
          }
          log("e ${element.map}");
        });
        mainWidget.add(columnWidgets);
        log("${e}");
      });
      mainWidget[selectedIndex.value].forEach((e){
        if(e.map['type']=='button' && e.map['isChangeColor']){
            e.color.value=map['selectedColor'];
        }
      });
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
              log("tap ${mainWidget[i]}");
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
                });
                k++;
              });
              // ontap.ontap(map['eventName']);
            //  ontap.ontap(map['clickEvent']);
            },
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

  validate(){
    if(selectedIndex.value==-1){
      return false;
    }
    return true;
  }

  getValue(){
    return map['value'][selectedIndex.value]['value'];
  }

}