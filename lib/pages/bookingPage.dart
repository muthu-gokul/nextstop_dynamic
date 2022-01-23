import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:nextstop_dynamic/widgets/navIcon.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';

import 'dynamicPageInitiater.dart';


class BookingPage extends StatelessWidget {
  MyCallback myCallback;
  BookingPage({required this.myCallback}){
      /*dynamicPageInitiater=DynamicPageInitiater(
        pageIdentifier: General.bookingPageIdentifier,
        myCallback: myCallback,
      );*/
  }
 // late DynamicPageInitiater dynamicPageInitiater;
  @override
  Widget build(BuildContext context) {
   // return dynamicPageInitiater;
    return DynamicPageInitiater(
      pageIdentifier: General.bookingPageIdentifier,
      myCallback: myCallback,
    );
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