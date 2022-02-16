import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import 'dynamicPageInitiater.dart';

class MyTrips extends StatelessWidget implements MyCallback{
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
  void onMapLocationChanged(Map map) {
    // TODO: implement onMapLocationChanged
  }

  @override
  void onTextChanged(String text, Map map) {
    // TODO: implement onTextChanged
  }

  @override
  void ontap(Map? clickEvent) {
    if(clickEvent![General.eventName]==General.openDrawer){
      myCallback.ontap(clickEvent);
    }
  }
}