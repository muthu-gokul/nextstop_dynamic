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

class LoginPage extends StatelessWidget implements MyCallback{
  LoginPage(){

    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.loginPageIdentifier,
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
    log("login Click $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.FormSubmit){
          //  log("$widgets");
          var res= General().formSubmit(General.loginPageIdentifier, dynamicPageInitiater.dynamicPageInitiaterState.widgets,clickEvent,dynamicPageInitiater.dynamicPageInitiaterState.queryString,myCallback: this);
          if(res!=null){

            if(fromUrl){
              Get.defaultDialog(
                  title: "",
                  content: CircularProgressIndicator()
              );
              GetUiNotifier().postUiJson( 0, General.loginPageIdentifier, res,clickEvent).then((value){
                Get.back();
                log("login $value");
                var parsed=jsonDecode(value);
                log("$parsed");
                LOGINUSERID=parsed['Table'][0]['UserId'];
                if(clickEvent.containsKey(General.navigateToPage)){
                  getXNavigation(clickEvent[General.typeOfNavigation],getPage(clickEvent[General.navigateToPage]));
                }
              });
            }
            else{
              getXNavigation(clickEvent[General.typeOfNavigation],getPage(clickEvent[General.navigateToPage]));
            }

          }
          log("resultt $res");
        }
        else if(clickEvent[General.eventName]==General.Navigation){
          getXNavigation(clickEvent[General.typeOfNavigation],getPage(clickEvent[General.navigateToPage]));
        }
      }
    }
  }
}

