import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:nextstop_dynamic/widgets/navIcon.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';

import 'dynamicPageInitiater.dart';

/*class BookingPage extends StatefulWidget {
  MyCallback myCallback;
  BookingPage({required this.myCallback});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  List<dynamic> widgets=[];
  var parsedJson;

  String guid="";

  parseJson() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/${ General.bookingPageIdentifier}.json");
    parsedJson=jsonDecode(data);

    guid= General.bookingPageIdentifier;
    if(widget.myCallback==null){
      widgets=getWidgets(parsedJson['Widgets'],widget.myCallback);
    }
    else{
      widgets=getWidgets(parsedJson['Widgets'],widget.myCallback);
    }

    setState(() {});
    log("$widgets");
  }

  @override
  void initState() {
    parseJson();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child:Stack(

        children: [
          Container(
            height: 30,
          ),
          Positioned(child: Text("hello")),
          for(int i=0;i<widgets.length;i++)
            widgets[i]
        ],
      )
    );
   // return widgets.isNotEmpty?widgets[0]:Container();
  }
}*/

class BookingPage extends StatelessWidget {
  MyCallback myCallback;
  BookingPage({required this.myCallback});
  @override
  Widget build(BuildContext context) {
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