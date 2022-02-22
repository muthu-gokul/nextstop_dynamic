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

class SetPassword extends StatelessWidget with Common,MyCallback{
  List<dynamic> fromQueryString;
  SetPassword({required this.fromQueryString}){

    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.setPasswordIdentifier,
      fromQueryString: fromQueryString,
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
    log("SetPassword Click $clickEvent");

    // checkTapFunc.splitByTapEvent(clickEvent);
    splitByTapEvent(
        clickEvent,
        guid: General.setPasswordIdentifier,
        widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
        queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
        myCallback: this
    );
  }

  @override
  formDataJsonApiCallResponse(guid, List widgets, Map clickEvent, List queryString, {MyCallback? myCallback}) async{
    var apiRes=await formDataJsonApiCall(guid, widgets, clickEvent, queryString);
    log("SetPassword apiRes 87 $apiRes");
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

