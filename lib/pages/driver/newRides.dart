import 'dart:convert';
import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/utils/common.dart';
import 'package:nextstop_dynamic/utils/general.dart';


import '../../styles/style.dart';
import '../dynamicPageInitiater.dart';



class NewRides extends StatelessWidget with Common, MyCallback{
  MyCallback driverTripHomePageCb;
  NewRides({required this.driverTripHomePageCb}){
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.driverNewTripsIdentifier,
      myCallback: this,
    );
  }
  late DynamicPageInitiater dynamicPageInitiater;
  @override
  Widget build(BuildContext context) {
    /*return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (xtc,i){
          return  Container(
            child: Column(
              children: [
                Container(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Container(
                          width: 80,
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset("assets/icons/pickup-location.svg",height: 20,),
                                Expanded(
                                  child: Container(
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                  ),
                                ),
                                SvgPicture.asset("assets/icons/drop-location.svg",height: 20,),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(child: Container(child: Text("yyyyy ",))),
                                  Expanded(child: Container(child: Text("yyyyy ",))),
                                ],
                              ),
                            ),


                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );*/
    return dynamicPageInitiater;
  }


  @override
  Future<void> ontap(Map? clickEvent) async {
    log("NewRides  $clickEvent");
    splitByTapEvent(
        clickEvent,
        widgets: dynamicPageInitiater.dynamicPageInitiaterState.widgets,
        queryString: dynamicPageInitiater.dynamicPageInitiaterState.queryString,
        myCallback: this,
        guid: General.driverNewTripsIdentifier
    );
  }

  @override
  reloadPage() {
    dynamicPageInitiater.dynamicPageInitiaterState.initSS();
  }

  @override
  formDataJsonApiCallResponse(guid, List widgets, Map clickEvent, List queryString, {MyCallback? myCallback}) async{
    log("NewRidesformDataJsonApiCallResponse $clickEvent");
    var apiRes=await formDataJsonApiCall(guid, widgets, clickEvent, queryString);
    log("NewRides apiRes $apiRes");
    if(apiRes!=null){
      var parsed=jsonDecode(apiRes);
      reloadPage();
      driverTripHomePageCb.reloadPage();
      General().showAlertPopUp("${parsed['TblOutPut'][0]['@Message']}");
    }
  }

}