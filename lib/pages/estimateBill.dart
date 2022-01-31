import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import 'dynamicPageInitiater.dart';

class EstimateBillPage extends StatelessWidget {
  List<dynamic> fromQueryString;
 // MyCallback myCallback;
  EstimateBillPage({required this.fromQueryString,});
  @override
  Widget build(BuildContext context) {
    return DynamicPageInitiater(
      pageIdentifier: General.estimateBillPageIdentifier,
      fromQueryString: fromQueryString,
    // myCallback: myCallback,
     // myCallback: myCallback,
    );
  }
}