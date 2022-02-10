
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../pages/dynamicPageInitiater.dart';
import 'general.dart';
import 'generalMethods.dart';
import 'myCallback.dart';





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
}
