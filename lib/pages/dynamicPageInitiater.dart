import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../widgets/customControllers/callBack/general.dart';
import '../widgets/sizeLocal.dart';
import '../notifier/getUiNotifier.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/customControllers/callBack/myCallback.dart';

class DynamicPageInitiater extends StatefulWidget {
  String pageIdentifier;
  DynamicPageInitiater({required this.pageIdentifier});
  @override
  _DynamicPageInitiaterState createState() => _DynamicPageInitiaterState();
}

class _DynamicPageInitiaterState extends State<DynamicPageInitiater> implements MyCallback{

  List<dynamic> widgets=[];
  var parsedJson;

  String guid="";

  parseJson() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/${General.registrationPageIdentifier}.json");
    parsedJson=jsonDecode(data);

    guid=widget.pageIdentifier;
    widgets=getWidgets(parsedJson['Widgets'],this);
    setState(() {});
    //log("${widgets}");
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
        body: Container(
          alignment: Alignment.center,
          height: SizeConfig.screenHeight!-topPad,
          width: SizeConfig.screenWidth,
          color: Colors.white,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for(int i=0;i<widgets.length;i++)
                  widgets[i],
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









