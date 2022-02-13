import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nextstop_dynamic/styles/style.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:nextstop_dynamic/widgets/sizeLocal.dart';


 MapTemplateParent(String templateName,Map map,MyCallback myCallback){
    if(templateName=='MapTemplateOne'){
      return MapTemplate(map: map,myCallback: myCallback,);
    }
    else{
      return MapTemplate2(map: map,myCallback: myCallback,);
    }
  }




class MapTemplate extends StatelessWidget implements MyCallback,MyCallback2,TestCallback{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  MapTemplate({required this.map,required this.myCallback})
  {
    if(map.containsKey('children')){

      widgets=getWidgets(map['children'], this);
    }
     getPos();
    //log("map");
  }

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Location Name:";
  Position? position;

  var isPickUpLocation=true.obs;

  getPos() async{
    position=await _determinePosition();
    animateCamera(position);
    log("position $position");
  }

  animateCamera(Position? position ){
    if(position!=null && mapController!=null){
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 12.4746,
              target: LatLng(position.latitude, position.longitude)
          )
      ));
      onCameraChange();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  var markers = <Marker>[].obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight!-double.parse(map['reducedHeight'].toString()),
      width: SizeConfig.screenWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            ()=> GoogleMap( //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true, //enable Zoom in, out on map
              // mapToolbarEnabled: false,
              // myLocationEnabled: false,
              // myLocationButtonEnabled: false,
              markers: Set<Marker>.of(markers.value),
              initialCameraPosition: CameraPosition( //innital position in map
                target: startLocation, //initial position
                zoom: 14.0, //initial zoom level
              ),
              mapType: MapType.normal, //map type
              onMapCreated: (controller) { //method called when map is created
             //   setState(() {
                  mapController = controller;
                 // getPos();
                  animateCamera(position);
             //   });
              },
              onCameraMove: (CameraPosition cameraPositiona) {
                cameraPosition = cameraPositiona; //when map is dragging
              },
              onCameraIdle: () async {
                onCameraChange();//when map drag stops

              },
              onTap: (latlon){
                print(latlon);
                onMapTap(latlon);
              },
            ),
          ),
          /*Obx(
              ()=>Icon(Icons.location_on,size: 50,color: isPickUpLocation.value?Colors.red:Colors.green,)
          )*/

        ],
      ),
    );
  }

  @override
  void ontap(Map? clickEvent) {
    log("pickerclickEvent ");

  }

  @override
  getType() {
    return map['type'];
  }

  @override
  getValue() {
    // TODO: implement getValue
    throw UnimplementedError();
  }

  @override
  validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }

  @override
  void onTextChanged(String text,Map map) {
    // TODO: implement onTextChanged
  }

  @override
  onCameraChange() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
/*    location = placemarks.first.name.toString() + ", " +  placemarks.first.thoroughfare.toString()+", "+placemarks.first.subLocality.toString()+", "
        +placemarks.first.administrativeArea.toString();*/
    String delim1=placemarks.first.thoroughfare.toString().isNotEmpty?", ":"";
    String delim2=placemarks.first.subLocality.toString().isNotEmpty?", ":"";
    String delim3=placemarks.first.administrativeArea.toString().isNotEmpty?", ":"";
    location = placemarks.first.name.toString() +
        delim1 +  placemarks.first.thoroughfare.toString()+
        delim2+placemarks.first.subLocality.toString()+
        delim3 +placemarks.first.administrativeArea.toString();
    //log("$location ${placemarks.first}");
    myCallback.onMapLocationChanged(
        {
          "key":isPickUpLocation.value?"PickUp":"Drop",
          "location":location,
          "latitude":cameraPosition!.target.latitude,
          "longitude":cameraPosition!.target.longitude
        }
    );
    markers.value=[];
    markers.value.add(
        Marker(
            markerId: MarkerId('1'),
            position:LatLng(cameraPosition!.target.latitude, cameraPosition!.target.longitude),
           /* infoWindow: InfoWindow(
                title: isPickUpLocation.value?'Pickup Location':'Drop Location'
            ),*/
            onTap: (){

            },
          visible: true,
          icon:  await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)), isPickUpLocation.value?'assets/icons/location-01.png':'assets/icons/location-02.png')
        )
    );
  }

  @override
  void onMapLocationChanged(Map map) {
    // TODO: implement onMapLocationChanged
  }

  @override
  onMapTap(LatLng latLng) async{
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
/*    location = placemarks.first.name.toString() + ", " +  placemarks.first.thoroughfare.toString()+", "+placemarks.first.subLocality.toString()+", "
        +placemarks.first.administrativeArea.toString();*/
    String delim1=placemarks.first.thoroughfare.toString().isNotEmpty?", ":"";
    String delim2=placemarks.first.subLocality.toString().isNotEmpty?", ":"";
    String delim3=placemarks.first.administrativeArea.toString().isNotEmpty?", ":"";
    location = placemarks.first.name.toString() +
        delim1 +  placemarks.first.thoroughfare.toString()+
        delim2+placemarks.first.subLocality.toString()+
        delim3 +placemarks.first.administrativeArea.toString();
    log("$location ${placemarks.first}");
    myCallback.onMapLocationChanged(
        {
          "key":isPickUpLocation.value?"PickUp":"Drop",
          "location":location,
          "latitude":latLng.latitude,
          "longitude":latLng.longitude
        }
    );
    markers.value=[];
    markers.value.add(
        Marker(
            markerId: MarkerId('1'),
            position:LatLng(latLng.latitude, latLng.longitude),
            /*infoWindow: InfoWindow(
                title: isPickUpLocation.value?'Pickup Location':'Drop Location'
            ),*/
            onTap: (){

            },
            visible: true,
            icon:  await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)), isPickUpLocation.value?'assets/icons/location-01.png':'assets/icons/location-02.png')
    )
    );
  }
}


