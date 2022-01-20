import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/pages/profilePage.dart';
import 'package:nextstop_dynamic/styles/style.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';

import '../constants.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements MyCallback{
  GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();
  int selectedPage=0;

  List<dynamic> widgets=[];
  var parsedJson;

  String guid="";

  parseJson() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/${General.homePageIdentifier}.json");
    parsedJson=jsonDecode(data);

    //guid=widget.pageIdentifier;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        key: scaffoldKey,
        body:selectedPage==0?ProfilePage(

        ): Container(
          color: selectedPage==1?Colors.blue:Colors.green,
        ),
        drawer: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          color: primaryColor,
          child: Column(
            children: [
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    scaffoldKey.currentState!.openEndDrawer();
                    // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ThemeSettings()));
                  }, icon: Icon(Icons.clear,color: Colors.white,size: 28,),),
                ],
              ),
              for(int i=0;i<widgets.length;i++)
                widgets[i],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void ontap(Map? clickEvent) {
    log("$clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey('eventName')){
        if(clickEvent['eventName']=='FormSubmit'){
         // General().formSubmit(guid, widgets,clickEvent);
        }
        else if(clickEvent['eventName']=='Navigation'){
          General().navigation(clickEvent['navigateToPage'],clickEvent['typeOfNavigation']);
        }
        else if(clickEvent['eventName']=='HomePageNavigation'){
          setState(() {
            selectedPage=clickEvent['pageIndex'];
          });
          scaffoldKey.currentState!.openEndDrawer();
        }

      }
    }
  }
}
