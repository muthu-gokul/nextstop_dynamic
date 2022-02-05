import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import '../dynamicPageInitiater.dart';



class ProfilePageDriver extends StatelessWidget implements MyCallback{
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
  void onMapLocationChanged(Map map) {

  }

  @override
  void onTextChanged(String text, Map map) {

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
          log("$position");
          List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
          String delim1=placemarks.first.thoroughfare.toString().isNotEmpty?", ":"";
          String delim2=placemarks.first.subLocality.toString().isNotEmpty?", ":"";
          String delim3=placemarks.first.administrativeArea.toString().isNotEmpty?", ":"";
          String location = placemarks.first.name.toString() +
              delim1 +  placemarks.first.thoroughfare.toString()+
              delim2+placemarks.first.subLocality.toString()+
              delim3 +placemarks.first.administrativeArea.toString();
          // log("$placemarks ${placemarks[0]}");
          log("$location");

          if(clickEvent['key']=='Address'){
            clickEvent['value']=location;
            findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,clickEvent,(wid){
              findAndUpdateTextEditingController(wid,clickEvent);
            });

          }



        }
        else if(clickEvent[General.eventName]==General.Navigation){
          General().navigation(clickEvent[General.navigateToPage],clickEvent[General.typeOfNavigation]);
        }
      }
    }
  }
}