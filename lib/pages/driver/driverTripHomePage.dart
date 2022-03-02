import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/general.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/utils/general.dart';
import '../../utils/common.dart';


import '../dynamicPageInitiater.dart';



class DriverTripHomePage extends StatelessWidget with Common , MyCallback{
  MyCallback myCallback;
  DriverTripHomePage({required this.myCallback}){
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.driverTripHomePageIdentifier,
      myCallback: this,
    );
  }
  late DynamicPageInitiater dynamicPageInitiater;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        dynamicPageInitiater,
      ],
    );
  }

  @override
  Future<void> ontap(Map? clickEvent) async {
    log("DriverTripHomePage  $clickEvent");
    splitByTapEvent(
        clickEvent,
        guid: General.driverTripHomePageIdentifier,
        widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
        queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
        myCallback: this
    );

  }

  @override
  openDrawer(MyCallback mc, Map clickEvent) {
    myCallback.ontap(clickEvent);
  }

  @override
  formDataJsonApiCallResponse(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}) async {
    var apiResponse=await formDataJsonApiCall(guid, widgets, clickEvent, queryString);
    log("apiResponse $apiResponse");
    if(apiResponse!=null){
      reload(null);
    }
  }



  onNotificationReceived(List valueArray){
    print("Noti Received $valueArray");
    findUpdateByKeyWidgetType(valueArray, dynamicPageInitiater.dynamicPageInitiaterState.widgets);
  }

  @override
  reloadPage() {
    reload(this);
  }

  @override
  reload(MyCallback? myCallback){
    log("dTHP reload");
    dynamicPageInitiater.dynamicPageInitiaterState.initSS();
    reloadMap();
  }
  reloadMap(){
    print("Relaod MAp");
    findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,{"key":"map01"},(wid){
      wid.reload();
    });
  }

  @override
  getCurrentPageWidgets() {
    return dynamicPageInitiater.dynamicPageInitiaterState.widgets;
  }
}