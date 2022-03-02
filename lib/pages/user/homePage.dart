import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/general.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:dynamicparsers/widgets/navIcon.dart';
import 'package:dynamicparsers/widgets/sizeLocal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/notifier/getUiNotifier.dart';

import 'package:nextstop_dynamic/styles/style.dart';
import 'package:nextstop_dynamic/utils/colorUtil.dart';
import 'package:nextstop_dynamic/utils/common.dart';
import 'package:nextstop_dynamic/utils/general.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../dynamicPageInitiater.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'bookingPage.dart';
import 'myTrips.dart';
import 'profilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
var selectedPage=4.obs;


class _HomePageState extends State<HomePage> with Common, MyCallback{
  GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();

  List<dynamic> widgets=[];
  List<dynamic> queryString=[];
  var parsedJson;

  String guid="";

  parseJson() async{
    selectedPage.value=4;
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/${General.homePageIdentifier}.json");
    parsedJson=jsonDecode(data);

    //guid=widget.pageIdentifier;
    widgets=getWidgets(parsedJson['Widgets'],this);
    if(parsedJson.containsKey('queryString')){
      queryString=parsedJson['queryString'];
    }
    Timer(Duration(seconds: 2), (){
      selectedPage.value=1;
    });
    // selectedPage.value=0;
   /* setState(() {

      //bookingPage=BookingPage(myCallback: this);
    });*/
    //log("${widgets}");
  }

 // late BookingPage? bookingPage;
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
   Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }
  @override
  void initState() {
     profilePage=ProfilePage(myCallback: this,);
     myTrips=MyTrips(myCallback: this,);
    parseJson();
    _initPackageInfo();
    determinePosition();

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
    //  parseJson();
    }
    super.initState();
  }

  late ProfilePage profilePage;
  late MyTrips myTrips;

  @override
  Widget build(BuildContext context) {
    setState(() {
      keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    });
    log("bb $keyboardVisible ${ MediaQuery.of(context).viewInsets.bottom != 0} ${MediaQuery.of(context).padding.bottom} ${MediaQuery.of(context).padding.top}");
    return SafeArea(
      bottom: true,
      top: true,
      child: Obx(
          ()=>Scaffold(
            key: scaffoldKey,
            body: IndexedStack(
              index: selectedPage.value,
              children: [
                profilePage,
                BookingPage(myCallback: this),
                myTrips,
                Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          NavIcon(ontap: this, map: {
                            "type":"navIcon",
                            "orderBy": "1",
                            "color": "*primaryColor",
                            "strokeColor": "ffffff",
                            "margin": "20,0,0,0",
                            "padding": "10,0,0,0",
                            "borderRadius": "10,10,10,10",
                            "width":40,
                            "height":35,
                            "clickEvent": {
                              "eventName": "OpenDrawer"
                            }
                          }),
                          Spacer()
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text("Current Version: ${packageInfo.version}"),
                      SizedBox(height: 20,),
                      TextButton(onPressed: (){
                        log("vv  ${packageInfo.version} ");
                        FirebaseDatabase.instance.ref().child("AppInfo").get().then((dataSnapshot){

                          var map = Map<dynamic, dynamic>.from(dataSnapshot.value as Map);
                          if(map['version']!=packageInfo.version){
                            launch(map['url']);
                          }
                          else{
                            Get.defaultDialog(title: "",titleStyle: TextStyle(height: 0),radius: 10,middleText: "No Updates Available",middleTextStyle: TextStyle(fontFamily: "RR",fontSize: 20,));
                          }
                        });
                        // launch("https://drive.google.com/file/d/10aAtCPpcE2D_7-Pq88DbtAQLBc3sU5Y2/view?usp=sharing");
                      }, child: Text("Update"))
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      LinearProgressIndicator(color: ColorUtil.primaryColor,backgroundColor: ColorUtil.primaryColor.withOpacity(0.5),)

                    ],
                  ),
                )
              ],
            ),
            /*body: selectedPage.value==0?profilePage:
            selectedPage.value==1?BookingPage(myCallback: this):
            selectedPage.value==2?MyTrips(myCallback: this,):
            selectedPage.value==4?Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      NavIcon(ontap: this, map: {
                          "type":"navIcon",
                          "orderBy": "1",
                          "color": "*primaryColor",
                          "strokeColor": "ffffff",
                          "margin": "20,0,0,0",
                          "padding": "10,0,0,0",
                          "borderRadius": "10,10,10,10",
                          "width":40,
                          "height":35,
                          "clickEvent": {
                            "eventName": "OpenDrawer"
                          }
                        }),
                        Spacer()
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("Current Version: ${packageInfo.version}"),
                  SizedBox(height: 20,),
                  TextButton(onPressed: (){
                    log("vv  ${packageInfo.version} ");
                    FirebaseDatabase.instance.ref().child("AppInfo").get().then((dataSnapshot){
                    
                     var map = Map<dynamic, dynamic>.from(dataSnapshot.value as Map);
                      if(map['version']!=packageInfo.version){
                        launch(map['url']);
                      }
                      else{
                        Get.defaultDialog(title: "",titleStyle: TextStyle(height: 0),radius: 10,middleText: "No Updates Available",middleTextStyle: TextStyle(fontFamily: "RR",fontSize: 20,));
                      }
                    });
                   // launch("https://drive.google.com/file/d/10aAtCPpcE2D_7-Pq88DbtAQLBc3sU5Y2/view?usp=sharing");
                  }, child: Text("Update"))
                ],
              ),
            ):


            selectedPage.value==99?Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  LinearProgressIndicator(color: ColorUtil.primaryColor,backgroundColor: ColorUtil.primaryColor.withOpacity(0.5),)

                ],
              ),
            ):
            Container(),*/
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
      )
    );
  }

  @override
  Future<void> ontap(Map? clickEvent) async {
    log("HOMEPAGE $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey('eventName')){
        if(clickEvent['eventName']=='FormSubmit'){
         // General().formSubmit(guid, widgets,clickEvent,queryString,myCallback: this);
        }
        else if(clickEvent['eventName']=='Navigation'){
          checkAndNavigate(clickEvent,this);
         // General().navigation(clickEvent['navigateToPage'],clickEvent['typeOfNavigation']);
        }
        else if(clickEvent['eventName']=='HomePageNavigation'){
          setState(() {
            selectedPage.value=clickEvent['pageIndex'];
          });
          scaffoldKey.currentState!.openEndDrawer();
          if(selectedPage.value==1){
            determinePosition();
          }
        }
        else if(clickEvent['eventName']=='OpenDrawer'){
          scaffoldKey.currentState!.openDrawer();
        }
        else if(clickEvent['eventName']=='reloadBookingPage'){
          log("reload");

        }
        else if(clickEvent[General.eventName]=='Logout'){
          SharedPreferences sp=await SharedPreferences.getInstance();
          sp.setBool(ISLOGGEDINKEY, false);
          sp.setString("token", "");
          checkAndNavigate(clickEvent,this);
         // General().navigation(clickEvent[General.navigateToPage],clickEvent[General.typeOfNavigation]);
        }
        else{
          splitByTapEvent(
              clickEvent,
              guid: General.homePageIdentifier,
              widgets: widgets,
              queryString: queryString,
              myCallback: this
          );
        }
      }
    }
  }



}



