import 'dart:convert';
import 'dart:developer';
import 'package:dynamicparsers/customControllers/callBack/general.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:dynamicparsers/customControllers/utils.dart';
import 'package:dynamicparsers/widgets/sizeLocal.dart';
import 'package:flutter/material.dart';
import '../notifier/getUiNotifier.dart';
import 'package:get/get.dart';

import '../constants.dart';

var keyboardVisible = false.obs;
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
    widgets.clear();
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
      log("contains valueArray  ${valueArray.length}");
      valueArray.forEach((element) {
        print("element ${element['key']}");
        findWidgetByKey(widgets,{"key":element['key']},(wid){
           log("query wid $wid ${wid.getType()}");
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
  Future<dynamic> initSS() async{
    print("initSS");
    if(fromUrl){
      await GetUiNotifier().getUiJson(widget.pageIdentifier,LOGINUSERID).then((value){
      //  log("value $value");
        if(value!="null" && value.toString().isNotEmpty){
          var parsed=jsonDecode(value);
          //  print(parsed['table'][0]['jsonData']);
          parsedJson=jsonDecode(parsed['Table'][0]['PageJson']);
         // print(parsedJson);
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
           // log("contains fromQuery String ${widget.fromQueryString}");
            widget.fromQueryString.forEach((element) {
              findWidgetByKey(widgets,{"key":element['key']},(wid){
                // log("query wid $wid ${wid.getType()}");
                updateByWidgetType(wid.getType(),widget: wid,clickEvent: element);
              });
            });
          }
          if(valueArray.isNotEmpty){
          //  log("contains valueArray  ${valueArray}");
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

  reloadValueArray(List<dynamic> valueArray){
    valueArray.forEach((element) {
      findWidgetByKey(widgets,{"key":element['key']},(wid){
        // log("query wid $wid ${wid.getType()}");
        updateByWidgetType(wid.getType(),widget: wid,clickEvent: element);
      });
    });
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
   // log("dddd ${widget.isScrollControll?keyboardVisible?AlwaysScrollableScrollPhysics():
  //  NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics()}");
  //  SizeConfig().init(context);
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
          child:parsedJson.containsKey('isOwnWidget')?widgets[0]:
          Obx(
              ()=>SingleChildScrollView(
                controller: scrollController,
                //physics: NeverScrollableScrollPhysics(),
                physics: widget.isScrollControll?keyboardVisible.value?AlwaysScrollableScrollPhysics():
                NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: parseCrossAxisAlignment(parsedJson['crossAxisAlignment']),
                  mainAxisAlignment: parseMainAxisAlignment(parsedJson['mainAxisAlignment']),
                  mainAxisSize: keyboardVisible.value?MainAxisSize.min:MainAxisSize.min,
                  children: [
                    for(int i=0;i<widgets.length;i++)
                      widgets[i],
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }


  @override
  Future<void> ontap(Map? clickEvent)  async {
    log("dynamic Page clickEvent $clickEvent");
    //log("${}");
    if(clickEvent!=null){
      if(clickEvent.containsKey('eventName')){
        if(clickEvent['eventName']=='FormSubmit'){

       /*  var res= General().formSubmit(guid, widgets,clickEvent,queryString,myCallback: this);
         log("resultt $res");*/
        }
        else if(clickEvent['eventName']=='FormSubmitEstimateBill'){

         /* var res = General().formSubmit(guid, widgets[1].widgets,clickEvent,queryString,myCallback: this);
          log("ress $res");
          if(res!=null){
            GetUiNotifier().postUiJson(LOGINUSERID, widget.pageIdentifier, res, clickEvent).then((value){
              log("sp value-- $value");
              getXNavigation(3, Container());
              selectedPage.value=2;
            });
          }*/


        }
        else if(clickEvent['eventName']=='Navigation'){
        //  General().navigation(clickEvent['navigateToPage'],clickEvent['typeOfNavigation']);
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

  @override
  getCurrentPageWidgets() {
    // TODO: implement getCurrentPageWidgets
    throw UnimplementedError();
  }

  @override
  Color parseColor(String color) {
    // TODO: implement parseColor
    throw UnimplementedError();
  }

  @override
  reloadPage() {
    // TODO: implement reloadPage
    throw UnimplementedError();
  }
}


/*findAndUpdateTextEditingController(var widget,Map? clickEvent){
  log("clickEvent['value'] ${clickEvent!['value']}");
  if(clickEvent['value']!=null){
     widget.textEditingController.text=clickEvent['value'];
     widget.map['value']=clickEvent['value'];
  }
  if(clickEvent['obscureText']!=null){
     widget.obscureText.value=clickEvent['obscureText'];
     widget.map['obscureText']=clickEvent['obscureText'];
  }
 
}


updateByWidgetType(String widgetType,{var widget,Map? clickEvent}){
  switch (widgetType){
    case 'textField':{
      findAndUpdateTextEditingController( widget, clickEvent);
    }
    break;
    case 'text':{
     // log("TEXT $widgetType $widget $clickEvent");
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
    case 'listViewBuilderController':{
      widget.map['value']=clickEvent!['value'];
      widget.updateValues(clickEvent['value']);
    }
    break;
    case 'button':{
      widget.map['clickEvent']=clickEvent!['value'];
    }
    break;
    default: {
      log("dfault");
    }
    break;
  }
}*/



