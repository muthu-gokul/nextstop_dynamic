import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import 'dynamicPageInitiater.dart';


class ScheduleRidePage extends StatelessWidget {
  MyCallback myCallback;
  ScheduleRidePage({required this.myCallback}){
    dynamicPageInitiater=DynamicPageInitiater(
      pageIdentifier: General.scheduleRidePageIdentifier,
      myCallback: myCallback,
    );
  }
  late DynamicPageInitiater dynamicPageInitiater;
  @override
  Widget build(BuildContext context) {
    // return dynamicPageInitiater;
    return dynamicPageInitiater;
  }
}