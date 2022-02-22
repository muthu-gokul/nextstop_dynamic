import 'dart:convert';
import 'dart:developer';
import 'package:dynamicparsers/customControllers/callBack/generalMethods.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/main.dart';
import 'package:nextstop_dynamic/utils/general.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../utils/common.dart';

import 'driver/homePageDriver.dart';
import 'dynamicPageInitiater.dart';
import 'user/homePage.dart';

class LoginPage extends StatelessWidget with Common,MyCallback{
  LoginPage(){

    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.loginPageIdentifier,
      myCallback: this,
    );
  }
  late DynamicPageInitiater dynamicPageInitiater;

  @override
  Widget build(BuildContext context) {
   return dynamicPageInitiater;
  }

  @override
  Future<void> ontap(Map? clickEvent) async {
    log("login Click $clickEvent");

    // checkTapFunc.splitByTapEvent(clickEvent);
    splitByTapEvent(
      clickEvent,
      guid: General.loginPageIdentifier,
      widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
      queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
      myCallback: this
    );
/*    log("Common res $res");

    if(res!=null){
      if(fromUrl){
        var apires=await checkApiCall(clickEvent!, res, loginPageIdentifier);
        log("apires $apires");
        if(apires.toString().isNotEmpty){
          var parsed=jsonDecode(apires);
          log("login parsed $parsed");
          try{
            LOGINUSERID=parsed['Table'][0]['UserId'];
            isDriver=parsed['Table'][0]['IsDriver'];
          }catch(e){

          }



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
          getApnToken();
        }
      }
      else{
        //checkAndNavigate(clickEvent);
        SharedPreferences sp=await SharedPreferences.getInstance();
        sp.setBool(ISLOGGEDINKEY, true);
        sp.setInt(LOGINUSERIDKEY, 0);
        getXNavigation(2, HomePageDriver2());
       // getXNavigation(2, HomePage());
        getApnToken();
      }
    }*/
  }

  @override
  formDataJsonApiCallResponse(guid, List widgets, Map clickEvent, List queryString, {MyCallback? myCallback}) async{
    var apiRes=await formDataJsonApiCall(guid, widgets, clickEvent, queryString);
    log("login apiRes 87 $apiRes");
    if(apiRes!=null){
      var parsed=jsonDecode(apiRes);
      try{
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
        getApnToken();
      }catch(e){

      }

    }
  }
}

