import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import 'dynamicPageInitiater.dart';

class EstimateBillPage extends StatelessWidget {
/*  MyCallback myCallback;
  EstimateBillPage({required this.myCallback});*/
  @override
  Widget build(BuildContext context) {
    return DynamicPageInitiater(
      pageIdentifier: General.estimateBillPageIdentifier,
     // myCallback: myCallback,
    );
  }
}