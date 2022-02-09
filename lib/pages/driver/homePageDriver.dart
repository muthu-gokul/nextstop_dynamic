import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/pages/bookingPage.dart';
import 'package:nextstop_dynamic/pages/profilePage.dart';
import 'package:nextstop_dynamic/styles/style.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../model/push_notification.dart';
import '../dynamicPageInitiater.dart';
import 'driverMyTrips.dart';
import 'driverTripHomePage.dart';
import 'profilePageDriver.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message}");
}
var selectedPage=0.obs;
/*class HomePageDriver extends StatefulWidget {
  @override
  _HomePageDriverState createState() => _HomePageDriverState();
}


class _HomePageDriverState extends State<HomePageDriver> implements MyCallback{
  GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();

  List<dynamic> widgets=[];
  List<dynamic> queryString=[];
  var parsedJson;

  String guid="";

  parseJson() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/${General.homePageDriverIdentifier}.json");
    parsedJson=jsonDecode(data);

    //guid=widget.pageIdentifier;
    widgets=getWidgets(parsedJson['Widgets'],this);
    if(parsedJson.containsKey('queryString')){
      queryString=parsedJson['queryString'];
    }
    setState(() {

    });
    //log("${widgets}");
  }

   DriverTripHomePage? driverTripHomePage;

  late final FirebaseMessaging _messaging;
  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message title Open: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data['valueArray'].runtimeType} ${jsonDecode(message.data['valueArray'])}');
        onNotificationReceived(jsonDecode(message.data['valueArray']));
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('onMessage Click OpenedApp title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
        onNotificationReceived(jsonDecode(message.data['valueArray']));
      });

    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );
    }
  }


  onNotificationReceived(List valueArray){
    selectedPage.value=1;
    driverTripHomePage!.onNotificationReceived(valueArray);
  }


  @override
  void initState() {
    print("init");
    registerNotification();
    checkForInitialMessage();
    parseJson();


    if(fromUrl){
*//*      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
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
      });*//*
    }
    else{
      //  parseJson();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    });
   // log("bb $keyboardVisible ${ MediaQuery.of(context).viewInsets.bottom != 0} ${MediaQuery.of(context).padding.bottom} ${MediaQuery.of(context).padding.top}");
    return SafeArea(
        bottom: true,
        top: true,
        child: Obx(
              ()=>Scaffold(
            key: scaffoldKey,
            body:selectedPage.value==0?ProfilePageDriver(
              myCallback: this,
            ):selectedPage.value==1?driverTripHomePage:Container(),
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
  void ontap(Map? clickEvent) {
    log("HOMEPAGE Driver $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey(General.eventName)){
        if(clickEvent[General.eventName]==General.FormSubmit){
          General().formSubmit(guid, widgets,clickEvent,queryString,myCallback: this);
        }
        else if(clickEvent[General.eventName]==General.Navigation){
          General().navigation(clickEvent[General.navigateToPage],clickEvent[General.typeOfNavigation]);
        }
        else if(clickEvent[General.eventName]=='HomePageDriverNavigation'){
          setState(() {
            selectedPage.value=clickEvent['pageIndex'];
          });
          scaffoldKey.currentState!.openEndDrawer();
          if(selectedPage.value==1){
            determinePosition();
          }
        }
        else if(clickEvent[General.eventName]=='OpenDrawer'){
          scaffoldKey.currentState!.openDrawer();
        }
        else if(clickEvent[General.eventName]=='reloadBookingPage'){
          log("reload");

        }

      }
    }
  }

  @override
  void onTextChanged(String text,Map map) {
    // TODO: implement onTextChanged
  }

  @override
  void onMapLocationChanged(Map map) {
    // TODO: implement onMapLocationChanged
  }

}*/


class HomePageDriver2 extends StatelessWidget  implements MyCallback{

  HomePageDriver2(){
    print("constructor");
    registerNotification();
    checkForInitialMessage();
    parseJson();
    driverTripHomePage=DriverTripHomePage(myCallback: this);
  }
  late DriverTripHomePage driverTripHomePage;
  GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();

  var widgets=[].obs;
  List<dynamic> queryString=[];
  var parsedJson;

  var isLoad=false.obs;
  String guid="";

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



  late final FirebaseMessaging _messaging;
  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message title Open: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data['valueArray'].runtimeType} ${jsonDecode(message.data['valueArray'])}');

        onNotificationReceived(jsonDecode(message.data['valueArray']));
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('onMessage Click OpenedApp title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
        onNotificationReceived(jsonDecode(message.data['valueArray']));
      });

    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      onNotificationReceived(jsonDecode(initialMessage.data['valueArray']));
    }
  }


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
        if(clickEvent[General.eventName]==General.FormSubmit){
          General().formSubmit(guid, widgets,clickEvent,queryString,myCallback: this);
        }
        else if(clickEvent[General.eventName]==General.Navigation){
          General().navigation(clickEvent[General.navigateToPage],clickEvent[General.typeOfNavigation]);
        }
        else if(clickEvent[General.eventName]=='HomePageDriverNavigation'){

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
          General().navigation(clickEvent[General.navigateToPage],clickEvent[General.typeOfNavigation]);
        }

      }
    }
  }

  @override
  void onTextChanged(String text,Map map) {
    // TODO: implement onTextChanged
  }

  @override
  void onMapLocationChanged(Map map) {
    // TODO: implement onMapLocationChanged
  }
}

