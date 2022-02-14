import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextstop_dynamic/notifier/getUiNotifier.dart';
import 'package:nextstop_dynamic/styles/style.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/common.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/generalMethods.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import '../constants.dart';
import 'dynamicPageInitiater.dart';
import 'homePage.dart';

class EstimateBillPage extends StatelessWidget with Common implements MyCallback{
  List<dynamic> fromQueryString;
  MyCallback? parentCb;
  EstimateBillPage({required this.fromQueryString, this.parentCb}){
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.estimateBillPageIdentifier,
      fromQueryString: fromQueryString,
      myCallback: this,
    );
  }
  late DynamicPageInitiater dynamicPageInitiater;
  @override
  Widget build(BuildContext context) {
    return dynamicPageInitiater ;
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
    log("EstimateBillPage $clickEvent");
    var res=splitByTapEvent(
        clickEvent,
        guid: General.estimateBillPageIdentifier,
        widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
        queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
        myCallback: this
    );
    log("EstimateBillPage res $res");
  }

  @override
  formSubmitEstimateBill(guid, List widgets, Map clickEvent, List queryString, {MyCallback? myCallback}) {
    print("EstimateBillPage formSubmitEstimateBill $guid $widgets");
    var res = General().formSubmit(guid, widgets,clickEvent,queryString,myCallback: this);
    log("ress $res");
    if(res!=null){
      if(fromUrl){
        GetUiNotifier().postUiJson(LOGINUSERID,guid, res, clickEvent).then((value){
          log("sp value-- $value");
          getXNavigation(3, Container());
          parentCb!.ontap({"eventName":"reload"});
          Get.defaultDialog(
              title: "",
              titleStyle: TextStyle(height: 0.0),
              middleTextStyle: TextStyle(height: 0.0),
              middleText: "",
              content: Column(
                children: [
                  Image.asset("assets/icons/sucess.gif",height: 150,),
                  SizedBox(height: 15,),
                  Text("Your ride has been booked successfully",style: ts18(primaryTextColor2),textAlign: TextAlign.center,),
                  SizedBox(height: 15,),
                  Text("Track your ride details at Your Trips",style: ts15(primaryTextColor3),textAlign: TextAlign.center,),
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
        });
      }
      else{
        getXNavigation(3, Container());
        parentCb!.ontap({"eventName":"reload"});
        Get.defaultDialog(
          title: "",
          titleStyle: TextStyle(height: 0.0),
          middleTextStyle: TextStyle(height: 0.0),
          middleText: "",
          content: Column(
            children: [
              Image.asset("assets/icons/sucess.gif",height: 150,),
              SizedBox(height: 15,),
              Text("Your ride has been booked successfully",style: ts18(primaryTextColor2),textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Text("Track your ride details at Your Trips",style: ts15(primaryTextColor3),textAlign: TextAlign.center,),
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
        /*Get.dialog(Container(child: Column(
          children: [
            Text("Your Ride has been booked successfully")
          ],
        ),));*/
      }

    }
  }
}