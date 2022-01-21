import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/utils.dart';
import '../widgets/customControllers/callBack/general.dart';
import '../widgets/sizeLocal.dart';
import '../notifier/getUiNotifier.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/customControllers/callBack/myCallback.dart';

class DynamicPageInitiater extends StatefulWidget {
  String pageIdentifier;
  MyCallback? myCallback;
  DynamicPageInitiater({required this.pageIdentifier,this.myCallback});
  @override
  _DynamicPageInitiaterState createState() => _DynamicPageInitiaterState();
}

class _DynamicPageInitiaterState extends State<DynamicPageInitiater> implements MyCallback{

  List<dynamic> widgets=[];
  var parsedJson;

  String guid="";

  parseJson() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/${widget.pageIdentifier}.json");
    parsedJson=jsonDecode(data);

    guid=widget.pageIdentifier;
    if(widget.myCallback==null){
      widgets=getWidgets(parsedJson['Widgets'],this);
    }
    else{
      widgets=getWidgets(parsedJson['Widgets'],widget.myCallback!);
    }

    setState(() {});
    log("${parsedJson}");
  }

  @override
  void initState() {
    if(fromUrl){
/*      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Provider.of<GetUiNotifier>(context, listen: false).getUiJson(context,LOGINPAGE_ID).then((value){
          // log("$value");
          if(value!="null"){
            var parsed=jsonDecode(value);
            //  print(parsed['table'][0]['jsonData']);
            parsedJson=jsonDecode(parsed['table'][0]['jsonData']);
            print(parsedJson);
            guid=parsedJson['Guid'];
            widgets=getWidgets(parsedJson['Widgets'],this);
          }
        });
      });*/
    }
    else{
      parseJson();
    }
    super.initState();
  }


  bool isValid=true;
  List<bool> validList=[];
  String selectedCategory="";
  ScrollController scrollController=new ScrollController();
  TextEditingController textEditingController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double topPad=MediaQuery.of(context).padding.top;
    double bottomPad=MediaQuery.of(context).padding.bottom;
    SizeConfig().init(context);
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body:parsedJson==null?Container(): Container(
         // alignment: Alignment.topCenter,
         // alignment: parseAlignment(parsedJson['alignment']),
          height: SizeConfig.screenHeight!-topPad,
          width: SizeConfig.screenWidth,
          color: Colors.white,
          child: SingleChildScrollView(
            controller: scrollController,
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: parseCrossAxisAlignment(parsedJson['crossAxisAlignment']),
              mainAxisAlignment: parseMainAxisAlignment(parsedJson['mainAxisAlignment']),
              //mainAxisSize: MainAxisSize.min,
              children: [
                for(int i=0;i<widgets.length;i++)
                  widgets[i],
                /*Container(
                  height: SizeConfig.screenHeight!-100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Hello"),
                      Text("Hello"),
                      Text("Hello"),
                    ],
                  ),
                )*/
                /*IntrinsicHeight(
                  child: Container(
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        Spacer(),
                        Text("Hello"),
                        Text("Hello"),
                        Text("Hello"),
                        Spacer(),
                      ],
                    ),
                  ),
                ),*/

              ],
            ),
          ),
        ),
      ),
    );
  }

/*
  var result={
    'Guid':1,
    'FieldArray':[

    ]
  };
*/

  @override
  void ontap(Map? clickEvent) {
    log("clickEvent $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey('eventName')){
        if(clickEvent['eventName']=='FormSubmit'){
          General().formSubmit(guid, widgets,clickEvent);
        }
        else if(clickEvent['eventName']=='Navigation'){
          General().navigation(clickEvent['navigateToPage'],clickEvent['typeOfNavigation']);
        }
      }
    }
  }
}







/*,
    {
      "type":"sizedBox",
      "orderBy": "4",
      "height":20
    },
    {
      "type":"propicController",
      "imagePath":"assets/designation/security.svg",
      "bgColor":"primaryColor",
      "alignment":"center",
      "orderBy":5
    },
    {
      "type":"sizedBox",
      "orderBy": "6",
      "height":10
    },
    {
      "type": "text",
      "orderBy": "7",
      "value": "Mr. End User",
      "key": 1,
      "style": {
        "color": "primaryTextColor1",
        "fontSize": 20.0,
        "fontFamily": "RB"
      }
    },
    {
      "type":"sizedBox",
      "orderBy": "8",
      "height":10
    },
    {
      "type": "text",
      "orderBy": "9",
      "value": "User",
      "key": 1,
      "style": {
        "color": "primaryTextColor1",
        "fontSize": 16.0,
        "fontFamily": "RR"
      }
    }*/

