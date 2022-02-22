import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/utils/common.dart';
import 'package:nextstop_dynamic/utils/general.dart';


import '../dynamicPageInitiater.dart';

class ProfilePage extends StatelessWidget with Common , MyCallback{
  MyCallback myCallback;
  ProfilePage({required this.myCallback}){
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.profilePageIdentifier,
      myCallback: this,
    );
  }
  late DynamicPageInitiater dynamicPageInitiater;
  @override
  Widget build(BuildContext context) {
    return dynamicPageInitiater;
  }

  @override
  void ontap(Map? clickEvent) {
    log("profile $clickEvent");
    splitByTapEvent(
        clickEvent,
        guid: General.profilePageIdentifier,
        widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
        queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
        myCallback: this
    );
  }
  @override
  openDrawer(MyCallback mc, Map clickEvent) {
    myCallback.ontap(clickEvent);
  }
}