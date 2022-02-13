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
    return dynamicPageInitiater;
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


/*    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.Navigation){
          General().navigation(clickEvent[General.navigateToPage],clickEvent[General.typeOfNavigation]);
        }
        else if(clickEvent[General.eventName]==General.openDrawer){
          myCallback.ontap(clickEvent);
        }
        else if(clickEvent[General.eventName]=="AcceptRide"){
          log("accept Ride $clickEvent");
          var res=formSubmitMethodTFE(General.driverTripHomePageIdentifier, dynamicPageInitiater.dynamicPageInitiaterState.widgets, clickEvent, dynamicPageInitiater.dynamicPageInitiaterState.queryString);
          log("accept Ride Result $res");
          if(res!=null){
            var apiRes=General().checkApiCall(clickEvent, res, General.driverTripHomePageIdentifier);
            log("accept Ride apiRes $apiRes");
            if(apiRes.toString().isNotEmpty){
              dynamicPageInitiater.dynamicPageInitiaterState.initSS();
            }
          }
          //findUpdateByKeyWidgetType(clickEvent['changeValues'], dynamicPageInitiater.dynamicPageInitiaterState.widgets);
        }
        else if(clickEvent[General.eventName]=="RejectRide"){
          //log("accept Ride $clickEvent");
          var res=formSubmitMethodTFE(General.driverTripHomePageIdentifier, dynamicPageInitiater.dynamicPageInitiaterState.widgets, clickEvent, dynamicPageInitiater.dynamicPageInitiaterState.queryString);
          //log("accept Ride Result $res");
          if(res!=null){
            var apiRes=General().checkApiCall(clickEvent, res, General.driverTripHomePageIdentifier);
            if(apiRes.toString().isNotEmpty){
              dynamicPageInitiater.dynamicPageInitiaterState.initSS();
            }
          }
          //findUpdateByKeyWidgetType(clickEvent['changeValues'], dynamicPageInitiater.dynamicPageInitiaterState.widgets);
        }
      }
    }*/
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
  }
}