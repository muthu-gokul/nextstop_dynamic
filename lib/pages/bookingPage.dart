import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/widgets/calculation.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/generalMethods.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:nextstop_dynamic/widgets/navIcon.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';

import 'dynamicPageInitiater.dart';
import 'estimateBill.dart';


class BookingPage extends StatelessWidget implements MyCallback{
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
    log("Booking PAge $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.openDrawer){
          myCallback.ontap(clickEvent);
        }
        else if(clickEvent[General.eventName]==General.locationClick){
          // log("$widgets");
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

          if(clickEvent['key']=='PickUp'){
            clickEvent['value']=location;
            findWidgetByKey(dynamicPageInitiater.dynamicPageInitiaterState.widgets,clickEvent,(wid){
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
        else if(clickEvent[General.eventName]=='FormSubmitBookingPage'){
         var res= General().formSubmit( General.bookingPageIdentifier, dynamicPageInitiater.dynamicPageInitiaterState.widgets[0].widget.widgets[1].widget.widget.widgets,clickEvent,dynamicPageInitiater.dynamicPageInitiaterState.queryString,myCallback: this);
         log("res $res");
         if(res !=null){
           Map resMap=jsonDecode(res);
           log("${dynamicPageInitiater.dynamicPageInitiaterState.widgets}");
           List qs=parseQueryString(resMap['FieldArray'],dynamicPageInitiater.dynamicPageInitiaterState.queryString);
        //   log("${parseQueryString(resMap['FieldArray'],dynamicPageInitiater.dynamicPageInitiaterState.queryString)}");
           var _distanceInMeters = Geolocator.distanceBetween(
             qs[1]['value'][0]['latitude'],
             qs[1]['value'][1]['longitude'],
             qs[3]['value'][0]['latitude'],
             qs[3]['value'][1]['longitude'],

           );
           qs.add({"key":"totalFare","value":"${Calculation().mul(dynamicPageInitiater.dynamicPageInitiaterState.widgets[0].widget.widgets[1].widget.widget.widgets[5].getValue()[0]['price'], _distanceInMeters/1000).toStringAsFixed(2)}"});
       //    log("_distanceInMeters $_distanceInMeters ${_distanceInMeters/1000} ${Calculation().mul(dynamicPageInitiater.dynamicPageInitiaterState.widgets[5].getValue()[0]['price'], _distanceInMeters/1000).toStringAsFixed(2)}");
           if(clickEvent.containsKey(General.navigateToPage)){
            // navigateTo(clickEvent['navigateToPage'],clickEvent['typeOfNavigation'],myCallback: myCallback);
            // getXNavigation(clickEvent[General.typeOfNavigation], EstimateBillPage(fromQueryString: qs,));
           }
         }
        }
      }
    }
  }
}
/*"child": {
        "type":"navIcon",
        "orderBy": "1",
        "color": "primaryColor",
        "margin": "20,0,0,0",
        "padding": "10,0,0,0",
        "borderRadius": "10,10,10,10",
        "width":40,
        "height":35,
        "clickEvent": {
          "eventName": "OpenDrawer"
        }
      }*/
/*,
    {
      "type": "button",
      "height": 400,
      "width": 1,
      "child": {
        "type":"stackController",
        "orderBy": "2",
        "children": [
          {
            "type":"positionController",
            "left": 0,
            "child": {
              "type":"navIcon",
              "orderBy": "1",
              "color": "primaryColor",
              "margin": "20,0,0,0",
              "padding": "10,0,0,0",
              "borderRadius": "10,10,10,10",
              "width":40,
              "height":35,
              "clickEvent": {
                "eventName": "OpenDrawer"
              }
            }
          }


        ]
      }
    }*/