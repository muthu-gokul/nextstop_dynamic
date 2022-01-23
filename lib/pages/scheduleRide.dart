import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';

import 'dynamicPageInitiater.dart';


class ScheduleRidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return dynamicPageInitiater;
    return DynamicPageInitiater(
      pageIdentifier: General.scheduleRidePageIdentifier,
    );
  }
}