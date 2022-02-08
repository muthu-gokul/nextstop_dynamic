import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/notifier/getUiNotifier.dart';
import 'package:nextstop_dynamic/pages/dynamicPageInitiater.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import '../../../constants.dart';
import 'generalMethods.dart';
import 'package:get/get.dart';
class General{

   formSubmit(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}){
    return formSubmitMethod(guid, widgets,clickEvent,queryString,myCallback: myCallback);
  }


  void navigation(String page,int? typeOfNavigation){
    navigateTo(page,typeOfNavigation);
  }

  checkAndNavigate(Map clickEvent){
    if(clickEvent.containsKey(navigateToPage)){
      getXNavigation(clickEvent[typeOfNavigation],getPage(clickEvent[navigateToPage]));
    }
  }

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

   String loginPageIdentifier="LOGI-N567-3457-9876";
   String registrationPageIdentifier="REGI-STRA-TION-9876";
  static String homePageIdentifier="HOME-PAGE-3434-9898";
  static String homePageDriverIdentifier="HOME-PAGE-DRIV-ER98";
  static String profilePageIdentifier="PROF-ILE1-3434-6566";
  static String profilePageDriverIdentifier="PROF-ILE1-DRIV-ER66";
  static String bookingPageIdentifier="BOOK-INGP-AGE1-7355";
  static String estimateBillPageIdentifier="ESTI-MATE-BILL-5698";
  static String scheduleRidePageIdentifier="SCHE-DULE-RIDE-5867";
  static String myTripsPageIdentifier="YOUR-TRIP-6234-5867";
  static String manageDocPageIdentifier="MANA-GEDO-CUME-5455";
  static String driverTripHomePageIdentifier="DRIV-ERTR-IPHO-ME33";
  static String driverMyTripsPageIdentifier="YOUR-TRIP-DRIV-ER89";



  static String eventName="eventName";
  static String FormSubmit="FormSubmit";
  static String Navigation="Navigation";
  static String openDrawer="OpenDrawer";
  static String locationClick="locationClick";
  static String navigateToPage="navigateToPage";
  static String typeOfNavigation="typeOfNavigation";
  static String actionType="actionType";
}



String err001="Error 001";//INVALID JSON RESULT SET
String err002="No Page Found";

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  /*if (!serviceEnabled) {
      return Future.error('Location services are disabled ${serviceEnabled}.');
    }*/
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

