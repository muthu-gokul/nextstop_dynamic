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
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'driver/homePageDriver.dart';
import 'dynamicPageInitiater.dart';

class RegistrationPage extends StatelessWidget with General implements MyCallback{
  RegistrationPage(){
    log("reg PAge");
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: registrationPageIdentifier,
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
  Future<void> ontap(Map? clickEvent) async {
    log("registration Click $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.FormSubmit){
          //  log("$widgets");
          var res= General().formSubmit(registrationPageIdentifier, dynamicPageInitiater.dynamicPageInitiaterState.widgets,clickEvent,dynamicPageInitiater.dynamicPageInitiaterState.queryString,myCallback: this);
          if(res!=null){

            if(fromUrl){
              var apires=await checkApiCall(clickEvent, res, registrationPageIdentifier);
              log("apiregistration $apires");
              if(apires.toString().isNotEmpty){
                var parsed=jsonDecode(apires);
                log("registration parsed $parsed");
                LOGINUSERID=parsed['Table'][0]['UserId'];
                isDriver=parsed['Table'][0]['IsDriver'];


                SharedPreferences sp=await SharedPreferences.getInstance();
                sp.setBool(ISLOGGEDINKEY, true);
                sp.setBool(ISDRIVERKEY, isDriver);
                sp.setInt(LOGINUSERIDKEY, LOGINUSERID);

                if(isDriver){
                  getXNavigation(2, HomePageDriver2());
                }
                else{
                  getXNavigation(2, HomePage());
                }

              }
            }
            else{
              //checkAndNavigate(clickEvent);
              SharedPreferences sp=await SharedPreferences.getInstance();
              sp.setBool(ISLOGGEDINKEY, true);
              sp.setInt(LOGINUSERIDKEY, 0);
              getXNavigation(2, HomePageDriver2());
            }


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