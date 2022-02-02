
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nextstop_dynamic/notifier/getUiNotifier.dart';
import 'package:nextstop_dynamic/pages/estimateBill.dart';
import 'package:nextstop_dynamic/pages/homePage.dart';
import 'package:nextstop_dynamic/pages/loginPage.dart';
import 'package:nextstop_dynamic/pages/registrationPage.dart';
import 'package:nextstop_dynamic/pages/scheduleRide.dart';
import 'package:nextstop_dynamic/widgets/calculation.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'dart:convert';

import 'general.dart';
// List<dynamic> queryString=[];
bool ISVALIDJSON=false;
//FORM SUBMISSION CLICK EVENT AND RESULT JSON GENERATION
formSubmitMethod(dynamic guid,List<dynamic> widget,Map clickEvent,List queryStr,{MyCallback? myCallback}){
  //log("widget $widget");
/*  queryString=queryStr;
  log("queryString $queryString");*/
  var result={
    "Guid":guid,
    "FieldArray":[]
  };
  List<dynamic> widgets=[];


  widgets=widget;

  List<bool> validList=[];
  bool isValid=true;

  result["FieldArray"]=[];
  List<dynamic> fields=[];
  validList=[];

  addValidationResult(dynamic element){
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

  check1(dynamic eleCheck){
    if(eleCheck.runtimeType==Icon){
      return;
    }
    if(eleCheck.map.containsKey('hasInput')){
      addValidationResult(eleCheck);
    }
    else if(eleCheck.map.containsKey("child")){
      check1(eleCheck.widget);
    }
    else if(eleCheck.map.containsKey("children")){
        eleCheck.widgets.forEach((element) {
          check1(element);
        });
    }
  }

  widgets.forEach((element) {
    check1(element);
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
      return null;
    }
    else{
      print("Valid json $resJson");
/*      for(int i=0;i<queryString.length;i++){
        for(int j=0;j<fields.length;j++){
          if(fields[j].containsKey(queryString[i]['key'].toString())){
            queryString[i]['value']=fields[j][queryString[i]['key'].toString()];
            break;
          }
        }
      }
      log("query STring $queryString");*/
      // fields.forEach((element) {
      //   map.
      //   log("ele $element ${element.get}");
      // });

      /*if(guid==General.bookingPageIdentifier){
        log("w $widgets");
        log("w ${widgets[5].getValue()[0]['price']}");
        var _distanceInMeters = Geolocator.distanceBetween(
              queryString[1]['value'][0]['latitude'],
              queryString[1]['value'][1]['longitude'],
              queryString[3]['value'][0]['latitude'],
              queryString[3]['value'][1]['longitude'],

          );
        queryString.add({"key":"totalFare","value":"${Calculation().mul(widgets[5].getValue()[0]['price'], _distanceInMeters/1000).toStringAsFixed(2)}"});
          log("_distanceInMeters $_distanceInMeters ${_distanceInMeters/1000} ${Calculation().mul(widgets[5].getValue()[0]['price'], _distanceInMeters/1000).toStringAsFixed(2)}");
        if(clickEvent.containsKey('navigateToPage')){
          navigateTo(clickEvent['navigateToPage'],clickEvent['typeOfNavigation'],myCallback: myCallback);
        }
      }
      else{
        Get.defaultDialog(
          title: "",
          content: CircularProgressIndicator()
        );
        GetUiNotifier().postUiJson( null, result["Guid"], resJson).then((value){
          Get.back();
          if(clickEvent.containsKey('navigateToPage')){
            navigateTo(clickEvent['navigateToPage'],clickEvent['typeOfNavigation']);
          }
        });

      }*/

      ISVALIDJSON=true;
      return resJson;
    }
   // Provider.of<GetUiNotifier>(context, listen: false).postUiJson(context, guid, result.toString());
  }
  else{
    ISVALIDJSON=false;
    print("INVALID ${fields}");
    return null;
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


parseQueryString(List fields,List qs){
  List queryStringRes=[];
  queryStringRes=qs;
  for(int i=0;i<queryStringRes.length;i++){
    for(int j=0;j<fields.length;j++){
      if(fields[j].containsKey(queryStringRes[i]['key'].toString())){
        queryStringRes[i]['value']=fields[j][queryStringRes[i]['key'].toString()];
        break;
      }
    }
  }
  return queryStringRes;
}

//NAVIGATION
navigateTo(String page,int? typeOfNavigation,{MyCallback? myCallback}){
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
    else if(page=="ScheduleRide"){
      getXNavigation(typeOfNavigation, ScheduleRidePage());
    }
    else if(page=="Registration"){
      getXNavigation(typeOfNavigation, RegistrationPage());
    }
    else if(page=="Login"){
      getXNavigation(typeOfNavigation, LoginPage());
    }
    else{
      errorDialog(err002);
    }
  }

}

getPage(String page){
  switch(page){
    case 'HomePage':
      return HomePage();
    case 'ScheduleRide':
      return ScheduleRidePage();
    case 'Registration':
      return RegistrationPage();
    case 'Login':
      return LoginPage();
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