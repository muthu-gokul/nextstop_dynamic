import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/general.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/utils/common.dart';
import 'package:nextstop_dynamic/utils/general.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../dynamicPageInitiater.dart';



class ProfilePageDriver extends StatelessWidget with MyCallback,Common{
  MyCallback myCallback;
  ProfilePageDriver({required this.myCallback}){
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.profilePageDriverIdentifier,
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
    log("profile Driver $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.openDrawer){
          myCallback.ontap(clickEvent);
        }
        else if(clickEvent[General.eventName]==General.locationClick){
          Position? position;
          position=await determinePosition();
         // log("$position");
          List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
          String delim1=placemarks.first.thoroughfare.toString().isNotEmpty?", ":"";
          String delim2=placemarks.first.subLocality.toString().isNotEmpty?", ":"";
          String delim3=placemarks.first.administrativeArea.toString().isNotEmpty?", ":"";
          String location = placemarks.first.name.toString() +
              delim1 +  placemarks.first.thoroughfare.toString()+
              delim2+placemarks.first.subLocality.toString()+
              delim3 +placemarks.first.administrativeArea.toString();
          // log("$placemarks ${placemarks[0]}");
         // log("$location");

          if(clickEvent['key']=='Address'){
            // log("hh ${dynamicPageInitiater.dynamicPageInitiaterState.widgets}");
             clickEvent['value']=location;
            // SharedPreferences sp=await SharedPreferences.getInstance();
            // clickEvent['value']=sp.getString("token");
            findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,clickEvent,(wid){
              findAndUpdateTextEditingController(wid,clickEvent);
            });

          }
        }
        else{
          splitByTapEvent(
            clickEvent,
            widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
            queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
            myCallback: this,
            guid: General.profilePageDriverIdentifier
          );
        }
      }
    }
  }

  @override
  getCurrentPageWidgets() {
    return dynamicPageInitiater.dynamicPageInitiaterState.widgets;
  }

  @override
  reloadPage() {
    log("profile driver reloadPage");
    dynamicPageInitiater.dynamicPageInitiaterState.initSS();
  }
}