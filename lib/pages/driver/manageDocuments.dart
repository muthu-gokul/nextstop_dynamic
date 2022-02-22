import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/utils/common.dart';
import 'package:nextstop_dynamic/utils/general.dart';


import '../dynamicPageInitiater.dart';



class ManageDocuments extends StatelessWidget with Common, MyCallback{

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
  Future<void> ontap(Map? clickEvent) async {
    log("manage doc $clickEvent");
    splitByTapEvent(
        clickEvent,
        widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
        queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
        myCallback: this
    );
  }


}