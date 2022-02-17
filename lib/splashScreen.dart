import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'package:get/get.dart';

import 'pages/driver/homePageDriver.dart';
import 'pages/homePage.dart';
import 'pages/loginPage.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkLogin() async{
    await initializeFirebase();
    SharedPreferences sp=await SharedPreferences.getInstance();
    if(sp.getBool(ISLOGGEDINKEY)??false){
      //Logged in
      LOGINUSERID=sp.getInt(LOGINUSERIDKEY)??0;
      isDriver=sp.getBool(ISDRIVERKEY)??false;
      if(isDriver){
        Get.off(HomePageDriver2());
      }
      else{
        Get.off(HomePage());
      }
      getApnToken();
    }
    else{
      //Not Logged in
      Get.off(LoginPage());
    }
  }


  localNav() async{
     await initializeFirebase();
     FirebaseMessaging.instance.getToken().then((value){
       print("FirebaseMessaging.instance.getAPNSTokenLocal;  $value");
     });
     Get.off(HomePageDriver2());
    //  Get.off(HomePage());
  }

  @override
  void initState() {
    if(fromUrl){
      checkLogin();
    }
    else{
      localNav();
    }
    


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}