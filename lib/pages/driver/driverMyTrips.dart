import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import '../dynamicPageInitiater.dart';



class DriverMyTrips extends StatelessWidget {
  MyCallback myCallback;
  DriverMyTrips({required this.myCallback});
  @override
  Widget build(BuildContext context) {
    return DynamicPageInitiater(
      pageIdentifier: General.driverMyTripsPageIdentifier,
      myCallback: myCallback,
    );
  }
}