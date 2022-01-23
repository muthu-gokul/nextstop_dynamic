
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextstop_dynamic/pages/estimateBill.dart';
import 'package:nextstop_dynamic/pages/homePage.dart';
import 'package:nextstop_dynamic/pages/scheduleRide.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'dart:convert';

import 'general.dart';

//FORM SUBMISSION CLICK EVENT AND RESULT JSON GENERATION
void formSubmitMethod(dynamic guid,List<dynamic> widget,Map clickEvent,List queryString,{MyCallback? myCallback}){
  //log("widget $widget");
  log("queryString $queryString");
  var result={
    "Guid":guid,
    "FieldArray":[]
  };
  List<dynamic> widgets=[];
  /*checkWid(dynamic element){
    if(element.map.containsKey('hasInput')){
      return element;
    }
    return null;
  }
  widget.forEach((element) {
    var eleRes=checkWid(element);
    if(eleRes!=null){
      widgets.add(element);
    }
    log("ele $eleRes");

   *//* if(element.map.containsKey('hasInput')){
     // widgets.add(element);
    }*//*
   // log("element.map $element ${element.runtimeType} ${element.map.containsKey('child')} ${element.map.containsKey('children')} ${element.map}");
    if(element.map.containsKey('child')){
      var eee=getChild(element.map['child'],myCallback: myCallback);
      log("child $eee ${element.map['child'].runtimeType} ${element.map['child']}");
    }
  });*/

  widgets=widget;

  List<bool> validList=[];
  bool isValid=true;

  result["FieldArray"]=[];
  List<dynamic> fields=[];
  validList=[];

  widgets.forEach((element) {
   // print(element);
    if(element.map.containsKey('hasInput')){
      // print(element.map["key"]);
      if(element.map['hasInput']){
        if(element.map['required']){

          if(element.map.containsKey('groupValidation')){
            for(int i=0;i<element.map['groupValidation'].length;i++){
              element.map['groupValidation'][i].forEach((key, value) {
                if(key=='Required'){
                  isValid=element.validate();
                  validList.add(isValid);
                }
                else if(key=='MinimumLength'){
                  isValid=element.minLengthCheck(value);
                  validList.add(isValid);
                }
                else if(key=='MaximumLength'){
                  isValid=element.maxLengthCheck(value);
                  validList.add(isValid);
                }
                else if(key=='EmailValidation'){
                  isValid=element.emailValidation();
                  validList.add(isValid);
                }
                else if(key=='CompareTo'){
                  String v1,v2=element.getValue().toString();
                  widgets.forEach((e1) {
                    if(e1.map['key']==value){
                      v1=e1.getValue().toString();
                     /* print("element.getValue ${v1} $v2");*/
                      if(v1==v2){
                        isValid=true;
                        validList.add(isValid);
                      }
                      else{
                        isValid=false;
                        validList.add(isValid);
                      }
                    }
                  });
                }
              });
              if(isValid){
                continue;
              }
              else{
                break;
              }
            }
            fields.add({
              "${element.map["key"]}":element.getValue()
             // element.map["key"]:element.getValue()
            });
          }
          else{
            isValid=element.validate();
            validList.add(isValid);
            fields.add({
              "${element.map["key"]}":element.getValue()
             // element.map["key"]:element.getValue()
            });
          }
        }
        else{
          fields.add({
           "${element.map["key"]}":element.getValue()
           // element.map["key"]:element.getValue()
          });
        }
      }
    }
  });

  if(!validList.any((element) => element==false)){
   // print("VALID ${fields}");
    result["Guid"]=guid;
    result["FieldArray"]=fields;
    print((result));
    String? resJson= resultToJson(result);
    Map map;
    if(resJson==null){
      print("Invalid json");
      errorDialog(err001);
    }


    else{
      print("Valid json $resJson");
      for(int i=0;i<queryString.length;i++){
        for(int j=0;j<fields.length;j++){
          if(fields[j].containsKey(queryString[i]['key'].toString())){
            queryString[i]['value']=fields[j][queryString[i]['key'].toString()];
            break;
          }
        }
      }
      log("query STring $queryString");
      // fields.forEach((element) {
      //   map.
      //   log("ele $element ${element.get}");
      // });
      if(clickEvent.containsKey('navigateToPage')){
        navigateTo(clickEvent['navigateToPage'],clickEvent['typeOfNavigation']);
      }
    }
   // Provider.of<GetUiNotifier>(context, listen: false).postUiJson(context, guid, result.toString());
  }
  else{
    print("INVALID ${fields}");
  }
}

//RESULT JSON
String? resultToJson(Map map){
  try{
    return jsonEncode(map);
  }catch(e){
    return null;
  }
}


//NAVIGATION
navigateTo(String page,int? typeOfNavigation,){
  if(typeOfNavigation==3){
    Get.back();
  }
  else if(typeOfNavigation==4){
    Get.close(2);
  }
  else{
    if(page=="SecurityDetails"){
     // getXNavigation(typeOfNavigation, SecurityDetails());
    }
    else if(page=="SecurityReports"){
    //  getXNavigation(typeOfNavigation, Reports());
    }
    else if(page=="GetStart"){
   //   getXNavigation(typeOfNavigation, DesignationSelect());
    }
    else if(page=="HomePage"){
      getXNavigation(typeOfNavigation, HomePage());
    }
    else if(page=="EstimateBill"){
      getXNavigation(typeOfNavigation, EstimateBillPage());
    }
    else if(page=="ScheduleRide"){
      getXNavigation(typeOfNavigation, ScheduleRidePage());
    }
    else{
      errorDialog(err002);
    }
  }

}

//GETX NAVIGATION
getXNavigation(int? typeOfNavigation,Widget widget){
  //Navigate to next Screen without Pop Previous Screen
  if(typeOfNavigation==1){
    Get.to(widget);
  }
  //Navigate to next Screen  Popping all  Previous Screen
  else if(typeOfNavigation==2){
    Get.off(widget);
  }
  //Pop Current Page
  else if(typeOfNavigation==3){
    Get.back();
  }
  else if(typeOfNavigation==4){
    Get.close(2);
  }
  else{
    Get.to(widget);
  }
}


//ERROR POPUP
errorDialog(String content){
  Get.defaultDialog(
    title: "Alert!",
    titlePadding: EdgeInsets.only(top: 20),
    content: Text(content,style: TextStyle(fontSize: 16,fontFamily: 'RR',color: Color(0xff9E9E9E)),),
    radius: 8.0,
  );
}