import 'dart:convert';
import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nextstop_dynamic/widgets/customControllers/utils.dart';
import '../widgets/customControllers/callBack/general.dart';
import '../widgets/sizeLocal.dart';
import '../notifier/getUiNotifier.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/customControllers/callBack/myCallback.dart';
bool keyboardVisible = false;
class DynamicPageInitiater extends StatefulWidget {
  String pageIdentifier;
  MyCallback? myCallback;
  bool isScrollControll;
  DynamicPageInitiater({required this.pageIdentifier,this.myCallback,this.isScrollControll=false});
  @override
  _DynamicPageInitiaterState createState() => _DynamicPageInitiaterState();
}

class _DynamicPageInitiaterState extends State<DynamicPageInitiater> implements MyCallback{

  List<dynamic> widgets=[];
  List<dynamic> queryString=[];
  var parsedJson;

  String guid="";

  parseJson() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/${widget.pageIdentifier}.json");
    parsedJson=jsonDecode(data);

    guid=widget.pageIdentifier;
   /* parsedJson['Widgets'].forEach((e){
      log("eeee $e");
    });*/
    widgets=getWidgets(parsedJson['Widgets'],this);
    if(parsedJson.containsKey('queryString')){
      queryString=parsedJson['queryString'];
    }
/*    if(widget.myCallback==null){
      widgets=getWidgets(parsedJson['Widgets'],this);
    }
    else{
      widgets=getWidgets(parsedJson['Widgets'],widget.myCallback!);
    }*/

    setState(() {});
    //log("${parsedJson}");
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
  /*  setState(() {
      keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    });*/

    log("_keyboardVisible $keyboardVisible ${widget.pageIdentifier} ${widget.isScrollControll} ${ widget.isScrollControll?keyboardVisible?AlwaysScrollableScrollPhysics():
    NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics()}");
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
            physics: widget.isScrollControll?keyboardVisible?AlwaysScrollableScrollPhysics():
            NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
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
  void ontap(Map? clickEvent)  {
    log("dynamic Page clickEvent $clickEvent");
    //log("${}");
    if(clickEvent!=null){
      if(clickEvent.containsKey('eventName')){
        if(clickEvent['eventName']=='FormSubmit'){
        //  log("$widgets");
          General().formSubmit(guid, widgets,clickEvent,queryString,myCallback: this);
        }
        else if(clickEvent['eventName']=='FormSubmitBookingPage'){
        //  log("${widgets[0].widget.widgets[0].widget.widget.widgets}");13.063375644114803, 80.14215027634373    13.071144672850647, 80.18444206319955
          //13.06711414347586, 80.20565429830474
          //13.067951392583117, 80.17677200475224 from
          /*var _distanceInMeters = Geolocator.distanceBetween(
              10.10171792889313, 77.47002031632144,
              13.067951392583117,
              80.17677200475224
          );
          log("_distanceInMeters $_distanceInMeters ${_distanceInMeters/1000}");*/
          General().formSubmit(guid, widgets[0].widget.widgets[1].widget.widget.widgets,clickEvent,queryString,myCallback: this);
        }
        else if(clickEvent['eventName']=='Navigation'){
          General().navigation(clickEvent['navigateToPage'],clickEvent['typeOfNavigation']);
        }
        else if(clickEvent['eventName']=='OpenDrawer'){
          widget.myCallback?.ontap(clickEvent);
        }
        else if(clickEvent['eventName']=='iconClick'){
          log("$widgets");
          findWidget(widgets);
          findWidgetByKey(widgets,clickEvent['key']);
        }
      }
    }
  }
}


findWidget(List<dynamic> widgets){
   log("widgets ${widgets}");
  for(int i=0;i<widgets.length;i++){
    func1(widgets[i]);
  }
}

func1(dynamic widget){
  if(widget.map.containsKey("child")){
    log("${widget.getType()} ${widget.widget} ${widget.map['key']}");
    func1(widget.widget);
  }
  else if(widget.map.containsKey("children")){
   // log("${widget.getType()}");
    if(widget.getType()!='userRoleController') {
      log("___ ${widget.getType()} ${widget.widgets}");
      findWidget(widget.widgets);
    }
    else{
      log("else ${widget.getType()}");
    }
  }
  else{
    log("else2 ${widget.getType()}");
  }
}

findWidgetByKey(List<dynamic> widgets,dynamic key){
  //log("widgets ${widgets}");
  var a;
  for(int i=0;i<widgets.length;i++){
    a= func1ByKey(widgets[i],key);
    log("aaaaa $a ");
    if(a!=null){
      a.textEditingController.text="Heelo";
      a.map['value']="Heelo";
      break;

    }
  }

}

func1ByKey(dynamic widget,dynamic key){
  if(widget.map.containsKey("child")){
   // log("${widget.getType()} ${widget.widget} ${widget.map['key']}");
    func1ByKey(widget.widget,key);
  }
  else if(widget.map.containsKey("children")){
    // log("${widget.getType()}");
    if(widget.getType()!='userRoleController') {
    //  log("___ ${widget.getType()} ${widget.widgets}");
      findWidgetByKey(widget.widgets,key);
    }
    else{
      log("else ${widget.getType()}");
    }
  }
  else{
    if(widget.map.containsKey('key')){
      if(widget.map['key']==key){
        return widget;
      }
      log("else2 ${widget.getType()}  has key ${widget.map['key']}    $key");
    }
  }
  return null;
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

