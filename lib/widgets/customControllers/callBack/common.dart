
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../pages/dynamicPageInitiater.dart';
import 'general.dart';
import 'generalMethods.dart';
import 'myCallback.dart';





class Common{
  findUpdateByKeyWidgetType(List valueArray ,List widgets){
     valueArray.forEach((element) {
      findWidgetByKey(widgets,element,(wid){
         log("query wid $wid ${wid.getType()}");
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
          return checkAndNavigate(clickEvent);
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
      }
    }
  }


  formSubmitMethodTFE(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}){
    log("Form Submit CheckTapFunc");
    return formSubmitMethod(guid, widgets,clickEvent,queryString,myCallback: myCallback);
  }

  checkAndNavigate(Map clickEvent){
    if(clickEvent.containsKey(General.navigateToPage)){
      getXNavigation(clickEvent[General.typeOfNavigation],getPage(clickEvent[General.navigateToPage]));
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
    if(res!=null){
      var apiResponse=await General().checkApiCall(clickEvent, res, guid);
      //log("accept Ride apiRes $apiRes");
      if(apiResponse.toString().isNotEmpty){
        return apiResponse.toString();
      }
      return null;
    }
    return null;
  }
  formDataJsonApiCallResponse(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}){
    return formDataJsonApiCall(guid, widgets, clickEvent, queryString);
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
}
