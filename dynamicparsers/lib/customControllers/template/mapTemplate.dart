import 'dart:async';
import 'dart:convert';
import 'dart:developer';


import 'package:date_format/date_format.dart';
import 'package:dynamicparsers/customControllers/callBack/general.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:dynamicparsers/widgets/sizeLocal.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:flutter_date_pickers/flutter_date_pickers.dart';





 MapTemplateParent(String templateName,Map map,MyCallback myCallback){
   Widget widget=MapTemplate2(map: map,myCallback: myCallback,);
    if(templateName=='MapTemplateOne'){
      widget= MapTemplate(map: map,myCallback: myCallback,);
    }
    else if(templateName=="MapSample"){
      widget= MapSample(map: map, myCallback: myCallback,key: mapKey,);
    }
    else if(templateName=="MapTemplateThree"){
      widget= MapTemplate3(map: map, myCallback: myCallback,);
    }
    else{
       widget=MapTemplate2(map: map,myCallback: myCallback,);
    }
   return widget;
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

  GoogleMapController? mapController;
  Completer<GoogleMapController> _controller = Completer();
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

  animateCamera(Position? position ) async{
    log("animate camera $position");
    if(position!=null){
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 12.4746,
              target: LatLng(position.latitude, position.longitude)
          )
       )
      );
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

  reload(){
    mapController!.setMapStyle("[]");
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
              mapType: MapType.normal, //map type
              onMapCreated: (controller) {
                log("map Crete");
                  _controller.complete(controller);

                  //mapController = controller;
                  //animateCamera(position);
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
/*    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle("[]");*/
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


class MapTemplate2 extends StatefulWidget {
  Map map;
  MyCallback myCallback;
  List widgets=[];
  MapTemplate2({required this.map,required this.myCallback});
  final MapTemplate2State mapTemplate2State=MapTemplate2State();
  @override
  MapTemplate2State createState() => mapTemplate2State;

  getType(){
    return map['type'];
  }
  reload(){
    mapTemplate2State.reload();
  }
  animateCamera(Position? position ){
    mapTemplate2State.animateCamera(position);
  }

}

class MapTemplate2State extends State<MapTemplate2>  implements MyCallback,MyCallback2,TestCallback{
   GoogleMapController? mapController;
 // var mapController= Rxn<GoogleMapController>(); 
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? cameraPosition;

  String location = "Location Name:";

  Position? position;

  var isPickUpLocation=true.obs;

  var markers = <Marker>[].obs;

  PolylinePoints polylinePoints = PolylinePoints();

  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs; 

  LatLng startLocation = LatLng(27.6683619, 85.3101895);

  LatLng endLocation = LatLng(27.6688312, 85.3077329);

  @override
  initState(){
    if(widget.map.containsKey('children')){

      widget.widgets=getWidgets(widget.map['children'], this);
    }
    getPos();
  }

  getPos() async{
    position=await _determinePosition();
    animateCamera(position);
    log("position $position");
  }

  animateCamera(Position? position ) async{
      final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 12.4746,
              target: LatLng(position!.latitude, position.longitude)
          )
        )
      );
    /* if(position!=null && mapController!=null){
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 12.4746,
              target: LatLng(position.latitude, position.longitude)
          )
      ));
      onCameraChange();
    } */
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  addMarkers() async {
    markers.add(Marker(
      markerId: MarkerId(startLocation.toString()),
      position: startLocation,
      infoWindow: InfoWindow(
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)), 'assets/icons/location-01.png') //Icon for Marker
    ));

    markers.add(Marker(
      markerId: MarkerId(endLocation.toString()),
      position: endLocation,
      infoWindow: InfoWindow(
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

  reload() async{
     animateCamera(position);
     print("mapReload ");
   final GoogleMapController controller = await _controller.future;
   controller.setMapStyle("[]");

  
    //mapController!.setMapStyle("[]");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight!-double.parse(widget.map['reducedHeight'].toString()),
      width: SizeConfig.screenWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            ()=> GoogleMap(
              zoomGesturesEnabled: true,
              // mapToolbarEnabled: false,
              // myLocationEnabled: false,
              // myLocationButtonEnabled: false,
              markers: Set<Marker>.of(markers.value),
              
              initialCameraPosition: CameraPosition(
                target: startLocation,
                zoom: 14.0,
              ),
              mapType: MapType.normal,
              //polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (controller) {
                _controller.complete(controller);
               /* setState(() {
                  log("map created $controller");
                 // mapController = controller;

                  print("map Assignmed ${mapController}");
                 // animateCamera(position);
                });*/
              },
              onCameraMove: (CameraPosition cameraPositiona) {
              //  cameraPosition = cameraPositiona;
              },
              onCameraIdle: () async {
              //  onCameraChange();

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
    return widget.map['type'];
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










class MapTemplate3 extends StatefulWidget {
  Map map;
  MyCallback myCallback;
  List widgets=[];
  MapTemplate3({required this.map,required this.myCallback});
  final MapTemplate3State mapTemplate3State=MapTemplate3State();
  @override
  MapTemplate3State createState() => mapTemplate3State;

  getType(){
    return map['type'];
  }
  reload(){
    mapTemplate3State.reload();
  }
  animateCamera(Position? position ){
    mapTemplate3State.animateCamera(position);
  }
  changeIsPickUpLocation(bool value){
    mapTemplate3State.changeIsPickUpLocation(value);
  }

}

class MapTemplate3State extends State<MapTemplate3>  implements MyCallback,MyCallback2,TestCallback{
  //GoogleMapController? mapController;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? cameraPosition;

  String location = "Location Name:";

  Position? position;

  var isPickUpLocation=true.obs;

  var markers = <Marker>[].obs;

  PolylinePoints polylinePoints = PolylinePoints();

  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;

  LatLng startLocation = LatLng(27.6683619, 85.3101895);

  LatLng endLocation = LatLng(27.6688312, 85.3077329);

  @override
  initState(){
    if(widget.map.containsKey('children')){
      widget.widgets=getWidgets(widget.map['children'], this);
    }
    getPos();
  }

  getPos() async{
    position=await _determinePosition();
    animateCamera(position);
    log("position $position");
  }

  animateCamera(Position? position ) async{
    log("animate camera $position");
    if(position!=null){
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 12.4746,
              target: LatLng(position.latitude, position.longitude)
          )
      )
      );
      onCameraChange();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  addMarkers() async {
    markers.add(Marker(
        markerId: MarkerId(startLocation.toString()),
        position: startLocation,
        infoWindow: InfoWindow(
          title: 'Starting Point ',
          snippet: 'Start Marker',
        ),
        icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)), 'assets/icons/location-01.png') //Icon for Marker
    ));

    markers.add(Marker(
        markerId: MarkerId(endLocation.toString()),
        position: endLocation,
        infoWindow: InfoWindow(
          title: 'Destination Point ',
          snippet: 'Destination Marker',
        ),
        icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)),'assets/icons/location-02.png') //Icon for Marker
    ));
  }



  reload() async{
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle("[]");

    animateCamera(position);
    print("mapReload ");



    //mapController!.setMapStyle("[]");
  }

  changeIsPickUpLocation(bool value){
    isPickUpLocation.value=value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight!-double.parse(widget.map['reducedHeight'].toString()),
      width: SizeConfig.screenWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
                ()=> GoogleMap(
                  zoomGesturesEnabled: true,

                  markers: Set<Marker>.of(markers.value),
                  initialCameraPosition: CameraPosition(
                    target: startLocation,
                    zoom: 14.0, //initial zoom level
                  ),
                  mapType: MapType.normal, //map type
                  onMapCreated: (controller) {
                    log("map Crete");
                    _controller.complete(controller);

                    //mapController = controller;
                    //animateCamera(position);
                  },
                  onCameraMove: (CameraPosition cameraPositiona) {
                    cameraPosition = cameraPositiona; //when map is dragging
                  },
                  onCameraIdle: () async {
                    onCameraChange();//when map drag stops
                  },
                  onTap: (latlon){
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
    return widget.map['type'];
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
    widget.myCallback.onMapLocationChanged(
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
/*    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle("[]");*/
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
   // log("$location ${placemarks.first}");
    widget.myCallback.onMapLocationChanged(
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


//Testing
GlobalKey<MapSampleState> mapKey=GlobalKey();

class MapSample extends StatefulWidget {
  Map map;
  MyCallback myCallback;
  List widgets=[];
  MapSample({Key? key,required this.map,required this.myCallback}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
  getType(){
    return map['type'];
  }
  reload(){
    mapKey.currentState!.getPos();
  }
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Position? position;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  var polylines = <Polyline>[].obs;
  var markers = <Marker>[].obs;
  PolylinePoints polylinePoints = PolylinePoints();

//  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;
//13.388860,52.517037;13.397634,52.529407
  //-74.0060152,40.7127281;-77.0501718249326,38.88933725
//13.06505253819526, 80.17747072600484  ;   13.069316144944787, 80.19487311926038
  //13.014570027023268, 80.13510176865319
/*  LatLng startLocation = LatLng(13.388860, 52.517037);
  LatLng endLocation = LatLng(13.397634, 52.529407);*/

  LatLng startLocation = LatLng(13.06505253819526, 80.17747072600484);
  LatLng endLocation = LatLng(13.014570027023268, 80.13510176865319);
  getDirections() async {
    polylines.clear();
    double totalDistance=0.0;
    List<LatLng> polylineCoordinates = [];
    String url="https://router.project-osrm.org/route/v1/driving/${startLocation.longitude},${startLocation.latitude};${endLocation.longitude},${endLocation.latitude}?overview=false&steps=true";
    log("url ${Uri.parse(url)}");
    final response = await http.get(Uri.parse(url));
    log("res ${response.body}");
    var parsedRoute=jsonDecode(response.body);
    if(parsedRoute['code']=='Ok'){
      polylineCoordinates.add(startLocation);
      var steps=parsedRoute['routes'][0]['legs'][0]['steps'];
      log("steps ${steps.length}");
      steps.forEach((step){
        totalDistance=totalDistance+step['distance'];
        List  intersections=step['intersections'];
        intersections.forEach((intersection) {
          log("intersec $intersection");
          polylineCoordinates.add(LatLng(intersection['location'][1], intersection['location'][0]));
        });
      });
      polylineCoordinates.add(endLocation);
    }

   /* PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCgWfUF_HEBqd5qjN7afJADJcZJOwXOgao",
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );*/

    // polylineCoordinates.add(LatLng(40.712118, -74.005737));
    // polylineCoordinates.add(LatLng(38.890174, -77.050262));
    log("totalDistance $totalDistance");
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
      geodesic: true
    );
   // polylines[id] = polyline;
    polylines.add(polyline);
  }

  addMarkers() async {
    markers.clear();
    markers.add(Marker(
        markerId: MarkerId(startLocation.toString()),
        position: startLocation,
        visible: true,
        infoWindow: InfoWindow(
          title: 'Starting Point ',
          snippet: 'Start Marker',
        ),
        icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)), 'assets/icons/location-01.png') //Icon for Marker
    ));

    markers.add(Marker(
        markerId: MarkerId(endLocation.toString()),
        position: endLocation,
        visible: true,
        infoWindow: InfoWindow(
          title: 'Destination Point ',
          snippet: 'Destination Marker',
        ),
        icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)),'assets/icons/location-02.png') //Icon for Marker
    ));

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            zoom: 12.4746,
            target: LatLng(startLocation.latitude, startLocation.longitude)
        )
     )
    );

  }

  @override
  void initState() {
    print("initMap");
    getPos();
    super.initState();
  }

  @override
  didChangeDependencies(){
    print("didChangeMap");
  }


  getPos() async{
    // position=await determinePosition();
    // animateCamera(position);
  }

  animateCamera(Position? position ) async{
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle("[]");
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            zoom: 12.4746,
            target: LatLng(position!.latitude, position.longitude)
        )
    ));
    /* if(position!=null && mapController!=null){
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 12.4746,
              target: LatLng(position.latitude, position.longitude)
          )
      ));
      onCameraChange();
    } */
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         Obx(
             ()=> GoogleMap(
               mapType: MapType.normal,
               initialCameraPosition: _kGooglePlex,
               markers: Set<Marker>.of(markers.value),
               polylines: Set<Polyline>.of(polylines.value),
               onMapCreated: (GoogleMapController controller) {
                 _controller.complete(controller);
                 getDirections();
               },
             ),
         ),
          Positioned(
            top: 50,
            child: GestureDetector(
              onTap: (){
                print("Hi");
                getDirections();
                addMarkers();
              },
              child: Container(
                height: 80,
                width: 80,
                color: Colors.red,
              ),
            ),
          )

        ],
      ),
    );
  }



}
