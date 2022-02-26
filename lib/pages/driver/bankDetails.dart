import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/utils/common.dart';
import 'package:nextstop_dynamic/utils/general.dart';


import '../../styles/style.dart';
import '../dynamicPageInitiater.dart';



class BankDetails extends StatelessWidget with Common, MyCallback{
  MyCallback profilePageDriverCallback;
  BankDetails({required this.profilePageDriverCallback}){
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.driverBankDetailsIdentifier,
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
    log("BankDetails doc $clickEvent");
    splitByTapEvent(
        clickEvent,
        widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
        queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
        myCallback: this,
        guid: General.driverBankDetailsIdentifier
    );
  }


  @override
  formDataJsonApiCallResponse(guid, List widgets, Map clickEvent, List queryString, {MyCallback? myCallback}) async{
    var apiRes=await formDataJsonApiCall(guid, widgets, clickEvent, queryString);
    log("BankDetails doc apiRes $apiRes");
    if(apiRes!=null){
      Get.defaultDialog(
          title: "",
          titleStyle: TextStyle(height: 0.0),
          middleTextStyle: TextStyle(height: 0.0),
          middleText: "",
          content: Column(
            children: [
              Image.asset("assets/icons/sucess.gif",height: 150,),
              SizedBox(height: 15,),
              Text("Bank Details have been Changed successfully",style: ts18(primaryTextColor2),textAlign: TextAlign.center,),
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
      dynamicPageInitiater.dynamicPageInitiaterState.initSS();
      profilePageDriverCallback.reloadPage();
    }
  }

}