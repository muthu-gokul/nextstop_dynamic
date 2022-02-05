import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import '../dynamicPageInitiater.dart';



class ManageDocuments extends StatelessWidget implements MyCallback{

  ManageDocuments(){
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.manageDocPageIdentifier,
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
    log("manage doc $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.Navigation){
          General().navigation(clickEvent[General.navigateToPage],clickEvent[General.typeOfNavigation]);
        }
      }
    }
  }
}