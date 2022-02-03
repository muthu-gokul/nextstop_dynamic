import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/notifier/getUiNotifier.dart';
import 'package:nextstop_dynamic/pages/homePage.dart';
import 'package:nextstop_dynamic/pages/profilePage.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/generalMethods.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'dynamicPageInitiater.dart';

class RegistrationPage extends StatelessWidget implements MyCallback{
  RegistrationPage(){
    log("reg PAge");
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.registrationPageIdentifier,
      myCallback: this,
      key: GlobalKey<DynamicPageInitiaterState>(),
    );
  }
  late DynamicPageInitiater dynamicPageInitiater;
  @override
  Widget build(BuildContext context) {
    return dynamicPageInitiater;
  }

  @override
  void onMapLocationChanged(Map map) {
    // TODO: implement onMapLocationChanged
  }

  @override
  void onTextChanged(String text, Map map) {
    // TODO: implement onTextChanged
  }

  @override
  void ontap(Map? clickEvent) {
    log("registration Click $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.FormSubmit){
          //  log("$widgets");
          var res= General().formSubmit(General.registrationPageIdentifier, dynamicPageInitiater.dynamicPageInitiaterState.widgets,clickEvent,dynamicPageInitiater.dynamicPageInitiaterState.queryString,myCallback: this);
          if(res!=null){

            Get.defaultDialog(
                title: "",
                content: CircularProgressIndicator()
            );
            GetUiNotifier().postUiJson( null, General.registrationPageIdentifier, res,clickEvent).then((value){
              Get.back();
              log("registra $value");

              if(value[0]){
                var parsed=jsonDecode(value[1]);

                LOGINUSERID=parsed['Table'][0]['UserId'];
                if(clickEvent.containsKey(General.navigateToPage)){
                  getXNavigation(clickEvent[General.typeOfNavigation],getPage(clickEvent[General.navigateToPage]));
                }
              }
              else{
                Get.dialog(  CupertinoAlertDialog(
                  title: Icon(Icons.error_outline,color: Colors.red,size: 50,),
                  content: Text("${value[1]}",
                    style: TextStyle(fontSize: 18),),
                ));
              }


            });


          }
          log("resultt $res");
        }
      }
    }
  }
}

/*{
      "type":"rowController",
      "orderBy": "14",
      "mainAxisAlignment": "center",
      "children":[
        {
          "type": "button",
          "orderBy": "1",
          "key": 5,
          "clickEvent": {
            "eventName":"Navigation",
            "navigateToPage":"SecurityDetails",
            "typeOfNavigation":2
          },
          "height":50.0,
          "pixelWidth":50.0,
          "borderRadius": "25,25,25,25",
          "color":"#BABDA8"
        },
        {
          "type":"sizedBox",
          "orderBy": "2",
          "width":10
        },
        {
          "type": "button",
          "orderBy": "3",
          "key": 5,
          "clickEvent": {
            "eventName":"Navigation",
            "navigateToPage":"SecurityReports",
            "typeOfNavigation":1
          },
          "height":50.0,
          "pixelWidth":50.0,
          "borderRadius": "25,25,25,25",
          "color":"#BABDC8"
        },
        {
          "type":"sizedBox",
          "orderBy": "4",
          "width":10
        },
        {
          "type": "button",
          "orderBy": "5",
          "key": 5,
          "height":50.0,
          "pixelWidth":50.0,
          "borderRadius": "25,25,25,25",
          "color":"#ff0000"
        }
      ]
    }*/