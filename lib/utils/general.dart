import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/notifier/getUiNotifier.dart';
import 'package:nextstop_dynamic/pages/driver/homePageDriver.dart';
import 'package:nextstop_dynamic/pages/driver/manageDocuments.dart';

import 'package:nextstop_dynamic/pages/dynamicPageInitiater.dart';
import 'package:nextstop_dynamic/pages/loginPage.dart';
import 'package:nextstop_dynamic/pages/registrationPage.dart';
import 'package:nextstop_dynamic/pages/user/homePage.dart';

import '../../../constants.dart';
import 'package:get/get.dart';
class General{


  checkApiCall(Map clickEvent,var res,String pageId) async{
    var val="";
    Get.defaultDialog(
        title: "",
        content: CircularProgressIndicator()
    );
    await GetUiNotifier().postUiJson( LOGINUSERID, pageId, res,clickEvent).then((value){
      Get.back();
      log("vvvvv $value");
      if(value[0]){
        val=value[1];
      }
      else{
        Get.dialog(  CupertinoAlertDialog(
          title: Icon(Icons.error_outline,color: Colors.red,size: 50,),
          content: Text("${value[1]}",
            style: TextStyle(fontSize: 18),),
        ));
      }
      //val=value;

    });
    return val;
  }

  getPage(String page){
    switch(page){
      case 'HomePage':
        return HomePage();
      case 'Registration':
        return RegistrationPage();
      case 'Login':
        return LoginPage();
      case 'HomePageDriver':
        return HomePageDriver2();
      case 'ManageDocuments':
        return ManageDocuments();
    }
    return Container();
  }


  static String loginPageIdentifier="LOGI-N567-3457-9876";
  static String registrationPageIdentifier="REGI-STRA-TION-9876";
  static String setPasswordIdentifier="SETP-ASSW-ORD-5646";
  static String homePageIdentifier="HOME-PAGE-3434-9898";
  static String homePageDriverIdentifier="HOME-PAGE-DRIV-ER98";
  static String profilePageIdentifier="PROF-ILE1-3434-6566";
  static String profilePageDriverIdentifier="PROF-ILE1-DRIV-ER66";
  static String bookingPageIdentifier="BOOK-INGP-AGE1-7355";
  static String estimateBillPageIdentifier="ESTI-MATE-BILL-5698";
  static String scheduleRidePageIdentifier="SCHE-DULE-RIDE-5867";
  static String myTripsPageIdentifier="YOUR-TRIP-6234-5867";
  //static String myTripsPageIdentifier="yourtrip";
  static String manageDocPageIdentifier="MANA-GEDO-CUME-5455";
  static String driverTripHomePageIdentifier="DRIV-ERTR-IPHO-ME33";
  static String driverMyTripsPageIdentifier="YOUR-TRIP-DRIV-ER89";



  static String eventName="eventName";
  static String FormSubmit="FormSubmit";
  static String Navigation="Navigation";
  static String openDrawer="OpenDrawer";
  static String changeValues="ChangeValues";
  static String formDataJson_ApiCall="formDataJson_ApiCall";
  static String changeValuesArray="changeValuesArray";
  static String locationClick="locationClick";
  static String navigateToPage="navigateToPage";
  static String typeOfNavigation="typeOfNavigation";
  static String actionType="actionType";
  static String openMap="openMap";
  static String openDialer="OpenDialer";
}

