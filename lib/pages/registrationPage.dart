import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';

import 'dynamicPageInitiater.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicPageInitiater(
      pageIdentifier: General.registrationPageIdentifier,
    );
  }
}

/*{
      "type":"rowController",
      "orderBy": "14",
      "mainAxisAlignment": "center",
      "children":[
        {
          "type": "button",
          "orderBy": "1",
          "key": 5,
          "clickEvent": {
            "eventName":"Navigation",
            "navigateToPage":"SecurityDetails",
            "typeOfNavigation":2
          },
          "height":50.0,
          "pixelWidth":50.0,
          "borderRadius": "25,25,25,25",
          "color":"#BABDA8"
        },
        {
          "type":"sizedBox",
          "orderBy": "2",
          "width":10
        },
        {
          "type": "button",
          "orderBy": "3",
          "key": 5,
          "clickEvent": {
            "eventName":"Navigation",
            "navigateToPage":"SecurityReports",
            "typeOfNavigation":1
          },
          "height":50.0,
          "pixelWidth":50.0,
          "borderRadius": "25,25,25,25",
          "color":"#BABDC8"
        },
        {
          "type":"sizedBox",
          "orderBy": "4",
          "width":10
        },
        {
          "type": "button",
          "orderBy": "5",
          "key": 5,
          "height":50.0,
          "pixelWidth":50.0,
          "borderRadius": "25,25,25,25",
          "color":"#ff0000"
        }
      ]
    }*/