import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:nextstop_dynamic/constants.dart';
import 'package:nextstop_dynamic/notifier/getUiNotifier.dart';
import 'package:nextstop_dynamic/pages/driver/homePageDriver.dart';
import 'package:nextstop_dynamic/pages/estimateBill.dart';
import 'package:nextstop_dynamic/pages/homePage.dart';
import 'package:nextstop_dynamic/pages/loginPage.dart';
import 'package:nextstop_dynamic/pages/registrationPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splashScreen.dart';
Future<void> main() async {
  // runZonedGuarded(() {
  //   runApp(const MyApp());
  // }, FirebaseCrashlytics.instance.recordError);

 // runApp(const MyApp());

  // WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
    GetUiNotifier().errorLog(error.toString(), stackTrace.toString());
  });
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
}

getApnToken() async{
  //await Firebase.initializeApp();
  SharedPreferences sp=await SharedPreferences.getInstance();
  String token= sp.getString("token")??"";
  if(token.isEmpty&&fromUrl){
    FirebaseMessaging.instance.getToken().then((value){
      sp.setString("token", value??"");
      print("FirebaseMessaging.instance.getAPNSToken();  $value");
      FirebaseDatabase.instance.ref().push().set({"LoginUserId":LOGINUSERID,"token":value});
      GetUiNotifier().notificationTokenUpdate(value??"", LOGINUSERID);
    });
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen()
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();



  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(27.6683619, 85.3101895);
  LatLng endLocation = LatLng(27.6688312, 85.3077329);


  @override
  void initState() {

    markers.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    getDirections(); //fetch direction polylines from Google API

    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCgWfUF_HEBqd5qjN7afJADJcZJOwXOgao",
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print("error ${result.errorMessage}");
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Route Driection in Google Map"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: GoogleMap( //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition( //innital position in map
          target: startLocation, //initial position
          zoom: 16.0, //initial zoom level
        ),
        markers: markers, //markers to show on map
        polylines: Set<Polyline>.of(polylines.values), //polylines
        mapType: MapType.normal, //map type
        onMapCreated: (controller) { //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}


/*

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Location Name:";
  List<Marker> markers = <Marker>[].obs;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Longitude Latitude Picker in Google Map"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Stack(
            children:[

              GoogleMap( //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                mapToolbarEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers:  Set<Marker>.of(markers),
                initialCameraPosition: CameraPosition( //innital position in map
                  target: startLocation, //initial position
                  zoom: 14.0, //initial zoom level
                ),
                mapType: MapType.normal, //map type
                onMapCreated: (controller) { //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona; //when map is dragging
                },
                onCameraIdle: () async { //when map drag stops
                  List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                  setState(() { //get place name from lat and lang
                    location = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
                    markers.clear();
                    markers.add(
                        Marker(
                            markerId: MarkerId('hfhfhfhf'),
                            position:LatLng(cameraPosition!.target.latitude, cameraPosition!.target.latitude),
                            infoWindow: InfoWindow(
                                title: 'hrllo'
                            ),
                            onTap: (){

                            },
                            visible: true,
                            icon: BitmapDescriptor.defaultMarker
                        )
                    );
                  });
                  log("$location");
                },
              ),

              */
/*Center( //picker image on google map
                child: Image.asset("assets/images/picker.png", width: 80,),
              ),


              Positioned(  //widget to display location name
                  bottom:100,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                           // leading: Image.asset("assets/images/picker.png", width: 25,),
                            title:Text(location, style: TextStyle(fontSize: 18),),
                            dense: true,
                          )
                      ),
                    ),
                  )
              )*//*

            ]
        )
    );
  }
}*/
