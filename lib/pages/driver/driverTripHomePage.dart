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
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.Navigation){
          General().navigation(clickEvent[General.navigateToPage],clickEvent[General.typeOfNavigation]);
        }
        else if(clickEvent[General.eventName]==General.openDrawer){
          myCallback.ontap(clickEvent);
        }
        else if(clickEvent[General.eventName]=="AcceptRide"){
          findUpdateByKeyWidgetType(clickEvent['changeValues'], dynamicPageInitiater.dynamicPageInitiaterState.widgets);
        }
        else if(clickEvent[General.eventName]=="RejectRide"){
          findUpdateByKeyWidgetType(clickEvent['changeValues'], dynamicPageInitiater.dynamicPageInitiaterState.widgets);
        }
      }
    }
  }

  onNotificationReceived(List valueArray){
    print("Noti Received $valueArray");
    findUpdateByKeyWidgetType(valueArray, dynamicPageInitiater.dynamicPageInitiaterState.widgets);
  }

  reload(){
    dynamicPageInitiater.dynamicPageInitiaterState.parseJson();
  }
}