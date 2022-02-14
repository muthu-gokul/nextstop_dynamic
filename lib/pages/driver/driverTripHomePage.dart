import 'dart:developer';

import 'package:flutter/material.dart';
import '../../widgets/customControllers/callBack/common.dart';
import '../../widgets/customControllers/callBack/general.dart';
import '../../widgets/customControllers/callBack/myCallback.dart';

import '../dynamicPageInitiater.dart';



class DriverTripHomePage extends StatelessWidget with Common implements MyCallback{
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
  void onMapLocationChanged(Map map) {

  }

  @override
  void onTextChanged(String text, Map map) {

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

/*  @override
  openMap(Map clickEvent) {
    log("open Map $clickEvent");
  }*/

  @override
  formDataJsonApiCallResponse(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}) async {
    var apiResponse=await formDataJsonApiCall(guid, widgets, clickEvent, queryString);
    log("apiResponse $apiResponse");
    if(apiResponse!=null){
      reload();
    }
  }



  onNotificationReceived(List valueArray){
    print("Noti Received $valueArray");
    findUpdateByKeyWidgetType(valueArray, dynamicPageInitiater.dynamicPageInitiaterState.widgets);
  }

  reload(){
    dynamicPageInitiater.dynamicPageInitiaterState.initSS();
    reloadMap();
  }
  reloadMap(){
    print("Relaod MAp");
    findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,{"key":"map01"},(wid){
      wid.reload();
    });
  }
}