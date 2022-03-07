import 'dart:convert';
import 'dart:developer';
import 'package:dynamicparsers/customControllers/callBack/generalMethods.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:dynamicparsers/widgets/sizeLocal.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/main.dart';
import 'package:nextstop_dynamic/utils/general.dart';
import 'package:nextstop_dynamic/widgets/customPopUp.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../styles/style.dart';
import '../utils/common.dart';

import 'driver/homePageDriver.dart';
import 'dynamicPageInitiater.dart';
import 'user/homePage.dart';

class ForgotPassword extends StatelessWidget with Common,MyCallback{
  ForgotPassword(){

    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.forgotPasswordIdentifier,
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
    log("ForgotPassword Click $clickEvent");
    if(clickEvent!["eventName"]=="alertOTP"){
      Get.defaultDialog(
          title: "",
          titleStyle: TextStyle(height: 0.0),
          middleTextStyle: TextStyle(height: 0.0),
          middleText: "",
          content: Column(
            children: [
              Icon(Icons.error_outline,color: Colors.red,size: 50,),
              SizedBox(height: 15,),
              Text("${clickEvent["message"]} ",style: ts18(primaryTextColor2),textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: primaryColor
                  ),
                  alignment: Alignment.center,
                  child: Text("Ok",style: ts15(Colors.white),),
                ),
              )
            ],
          )
      );
    }
    else{
      splitByTapEvent(
          clickEvent,
          guid: General.forgotPasswordIdentifier,
          widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
          queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
          myCallback: this
      );
    }

  }

  @override
  formDataJsonApiCallResponse(guid, List widgets, Map clickEvent, List queryString, {MyCallback? myCallback}) async{
    var apiRes=await formDataJsonApiCall(guid, widgets, clickEvent, queryString);
    log("login apiRes 87 $apiRes");
    if(apiRes!=null){

    }
  }
}

