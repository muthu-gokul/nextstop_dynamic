import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/generalMethods.dart';
import 'package:nextstop_dynamic/widgets/customPopUp.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../widgets/customControllers/callBack/common.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'driver/homePageDriver.dart';
import 'dynamicPageInitiater.dart';
import 'homePage.dart';

class LoginPage extends StatelessWidget with General,Common  implements MyCallback{
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
/*    return Scaffold(
     body: Container(
       child: Column(
         children: [
           CustomPopup(
                                                        hintText: "Select State",
                                                        data: ["Tamilnadu","Andhra Pradesh","Kerala"],
                                                        selectedValue: "",
                                                        width:SizeConfig.screenWidth!-10 ,
                                                        leftMargin: 0,
                                                        edgeInsets: EdgeInsets.only(left: 0,top: 50),
                                                        onSelect: (v){},
                                                      ),
         ],
       ),
     ),
   ); */
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

    // checkTapFunc.splitByTapEvent(clickEvent);
    var res=splitByTapEvent(
      clickEvent,
      guid: loginPageIdentifier,
      widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
      queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
      myCallback: this
    );
    log("Common res $res");

    if(res!=null){
      if(fromUrl){
        var apires=await checkApiCall(clickEvent!, res, loginPageIdentifier);
        log("apires $apires");
        if(apires.toString().isNotEmpty){
          var parsed=jsonDecode(apires);
          log("login parsed $parsed");
          LOGINUSERID=parsed['Table'][0]['UserId'];
          isDriver=parsed['Table'][0]['IsDriver'];


          SharedPreferences sp=await SharedPreferences.getInstance();
          sp.setBool(ISLOGGEDINKEY, true);
          sp.setBool(ISDRIVERKEY, isDriver);
          sp.setInt(LOGINUSERIDKEY, LOGINUSERID);

          if(isDriver){
            getXNavigation(2, HomePageDriver2());
          }
          else{
            getXNavigation(2, HomePage());
          }

        }
      }
      else{
        //checkAndNavigate(clickEvent);
        SharedPreferences sp=await SharedPreferences.getInstance();
        sp.setBool(ISLOGGEDINKEY, true);
        sp.setInt(LOGINUSERIDKEY, 0);
        getXNavigation(2, HomePageDriver2());
      }
    }
  }
/*  @override
  void formSubmitMethodTFE() {
    log("form Login Override");
    //super.formSubmitMethodTFE();
  }*/

}

