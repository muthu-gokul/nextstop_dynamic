import 'dart:convert';
import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/general.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:dynamicparsers/widgets/sizeLocal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/notifier/myNotification.dart';
import 'package:nextstop_dynamic/pages/user/bookingPage.dart';
import 'package:nextstop_dynamic/pages/user/profilePage.dart';
import 'package:nextstop_dynamic/styles/style.dart';

import 'package:get/get.dart';
import 'package:nextstop_dynamic/utils/common.dart';
import 'package:nextstop_dynamic/utils/general.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../model/push_notification.dart';
import '../dynamicPageInitiater.dart';
import 'driverMyTrips.dart';
import 'driverTripHomePage.dart';
import 'profilePageDriver.dart';
/*
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message}");
}*/
var selectedPage=0.obs;


class HomePageDriver2 extends StatefulWidget  {
  @override
  State<HomePageDriver2> createState() => _HomePageDriver2State();
}

class _HomePageDriver2State extends State<HomePageDriver2> with WidgetsBindingObserver,MyCallback,Common implements MyNotificationCallBack{
  GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();

  var widgets=[].obs;

  List<dynamic> queryString=[];

  var parsedJson;

  var isLoad=false.obs;

  String guid="";

  late MyNotification myNotification;

  // HomePageDriver2(){
  //   print("constructor");
  //   registerNotification();
  //   checkForInitialMessage();
  //   parseJson();
  //   driverTripHomePage=DriverTripHomePage(myCallback: this);
  // }
  @override
  initState(){
      print("driver initstate");
      WidgetsBinding.instance?.addObserver(this);
      myNotification=MyNotification();
      myNotification.setMyCallBack(this);
      myNotification.registerNotification();
      myNotification.checkForInitialMessage();
      parseJson();
      driverTripHomePage=DriverTripHomePage(myCallback: this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state==AppLifecycleState.resumed){
      print("resumed Driver");
      if(selectedPage.value==1){
        driverTripHomePage.reloadMap();
      }
    }
    else if(state==AppLifecycleState.paused){
      print("paused Driver");
    }
    else if(state==AppLifecycleState.detached){
      print("dettach Driver");
    }
    else if(state==AppLifecycleState.inactive){
      print("inactive Driver");
    }
  }


  late DriverTripHomePage driverTripHomePage;

  parseJson() async{
    isLoad.value=true;
    String data = await rootBundle.loadString("assets/json/${General.homePageDriverIdentifier}.json");

   // String data = await DefaultAssetBundle.of(Get.context!).loadString("assets/json/${General.homePageDriverIdentifier}.json");
    parsedJson=jsonDecode(data);

    //guid=widget.pageIdentifier;
    widgets.value=getWidgets(parsedJson['Widgets'],this);
    if(parsedJson.containsKey('queryString')){
      queryString=parsedJson['queryString'];
    }
    isLoad.value=false;
    //log("${widgets}");
  }

  @override
  onNotificationReceived(List valueArray){
    selectedPage.value=1;
    driverTripHomePage.onNotificationReceived(valueArray);
  }

  @override
  Widget build(BuildContext context) {

      keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    // log("bb $keyboardVisible ${ MediaQuery.of(context).viewInsets.bottom != 0} ${MediaQuery.of(context).padding.bottom} ${MediaQuery.of(context).padding.top}");
    return SafeArea(
        bottom: true,
        top: true,
        child: Obx(
              ()=>Scaffold(
            key: scaffoldKey,
            body: IndexedStack(
              index: selectedPage.value,
              children: [
                ProfilePageDriver(myCallback: this,),
                driverTripHomePage,
                DriverMyTrips(myCallback: this,)
              ],
            ),
            // body:selectedPage.value==0?ProfilePageDriver(
            //   myCallback: this,
            // ):selectedPage.value==1?driverTripHomePage:Container(),
            drawer: Obx(
                ()=>Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  color: isLoad.value?Colors.white:primaryColor,
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
          ),
        )
    );
  }

  @override
  Future<void> ontap(Map? clickEvent) async {
    log("HOMEPAGE Driver $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
         if(clickEvent[General.eventName]=='HomePageDriverNavigation'){

          selectedPage.value=clickEvent['pageIndex'];
          scaffoldKey.currentState!.openEndDrawer();
          if(selectedPage.value==1){
            driverTripHomePage.reload();
            determinePosition();
          }
        }
        else if(clickEvent[General.eventName]=='OpenDrawer'){
          scaffoldKey.currentState!.openDrawer();
          FocusScope.of(Get.context!);
          FocusScope.of(Get.context!).unfocus();
        }
        else if(clickEvent[General.eventName]=='reloadBookingPage'){
          log("reload");

        }
        else if(clickEvent[General.eventName]=='Logout'){
          SharedPreferences sp=await SharedPreferences.getInstance();
          sp.setBool(ISLOGGEDINKEY, false);
          sp.setString("token", "");
          checkAndNavigate(clickEvent,this);
          //General().navigation(clickEvent[General.navigateToPage],clickEvent[General.typeOfNavigation]);
        }
        else{
          splitByTapEvent(clickEvent,
            widgets: widgets,
            queryString: queryString,
            myCallback: this
          );
         }

      }
    }
  }

}

