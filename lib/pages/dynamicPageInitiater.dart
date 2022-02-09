import 'dart:convert';
import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/generalMethods.dart';
import 'package:nextstop_dynamic/widgets/customControllers/utils.dart';
import '../widgets/customControllers/callBack/general.dart';
import '../widgets/sizeLocal.dart';
import '../notifier/getUiNotifier.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/customControllers/callBack/myCallback.dart';
import 'homePage.dart';
bool keyboardVisible = false;
class DynamicPageInitiater extends StatefulWidget {
  String pageIdentifier;
  MyCallback? myCallback;
  bool isScrollControll;
  List<dynamic> fromQueryString;
  DynamicPageInitiater({Key? key,required this.pageIdentifier,this.myCallback,this.isScrollControll=false,this.fromQueryString=const []}): super(key: key);
  //DynamicPageInitiater({required this.pageIdentifier,this.myCallback,this.isScrollControll=false,this.fromQueryString=const []});

  final DynamicPageInitiaterState dynamicPageInitiaterState=DynamicPageInitiaterState();
  @override
  DynamicPageInitiaterState createState() => dynamicPageInitiaterState;


}

class DynamicPageInitiaterState extends State<DynamicPageInitiater> implements MyCallback{

  List<dynamic> widgets=[];
  List<dynamic> queryString=[];
  List<dynamic> valueArray=[];
  var parsedJson;

  String guid="";

  parseJson() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/${widget.pageIdentifier}.json");
    parsedJson=jsonDecode(data);

    guid=widget.pageIdentifier;
   /* parsedJson['Widgets'].forEach((e){
      log("eeee $e");
    });*/
 //   widgets=getWidgets(parsedJson['Widgets'],this);

    if(widget.myCallback==null){
      widgets=getWidgets(parsedJson['Widgets'],this);
    }
    else{
      widgets=getWidgets(parsedJson['Widgets'],widget.myCallback!);
    }

    if(parsedJson.containsKey('queryString')){
      queryString=parsedJson['queryString'];
    }
    if(parsedJson.containsKey('valueArray')){
      valueArray=parsedJson['valueArray'];
    }

    if(widget.fromQueryString.isNotEmpty){
      log("contains fromQuery String ${widget.fromQueryString}");
      widget.fromQueryString.forEach((element) {
        findWidgetByKey(widgets,{"key":element['key']},(wid){
          // log("query wid $wid ${wid.getType()}");
          updateByWidgetType(wid.getType(),widget: wid,clickEvent: element);
        });
      });
    }