class MapTemplate2 extends StatelessWidget implements MyCallback,MyCallback2,TestCallback{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  MapTemplate2({required this.map,required this.myCallback})
  {
    if(map.containsKey('children')){

      widgets=getWidgets(map['children'], this);
    }
    getPos();
   // addMarkers();
    //log("map");
  }

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;

  String location = "Location Name:";
  Position? position;

  var isPickUpLocation=true.obs;

  var markers = <Marker>[].obs;
  PolylinePoints polylinePoints = PolylinePoints();
  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs; //polylines to show direction

  LatLng startLocation = LatLng(27.6683619, 85.3101895);
  LatLng endLocation = LatLng(27.6688312, 85.3077329);

  getPos() async{
    position=await _determinePosition();
    animateCamera(position);
    log("position $position");
  }

  animateCamera(Position? position ){
    if(position!=null && mapController!=null){
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 12.4746,
              target: LatLng(position.latitude, position.longitude)
          )
      ));
      onCameraChange();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  addMarkers() async {
    markers.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)), 'assets/icons/location-01.png') //Icon for Marker
    ));

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)),'assets/icons/location-02.png') //Icon for Marker
    ));
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
      print(result.errorMessage);
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

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight!-double.parse(map['reducedHeight'].toString()),
      width: SizeConfig.screenWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            ()=> GoogleMap( //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true, //enable Zoom in, out on map
              // mapToolbarEnabled: false,
              // myLocationEnabled: false,
              // myLocationButtonEnabled: false,
              markers: Set<Marker>.of(markers.value),
              initialCameraPosition: CameraPosition( //innital position in map
                target: startLocation, //initial position
                zoom: 14.0, //initial zoom level
              ),
              mapType: MapType.normal, //map t
              //polylines: Set<Polyline>.of(polylines.values),// ype
              onMapCreated: (controller) { //method called when map is created
             //   setState(() {
                  mapController = controller;
                  animateCamera(position);
             //   });
              },
              onCameraMove: (CameraPosition cameraPositiona) {
              //  cameraPosition = cameraPositiona; //when map is dragging
              },
              onCameraIdle: () async {
              //  onCameraChange();//when map drag stops

              },
              onTap: (latlon){

              },

            ),
          ),
          /*Obx(
              ()=>Icon(Icons.location_on,size: 50,color: isPickUpLocation.value?Colors.red:Colors.green,)
          )*/

        ],
      ),
    );
  }

  @override
  void ontap(Map? clickEvent) {
    log("pickerclickEvent ");

  }

  @override
  getType() {
    return map['type'];
  }

  @override
  getValue() {
    // TODO: implement getValue
    throw UnimplementedError();
  }

  @override
  validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }

  @override
  void onTextChanged(String text,Map map) {
    // TODO: implement onTextChanged
  }

  @override
  onCameraChange() async {
    markers.value=[];
    markers.value.add(
        Marker(
            markerId: MarkerId('1'),
            position:LatLng(cameraPosition!.target.latitude, cameraPosition!.target.longitude),
           /* infoWindow: InfoWindow(
                title: isPickUpLocation.value?'Pickup Location':'Drop Location'
            ),*/
            onTap: (){

            },
          visible: true,
          icon:  await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)), isPickUpLocation.value?'assets/icons/location-01.png':'assets/icons/location-02.png')
        )
    );
  }

  @override
  void onMapLocationChanged(Map map) {
    // TODO: implement onMapLocationChanged
  }

  @override
  onMapTap(LatLng latLng) async{

    markers.value=[];
    markers.value.add(
        Marker(
            markerId: MarkerId('1'),
            position:LatLng(latLng.latitude, latLng.longitude),
            /*infoWindow: InfoWindow(
                title: isPickUpLocation.value?'Pickup Location':'Drop Location'
            ),*/
            onTap: (){

            },
            visible: true,
            icon:  await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)), isPickUpLocation.value?'assets/icons/location-01.png':'assets/icons/location-02.png')
    )
    );
  }
}
