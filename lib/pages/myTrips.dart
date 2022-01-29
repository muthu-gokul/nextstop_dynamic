import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import 'dynamicPageInitiater.dart';

class MyTrips extends StatelessWidget {
  MyCallback myCallback;
  MyTrips({required this.myCallback});
  @override
  Widget build(BuildContext context) {
    return DynamicPageInitiater(
      pageIdentifier: General.myTripsPageIdentifier,
      myCallback: myCallback,
    );
  }
}