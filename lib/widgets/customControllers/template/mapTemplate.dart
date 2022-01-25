import 'dart:developer';

import 'package:date_format/date_format.dart';
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
class MapTemplate extends StatelessWidget implements MyCallback,MyCallback2{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  MapTemplate({required this.map,required this.myCallback})
  {
    if(map.containsKey('children')){

      widgets=getWidgets(map['children'], this);
    }
    getPos();
    log("map");
  }

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Location Name:";
  Position? position;

  getPos() async{
    position=await _determinePosition();
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          zoom: 12.4746,
          target: LatLng(position!.latitude, position!.longitude)
      )
    ));
    log("$position");
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight!-410,
      width: SizeConfig.screenWidth,
      child: GoogleMap( //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        mapToolbarEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,

        initialCameraPosition: CameraPosition( //innital position in map
          target: startLocation, //initial position
          zoom: 14.0, //initial zoom level
        ),
        mapType: MapType.normal, //map type
        onMapCreated: (controller) { //method called when map is created
       //   setState(() {
            mapController = controller;
       //   });
        },
        onCameraMove: (CameraPosition cameraPositiona) {
          cameraPosition = cameraPositiona; //when map is dragging
        },
        onCameraIdle: () async { //when map drag stops
          List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
          //setState(() { //get place name from lat and lang
            location = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
         // });
          log("$location");
        },
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
}