    if(valueArray.isNotEmpty){
      log("contains valueArray  ${valueArray}");
      valueArray.forEach((element) {
        findWidgetByKey(widgets,{"key":element['key']},(wid){
          // log("query wid $wid ${wid.getType()}");
          updateByWidgetType(wid.getType(),widget: wid,clickEvent: element);
        });
      });
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
  initSS(){
    if(fromUrl){

      GetUiNotifier().getUiJson(widget.pageIdentifier,LOGINUSERID).then((value){
        log("value $value");
        if(value!="null"){
          var parsed=jsonDecode(value);
          //  print(parsed['table'][0]['jsonData']);
          parsedJson=jsonDecode(parsed['Table'][0]['PageJson']);
          print(parsedJson);
          guid=parsedJson['Guid'];
          if(widget.myCallback==null){
            widgets=getWidgets(parsedJson['Widgets'],this);
          }
          else{
            widgets=getWidgets(parsedJson['Widgets'],widget.myCallback!);
          }
          // if(parsedJson.containsKey('queryString')){
          //   log("parsedJson.containsKey('queryString') ${parsedJson.containsKey('queryString')}");
          //   queryString=parsedJson['queryString'];
          // }

          if(parsedJson.containsKey('queryString')){
            queryString=parsedJson['queryString'];
          }
          if(parsedJson.containsKey('valueArray')){
            valueArray=parsedJson['valueArray'];
          }


          if(widget.fromQueryString.isNotEmpty){
            log("contains fromQuery String ${widget.fromQueryString}");
            widget.fromQueryString.forEach((element) {
              findWidgetByKey(widgets,{"key":element['key']},(wid){
                // log("query wid $wid ${wid.getType()}");
                updateByWidgetType(wid.getType(),widget: wid,clickEvent: element);
              });
            });
          }
          if(valueArray.isNotEmpty){
            log("contains valueArray  ${valueArray}");
            valueArray.forEach((element) {
              findWidgetByKey(widgets,{"key":element['key']},(wid){
                // log("query wid $wid ${wid.getType()}");
                updateByWidgetType(wid.getType(),widget: wid,clickEvent: element);
              });
            });
          }
          setState(() {});
        }
      });

    }
    else{
      parseJson();
    }
  }

  @override
  void initState() {
    initSS();
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

    // log("_keyboardVisible $keyboardVisible ${widget.pageIdentifier} ${widget.isScrollControll} ${ widget.isScrollControll?keyboardVisible?AlwaysScrollableScrollPhysics():
    // NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics()}");
    log("dddd ${widget.isScrollControll?keyboardVisible?AlwaysScrollableScrollPhysics():
    NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics()}");
    SizeConfig().init(context);
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body:parsedJson==null?Container(): Container(
         // alignment: Alignment.center,
          alignment: parseAlignment(parsedJson['alignment']),
          height: SizeConfig.screenHeight!-topPad,
          width: SizeConfig.screenWidth,
          color: Colors.white,
          child:parsedJson.containsKey('isOwnWidget')?widgets[0]: SingleChildScrollView(
            controller: scrollController,
            //physics: NeverScrollableScrollPhysics(),
            physics: widget.isScrollControll?keyboardVisible?AlwaysScrollableScrollPhysics():
             NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: parseCrossAxisAlignment(parsedJson['crossAxisAlignment']),
              mainAxisAlignment: parseMainAxisAlignment(parsedJson['mainAxisAlignment']),
              mainAxisSize: MainAxisSize.min,
              children: [
                for(int i=0;i<widgets.length;i++)
                  widgets[i],


                //Expandend Concept Important
                /*Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.green)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SvgPicture.asset("assets/icons/driver.svg"),
                            Text("Mr.Vijay Kumar hgjfngjfnjnjknfgjf ")
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("one"),
                                Text("one"),
                                Spacer(),
                                Text("ii")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("one"),
                                SizedBox(width: 10,),
                                Expanded(child: Text("Biyani of Big Bazaar, it is India's No. 1 retail store in one locality.")),

                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )*/





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
  Future<void> ontap(Map? clickEvent)  async {
    log("dynamic Page clickEvent $clickEvent");
    //log("${}");
    if(clickEvent!=null){
      if(clickEvent.containsKey('eventName')){
        if(clickEvent['eventName']=='FormSubmit'){
        //  log("$widgets");
         var res= General().formSubmit(guid, widgets,clickEvent,queryString,myCallback: this);
         log("resultt $res");
        }
        else if(clickEvent['eventName']=='FormSubmitBookingPage'){

          General().formSubmit(guid, widgets[0].widget.widgets[1].widget.widget.widgets,clickEvent,queryString,myCallback: widget.myCallback);
        }
        else if(clickEvent['eventName']=='FormSubmitEstimateBill'){

          var res = General().formSubmit(guid, widgets[1].widgets,clickEvent,queryString,myCallback: this);
          log("ress $res");
          if(res!=null){
            GetUiNotifier().postUiJson(LOGINUSERID, widget.pageIdentifier, res, clickEvent).then((value){
              log("sp value-- $value");
              getXNavigation(3, Container());
              selectedPage.value=2;
            });
          }
          // log("ress $res ");
          // log("widgets[1].widgets ${widgets[1].widgets[7].widgets[1].text.value} ");
            //selectedPage.value=2;

        }
        else if(clickEvent['eventName']=='Navigation'){
          General().navigation(clickEvent['navigateToPage'],clickEvent['typeOfNavigation']);
        }
        else if(clickEvent['eventName']=='OpenDrawer'){
          widget.myCallback?.ontap(clickEvent);
        }

      }
    }
  }

  @override
  void onTextChanged(String text,Map map) {
    log("dynamic PAge text $text $map");
    if(map['key']=="PickUp"){

    }
  }

  @override
  void onMapLocationChanged(Map map) {
    log("dynamic PAge map  $map");
    if(map['key']=="PickUp"){
      findWidgetByKey(widgets,{"key":map['key'],"value":map['location']},(wid){
        findAndUpdateTextEditingController(wid,{"key":map['key'],"value":map['location']});
      });
      findWidgetByKey(widgets,{"key":"PickUp_Loc_Details"},(wid){
        wid.map['value'][0]['latitude']=map['latitude'];
        wid.map['value'][1]['longitude']=map['longitude'];
      });

    }
    else if(map['key']=="Drop"){
      findWidgetByKey(widgets,{"key":map['key'],"value":map['location']},(wid){
        findAndUpdateTextEditingController(wid,{"key":map['key'],"value":map['location']});
      });
      findWidgetByKey(widgets,{"key":"Drop_Loc_Details"},(wid){
        wid.map['value'][0]['latitude']=map['latitude'];
        wid.map['value'][1]['longitude']=map['longitude'];
      });
    }
  }
}

/*
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
}*/



findWidgetByKey(List<dynamic> widgets,Map? clickEvent,Function(dynamic widget) returnFunction){
 // log("key ${clickEvent} $widgets");
  var a;
  for(int i=0;i<widgets.length;i++){
    a= func1ByKey(widgets[i],clickEvent,returnFunction);
    // log("aaaaa $a ");
    if(a!=null){
      returnFunction(a);
      // a.textEditingController.text=clickEvent!['value'];
      // a.map['value']=clickEvent['value'];
      break;

    }
  }
  return null;
}

func1ByKey(dynamic widget,Map? clickEvent,Function(dynamic widget) returnFunction){
  // log("widget.map ${widget.runtimeType}");
  if(widget.runtimeType==Icon){
    return;
  }
  if(widget.map.containsKey("child")){
   // log("${widget.getType()} ${widget.widget} ${widget.map['key']}");
   // func1ByKey(widget.widget,clickEvent,returnFunction);

    if(widget.map.containsKey('key')){
      if(widget.map['key']==clickEvent!['key']){
        return widget;
      }
      else{
        var aa= func1ByKey(widget.widget,clickEvent,returnFunction);
        if(aa!=null){
          return aa;
        }
      }
    }
    else{
      var aa= func1ByKey(widget.widget,clickEvent,returnFunction);
      if(aa!=null){
        return aa;
      }
    }

  }
  else if(widget.map.containsKey("children")){
    // log("${widget.getType()}");
    if(widget.getType()!='userRoleController') {
   //   log("___ ${widget.getType()} ${widget.widgets}");
     findWidgetByKey(widget.widgets,clickEvent,returnFunction);

    }
    else{
     // log("else ${widget.getType()}");
    }
  }
  else{
    // log("else3 ${widget.map}");
    if(widget.map.containsKey('key')){
      if(widget.map['key']==clickEvent!['key']){
        return widget;
      }
     // log("else2 ${widget.getType()}  has key ${widget.map['key']}    ${clickEvent['key']}");
    }
  }
  return null;
}

findAndUpdateTextEditingController(var widget,Map? clickEvent){
  widget.textEditingController.text=clickEvent!['value'];
  widget.map['value']=clickEvent['value'];
}


updateByWidgetType(String widgetType,{var widget,Map? clickEvent}){
  switch (widgetType){
    case 'textField':{
      findAndUpdateTextEditingController( widget, clickEvent);
    }
    break;
    case 'text':{
      log("TEXT $widgetType $widget $clickEvent");
      widget.text.value=clickEvent!['value'];
      widget.map['value']=clickEvent['value'];
    }
    break;
    case 'hiddenController':{
      widget.map['value']=clickEvent!['value'];
    }
    break;
    case 'visibilityController':{
      widget.map['isVisible']=clickEvent!['value'];
      widget.isVisible.value=clickEvent['value'];
    }
    break;
    default: {
      log("dfault");
    }
    break;
  }
}



