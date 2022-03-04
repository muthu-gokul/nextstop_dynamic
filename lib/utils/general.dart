import 'dart:convert';
import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
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

import '../pages/driver/bankDetails.dart';
import '../pages/driver/newRides.dart';
import '../styles/style.dart';
class General{


  checkApiCall(Map clickEvent,var res,String pageId) async{
    var val="";
    Get.defaultDialog(
        title: "",
        content: CircularProgressIndicator(),
        barrierDismissible: false,
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

  getPage(String page, {MyCallback? myCallback}){
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
        return ManageDocuments(profilePageDriverCallback: myCallback!,);
      case 'BankDetails':
        return BankDetails(profilePageDriverCallback: myCallback!,);
      case 'NewRides':
        return NewRides(driverTripHomePageCb: myCallback!,);
    }
    return Container();
  }


  showAlertPopUp(String message){
    Get.defaultDialog(
        title: "",
        titleStyle: TextStyle(height: 0.0),
        middleTextStyle: TextStyle(height: 0.0),
        middleText: "",
        content: Column(
          children: [
            Image.asset("assets/icons/sucess.gif",height: 150,),
            SizedBox(height: 15,),
            Text("$message",style: ts18(primaryTextColor2),textAlign: TextAlign.center,),
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
  static String driverBankDetailsIdentifier="DRIV-ADDB-ANKD-ET54";
  static String driverTripHomePageIdentifier="DRIV-ERTR-IPHO-ME33";
  static String driverMyTripsPageIdentifier="YOUR-TRIP-DRIV-ER89";
  static String driverNewTripsIdentifier="NEWO-RDER-SDRIV-4343";



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
  static String openDialog="openDialog";
}


