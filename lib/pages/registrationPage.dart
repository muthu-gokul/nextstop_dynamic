import 'dart:convert';
import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/generalMethods.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nextstop_dynamic/pages/setPassword.dart';
import 'package:nextstop_dynamic/utils/common.dart';
import 'package:nextstop_dynamic/utils/general.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

import 'dynamicPageInitiater.dart';

class RegistrationPage extends StatelessWidget with Common, MyCallback{
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
  Future<void> ontap(Map? clickEvent) async {
    log("registration Click $clickEvent");
    splitByTapEvent(
        clickEvent,
        guid: General.registrationPageIdentifier,
        widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
        queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
        myCallback: this
    );
   /* if(clickEvent!=null){
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
    }*/
  }

  @override
  formDataJsonApiCallResponse(guid, List widgets, Map clickEvent, List queryString, {MyCallback? myCallback}) async{
    var apiResponse= await formDataJsonApiCall(guid, widgets, clickEvent, queryString);
    if(apiResponse!=null){
      var parsed=jsonDecode(apiResponse);
      List qs=[{"key":"UserId","value":parsed['Table'][0]['UserId']}];
      getXNavigation(2, SetPassword(fromQueryString: qs));
    }
  }
}
