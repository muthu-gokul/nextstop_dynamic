import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/constants.dart';
import 'package:nextstop_dynamic/notifier/getUiNotifier.dart';
import 'package:nextstop_dynamic/pages/homePage.dart';
import 'package:nextstop_dynamic/pages/profilePage.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/generalMethods.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:get/get.dart';
import 'dynamicPageInitiater.dart';

class LoginPage extends StatelessWidget with General implements MyCallback{
  LoginPage(){

    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: loginPageIdentifier,
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
  Future<void> ontap(Map? clickEvent) async {
    log("login Click $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.FormSubmit){
          log("${dynamicPageInitiater.dynamicPageInitiaterState.widgets}");
          var res= formSubmit(loginPageIdentifier, dynamicPageInitiater.dynamicPageInitiaterState.widgets,clickEvent,dynamicPageInitiater.dynamicPageInitiaterState.queryString,myCallback: this);
          log("login res $res");
          if(res!=null){

            if(fromUrl){
              var apires=await checkApiCall(clickEvent, res, loginPageIdentifier);
              log("apires $apires");
              if(apires.toString().isNotEmpty){
                var parsed=jsonDecode(apires);
                log("login parsed $parsed");
                LOGINUSERID=parsed['Table'][0]['UserId'];
                checkAndNavigate(clickEvent);
              }
            }
            else{
              checkAndNavigate(clickEvent);
            }

          }

        }
        else if(clickEvent[General.eventName]==General.Navigation){
          checkAndNavigate(clickEvent);
          //getXNavigation(clickEvent[General.typeOfNavigation],getPage(clickEvent[General.navigateToPage]));
        }
      }
    }
  }


}

