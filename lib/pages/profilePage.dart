import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/common.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import 'dynamicPageInitiater.dart';

class ProfilePage extends StatelessWidget with Common implements MyCallback{
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
  void onMapLocationChanged(Map map) {
    
    // TODO: implement onMapLocationChanged
  }

  @override
  void onTextChanged(String text, Map map) {
    // TODO: implement onTextChanged
  }

  @override
  void ontap(Map? clickEvent) {
    log("profile $clickEvent");
    var res=splitByTapEvent(
        clickEvent,
        guid: General.profilePageIdentifier,
        widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
        queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
        myCallback: this
    );
    log("profile res $res");
  }
  @override
  openDrawer(MyCallback mc, Map clickEvent) {
    myCallback.ontap(clickEvent);
  }

  @override
  getCurrentPageWidgets() {
    // TODO: implement getCurrentPageWidgets
    throw UnimplementedError();
  }
}