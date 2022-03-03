import 'dart:convert';
import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/utils/common.dart';
import 'package:nextstop_dynamic/utils/general.dart';


import '../dynamicPageInitiater.dart';



class DriverMyTrips extends StatelessWidget with Common, MyCallback{
  MyCallback myCallback;
  DriverMyTrips({required this.myCallback}){
    dynamicPageInitiater= DynamicPageInitiater(
      pageIdentifier: General.driverMyTripsPageIdentifier,
      myCallback: this,
    );
  }
  late DynamicPageInitiater dynamicPageInitiater;
  @override
  Widget build(BuildContext context) {
    return dynamicPageInitiater;
  }

  @override
  getCurrentPageWidgets() {
    return dynamicPageInitiater.dynamicPageInitiaterState.widgets;
  }


  @override
  void ontap(Map? clickEvent) {
    log("driver Trips $clickEvent");
    if(clickEvent![General.eventName]==General.openDrawer){
      myCallback.ontap(clickEvent);
    }
    else{
      splitByTapEvent(
          clickEvent,
          widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
          queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
          myCallback: this,
          guid: General.driverMyTripsPageIdentifier
      );
    }
  }

  @override
  reloadPage() {
    dynamicPageInitiater.dynamicPageInitiaterState.initSS();
  }

  @override
  formDataJsonApiCallResponse(guid, List widgets, Map clickEvent, List queryString, {MyCallback? myCallback}) async{
    log("driver Trips formDataJsonApiCallResponse $clickEvent");
    var apiRes=await formDataJsonApiCall(guid, widgets, clickEvent, queryString);
    log("driver Trips apiRes $apiRes");
    if(apiRes!=null){
      var parsed=jsonDecode(apiRes);
      reloadPage();
      General().showAlertPopUp("${parsed['TblOutPut'][0]['@Message']}");
    }
  }
}