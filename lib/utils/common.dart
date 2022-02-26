
import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/general.dart';
import 'package:dynamicparsers/customControllers/callBack/generalMethods.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/constants.dart';
import 'package:nextstop_dynamic/utils/general.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/dynamicPageInitiater.dart';
import 'colorUtil.dart';






class Common{
  findUpdateByKeyWidgetType(List valueArray ,List widgets){
    valueArray.forEach((element) {
      findWidgetByKey(widgets,element,(wid){
       // log("query wid $wid ${wid.getType()}");
        updateByWidgetType(wid.getType(),widget: wid,clickEvent: element);
      });
    });
  }


  splitByTapEvent(Map? clickEvent,{dynamic guid,List<dynamic> widgets=const [],List queryString=const [],MyCallback? myCallback}){
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.FormSubmit){
          return formSubmitMethodTFE(guid,widgets,clickEvent,queryString,myCallback: myCallback);
        }
        else if(clickEvent[General.eventName]==General.Navigation){
          return checkAndNavigate(clickEvent,myCallback);
        }
        else if(clickEvent[General.eventName]==General.openDrawer){
          return openDrawer(myCallback!, clickEvent);
        }
        else if(clickEvent[General.eventName]==General.locationClick){
           return locationClick(clickEvent);
        }
        else if(clickEvent[General.eventName]=='FormSubmitBookingPage'){
          return formSubmitBookingPage(guid, widgets,clickEvent,queryString,myCallback: myCallback);
        }
        else if(clickEvent[General.eventName]=='FormSubmitEstimateBill'){
          return formSubmitEstimateBill(guid, widgets,clickEvent,queryString,[],myCallback: myCallback);
        }
        else if(clickEvent[General.eventName]=='FormSubmitScheduleRide'){
          return formSubmitScheduledRide(guid, widgets, clickEvent, queryString);
        }
        else if(clickEvent[General.eventName]==General.changeValues){
          findUpdateByKeyWidgetType(clickEvent[General.changeValuesArray], widgets);
        }
        else if(clickEvent[General.eventName]==General.formDataJson_ApiCall){
          formDataJsonApiCallResponse(guid, widgets, clickEvent, queryString);
        }
        else if(clickEvent[General.eventName]==General.openMap){
          openMap(clickEvent);
        }
        else if(clickEvent[General.eventName]==General.openDialer){
          openDialer(clickEvent);
        }
      }
    }
  }


  formSubmitMethodTFE(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}){
    log("Form Submit CheckTapFunc Common");
    return formSubmitMethod(guid, widgets,clickEvent,queryString,);
  }

  checkAndNavigate(Map clickEvent,MyCallback? myCallback){
    if(clickEvent.containsKey(General.navigateToPage)){
      getXNavigation(clickEvent[General.typeOfNavigation],General().getPage(clickEvent[General.navigateToPage],myCallback: myCallback));
    }
  }

  openDrawer(MyCallback myCallback,Map clickEvent){
    myCallback.ontap(clickEvent);
  }

  locationClick(Map clickEvent){}
  formSubmitBookingPage(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}){}
  formSubmitEstimateBill(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,List scheduleRideList,{MyCallback? myCallback}){}

  formDataJsonApiCall(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}) async {
    var res=formSubmitMethodTFE(guid, widgets, clickEvent, queryString);
    log("formDataJsonApiCall formSubmitMethodTFE $res");
    if(res!=null && fromUrl){
      var apiResponse=await General().checkApiCall(clickEvent, res, guid);
      //log("accept Ride apiRes $apiRes");
      if(apiResponse.toString().isNotEmpty){
        return apiResponse.toString();
      }
      return null;
    }
    else if(!fromUrl){
      checkAndNavigate(clickEvent,myCallback);
    }
    return null;
  }
  formDataJsonApiCallResponse(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}) async {
    var apiResponse=await formDataJsonApiCall(guid, widgets, clickEvent, queryString);
    if(apiResponse!=null){
      checkAndNavigate(clickEvent,myCallback);
    }
    else{
      return apiResponse;
    }

  }

  openMap(Map clickEvent) async{
    log("open Map $clickEvent");
    Position position=await determinePosition();
    //String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${clickEvent['loc_Details']['lat']},${clickEvent['loc_Details']['long']}';
    String googleUrl ='https://www.google.com/maps/dir/?api=1&origin=${position.latitude},${position.longitude}&destination=${clickEvent['loc_Details']['lat']},${clickEvent['loc_Details']['long']}&travelmode=driving';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
    throw 'Could not open the map.';
    }
  }

  formSubmitScheduledRide(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString){}

  openDialer(Map clickEvent){
    launch("tel://${clickEvent['mobileNumber']}");
  }

  Color parseColor(String color){
    color = color.toUpperCase().replaceAll("*", "");
    if(color.toUpperCase()=="primaryColor".toUpperCase()){
      return ColorUtil.primaryColor;
    }
    else if(color.toUpperCase()=="primaryColor2".toUpperCase()){
      return ColorUtil.primaryColor2;
    }
    else if(color.toUpperCase()=="primaryTextColor1".toUpperCase()){
      return ColorUtil.primaryTextColor1;
    }
    else if(color.toUpperCase()=="primaryTextColor2".toUpperCase()){
      return ColorUtil.primaryTextColor2;
    }
    else if(color.toUpperCase()=="primaryTextColor3".toUpperCase()){
      return ColorUtil.primaryTextColor3;
    }
    else if(color.toUpperCase()=="textFieldBorderColor".toUpperCase()){
      return ColorUtil.textFieldBorderColor;
    }
    else if(color.toUpperCase()=="errorTextColor".toUpperCase()){
      return ColorUtil.errorTextColor;
    }
    else if(color.toUpperCase()=="rating".toUpperCase()){
      return ColorUtil.rating;
    }

    return Colors.transparent;
  }
}
