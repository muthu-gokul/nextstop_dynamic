import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextstop_dynamic/pages/bookingPage.dart';
import 'package:nextstop_dynamic/pages/profilePage.dart';
import 'package:nextstop_dynamic/styles/style.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'dynamicPageInitiater.dart';
import 'myTrips.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
var selectedPage=0.obs;

class _HomePageState extends State<HomePage> implements MyCallback{
  GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();

  List<dynamic> widgets=[];
  List<dynamic> queryString=[];
  var parsedJson;

  String guid="";

  parseJson() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/${General.homePageIdentifier}.json");
    parsedJson=jsonDecode(data);

    //guid=widget.pageIdentifier;
    widgets=getWidgets(parsedJson['Widgets'],this);
    if(parsedJson.containsKey('queryString')){
      queryString=parsedJson['queryString'];
    }
    setState(() {
      bookingPage=BookingPage(myCallback: this);
    });
    //log("${widgets}");
  }

  late BookingPage? bookingPage;

  @override
  void initState() {
    parseJson();
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
            body:selectedPage.value==0?ProfilePage(
              myCallback: this,
            ):selectedPage.value==1?BookingPage(myCallback: this):
            selectedPage.value==2?MyTrips(
              myCallback: this,
            ):Container(),
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
    log("HOMEPAGE $clickEvent");
    if(clickEvent!=null){
      if(clickEvent.containsKey('eventName')){
        if(clickEvent['eventName']=='FormSubmit'){
          General().formSubmit(guid, widgets,clickEvent,queryString,myCallback: this);
        }
        else if(clickEvent['eventName']=='Navigation'){
          General().navigation(clickEvent['navigateToPage'],clickEvent['typeOfNavigation']);
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



