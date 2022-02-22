import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/general.dart';
import 'package:dynamicparsers/customControllers/callBack/generalMethods.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:nextstop_dynamic/utils/general.dart';
import 'package:nextstop_dynamic/widgets/calculation.dart';
import 'package:nextstop_dynamic/utils/common.dart';


import '../dynamicPageInitiater.dart';
import 'estimateBill.dart';
import 'homePage.dart';


class BookingPage extends StatelessWidget with Common, MyCallback{
  MyCallback myCallback;
  BookingPage({required this.myCallback}){
      dynamicPageInitiater=DynamicPageInitiater(
         pageIdentifier: General.bookingPageIdentifier,
         myCallback: this,
         isScrollControll: true,
      );
  }
 late DynamicPageInitiater dynamicPageInitiater;


  @override
  Widget build(BuildContext context) {
    return dynamicPageInitiater;

  }

  @override
  void onMapLocationChanged(Map map) {
    log("Booking PAge map  $map");
    if(map['key']=="PickUp"){
      findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,{"key":map['key'],"value":map['location']},(wid){
        findAndUpdateTextEditingController(wid,{"key":map['key'],"value":map['location']});
      });
      findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,{"key":"PickUp_Loc_Details"},(wid){
        log("wid $wid ${wid.map}");
        wid.map['value'][0]['latitude']=map['latitude'];
        wid.map['value'][1]['longitude']=map['longitude'];
      });

    }
    else if(map['key']=="Drop"){
      findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,{"key":map['key'],"value":map['location']},(wid){
        findAndUpdateTextEditingController(wid,{"key":map['key'],"value":map['location']});
      });
      findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,{"key":"Drop_Loc_Details"},(wid){
        wid.map['value'][0]['latitude']=map['latitude'];
        wid.map['value'][1]['longitude']=map['longitude'];
      });
    }

  }

  @override
  void onTextChanged(String text, Map map) {
    // TODO: implement onTextChanged
  }

  @override
  Future<void> ontap(Map? clickEvent) async {
    log("Booking PAge $clickEvent ${dynamicPageInitiater.dynamicPageInitiaterState.widgets}");
    if(clickEvent!['eventName']=="reload"){
      selectedPage.value=99;
      Timer(Duration(milliseconds: 300), (){
        selectedPage.value=1;
      });
      //selectedPage.value=1;
    }
    else{
      splitByTapEvent(
          clickEvent,
          guid: General.bookingPageIdentifier,
          widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
          queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
          myCallback: this
      );
    }

  }

  @override
  openDrawer(MyCallback mc, Map clickEvent) {
    myCallback.ontap(clickEvent);
  }

  @override
  locationClick(Map clickEvent) async {
      Position? position;
      position=await determinePosition();
/*      var googleGeocoding = GoogleGeocoding("AIzaSyCgWfUF_HEBqd5qjN7afJADJcZJOwXOgao");
      var result = await googleGeocoding.geocoding.getReverse(LatLon(position.latitude,position.longitude));*/

     //  log("mapRes ${result!.status}");
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,localeIdentifier: "en");
      String delim1=placemarks.first.thoroughfare.toString().isNotEmpty?", ":"";
      String delim2=placemarks.first.subLocality.toString().isNotEmpty?", ":"";
      String delim3=placemarks.first.administrativeArea.toString().isNotEmpty?", ":"";
      String location = placemarks.first.name.toString() +
                        delim1 +  placemarks.first.thoroughfare.toString()+
                        delim2+placemarks.first.subLocality.toString()+
                        delim3 +placemarks.first.administrativeArea.toString();
      // log("$placemarks ${placemarks[0]}");
      log("$location");

      if(clickEvent['key']=='PickUp'){
        clickEvent['value']=location;
        findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,clickEvent,(wid){
            log("wid 121 $wid");
            findAndUpdateTextEditingController(wid,clickEvent);
        });
        findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,{"key":"map01"},(wid){
            //log("wid $wid");
            wid.isPickUpLocation.value=true;
            wid.animateCamera(position);
        });
        findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,{"key":"PickUp_Loc_Details"},(wid){
            wid.map['value'][0]['latitude']=position!.latitude;
            wid.map['value'][1]['longitude']=position.longitude;
        });

      }
      else if(clickEvent['key']=='Drop'){
        clickEvent['value']=location;
        findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,clickEvent,(wid){
              findAndUpdateTextEditingController(wid,clickEvent);
        });
        findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,{"key":"map01"},(wid){
              log("wid $wid");
              wid.isPickUpLocation.value=false;
              wid.animateCamera(position);
        });
        findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,{"key":"Drop_Loc_Details"},(wid){
              wid.map['value'][0]['latitude']=position!.latitude;
              wid.map['value'][1]['longitude']=position.longitude;
        });
      } 
    }

  @override
  formSubmitBookingPage(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}) {
    var res= formSubmitMethodTFE(guid, dynamicPageInitiater.dynamicPageInitiaterState.widgets, clickEvent, queryString);
    log("res1 $res");
    if(res!=null){
       Map resMap=jsonDecode(res);
          
           List qs=parseQueryString(resMap['FieldArray'],dynamicPageInitiater.dynamicPageInitiaterState.queryString);
           log("qs ${dynamicPageInitiater.dynamicPageInitiaterState.queryString}");
           var _distanceInMeters = Geolocator.distanceBetween(
             qs[1]['value'][0]['latitude'],
             qs[1]['value'][1]['longitude'],
             qs[3]['value'][0]['latitude'],
             qs[3]['value'][1]['longitude'],

           );
           double price=0.0;
           qs.forEach((element) {
             if(element['key']=="SelectedVehicle"){
                price=double.parse(element['value']['price'].toString());
             }
             print("ele $element");
           });
           qs.add({"key":"totalFare","value":"${Calculation().mul(price, _distanceInMeters/1000).toStringAsFixed(2)}"});
           qs.add({"key":"totalDistance","value":"${_distanceInMeters/1000}"});
           if(clickEvent.containsKey(General.navigateToPage)){
             getXNavigation(clickEvent[General.typeOfNavigation], EstimateBillPage(fromQueryString: qs,parentCb: this,));
           }
    }
  }
}
