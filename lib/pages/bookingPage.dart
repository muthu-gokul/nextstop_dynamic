import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/widgets/calculation.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/common.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/generalMethods.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import 'dynamicPageInitiater.dart';
import 'estimateBill.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message}");
}
class BookingPage extends StatelessWidget with Common  implements MyCallback{
  MyCallback myCallback;
  BookingPage({required this.myCallback}){
      dynamicPageInitiater=DynamicPageInitiater(
         pageIdentifier: General.bookingPageIdentifier,
         myCallback: this,
         isScrollControll: true,
      );

      try{
        log("_messaging.app.name ${_messaging.app.name}");
      }
      catch(e){

      }

        registerNotification();
        checkForInitialMessage();


  }
 late DynamicPageInitiater dynamicPageInitiater;

  late final FirebaseMessaging _messaging;
  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message title Open User: ${message.messageId} ${message.notification?.title}, BODY: ${message.notification?.body}, DATA: ${message.data['valueArray'].runtimeType} ${jsonDecode(message.data['valueArray'])}');
        onNotificationReceived(jsonDecode(message.data['valueArray']));
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('onMessage Click OpenedApp title User: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
        onNotificationReceived(jsonDecode(message.data['valueArray']));
      });

    } else {
      print('User declined or has not accepted permission');
    }
  }
  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      onNotificationReceived(jsonDecode(initialMessage.data['valueArray']));
    }
  }
  onNotificationReceived(List valueArray){
    log("VA $valueArray");
  }



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
    log("Booking PAge $clickEvent");
    var res=splitByTapEvent(
      clickEvent,
      guid: General.bookingPageIdentifier,
      widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
      queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
      myCallback: this
    );
    log("Booking PAge res $res");
   /*  if(clickEvent!=null){
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
           log("${dynamicPageInitiater.dynamicPageInitiaterState.queryString}");
           List qs=parseQueryString(resMap['FieldArray'],dynamicPageInitiater.dynamicPageInitiaterState.queryString);
           log("qs $qs");
        //   log("${parseQueryString(resMap['FieldArray'],dynamicPageInitiater.dynamicPageInitiaterState.queryString)}");
           var _distanceInMeters = Geolocator.distanceBetween(
             qs[1]['value'][0]['latitude'],
             qs[1]['value'][1]['longitude'],
             qs[3]['value'][0]['latitude'],
             qs[3]['value'][1]['longitude'],

           );
          // log("vv ${dynamicPageInitiater.dynamicPageInitiaterState.widgets[0].widget.widgets[1].widget.widget.widgets[5].getValue()}");
           qs.add({"key":"totalFare","value":"${Calculation().mul(dynamicPageInitiater.dynamicPageInitiaterState.widgets[0].widget.widgets[1].widget.widget.widgets[5].getValue()['price'], _distanceInMeters/1000).toStringAsFixed(2)}"});
       //    log("_distanceInMeters $_distanceInMeters ${_distanceInMeters/1000} ${Calculation().mul(dynamicPageInitiater.dynamicPageInitiaterState.widgets[5].getValue()[0]['price'], _distanceInMeters/1000).toStringAsFixed(2)}");
           if(clickEvent.containsKey(General.navigateToPage)){

             getXNavigation(clickEvent[General.typeOfNavigation], EstimateBillPage(fromQueryString: qs,));
           }
         }
        }
      }
    } */
  }
  @override
  openDrawer(MyCallback mc, Map clickEvent) {
    myCallback.ontap(clickEvent);
  }
  @override
  locationClick(Map clickEvent) async {
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
      //log("$location");

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
                price=double.parse(element['value']['price'].toString()??"0.0");
             }
             print("ele $element");
           });
           qs.add({"key":"totalFare","value":"${Calculation().mul(price, _distanceInMeters/1000).toStringAsFixed(2)}"});
           qs.add({"key":"totalDistance","value":"${_distanceInMeters/1000}"});
           if(clickEvent.containsKey(General.navigateToPage)){
             getXNavigation(clickEvent[General.typeOfNavigation], EstimateBillPage(fromQueryString: qs,));
           }
    }
  }  
}
