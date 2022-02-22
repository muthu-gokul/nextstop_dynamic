import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/utils/common.dart';
import 'package:nextstop_dynamic/utils/general.dart';


import '../dynamicPageInitiater.dart';

class MyTrips extends StatelessWidget with Common,MyCallback{
  MyCallback myCallback;
  MyTrips({required this.myCallback}){
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.myTripsPageIdentifier,
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
    if(clickEvent![General.eventName]==General.openDrawer){
      myCallback.ontap(clickEvent);
    }
  }
}