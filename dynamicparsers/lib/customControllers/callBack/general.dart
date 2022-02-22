
import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double topPad=0.0;
String err001="Error 001";//INVALID JSON RESULT SET
String err002="No Page Found";

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  /*if (!serviceEnabled) {
      return Future.error('Location services are disabled ${serviceEnabled}.');
    }*/
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

findWidgetByKey(List<dynamic> widgets,Map? clickEvent,Function(dynamic widget) returnFunction){
  // log("key ${clickEvent} $widgets");
  var a;
  for(int i=0;i<widgets.length;i++){
    a= func1ByKey(widgets[i],clickEvent,returnFunction);
    // log("aaaaa $a ");
    if(a!=null){
      returnFunction(a);
      // a.textEditingController.text=clickEvent!['value'];
      // a.map['value']=clickEvent['value'];
      break;

    }
  }
  return null;
}
func1ByKey(dynamic widget,Map? clickEvent,Function(dynamic widget) returnFunction){
  // log("widget.map ${widget.runtimeType}");
  if(widget.runtimeType==Icon){
    return;
  }
  if(widget.map.containsKey("child")){
     //log("cc${widget.getType()} ${widget.widget} ${widget.map['key']}");
    // func1ByKey(widget.widget,clickEvent,returnFunction);

    if(widget.map.containsKey('key')){
      //log("ccc ${widget.getType()}");
      if(widget.map['key']==clickEvent!['key']){
        return returnFunction(widget);
        return widget;
      }
      else{
        var aa= func1ByKey(widget.widget,clickEvent,returnFunction);
        if(aa!=null){
          returnFunction(aa);
          return;
          return aa;
        }
      }
    }
    else{
      var aa= func1ByKey(widget.widget,clickEvent,returnFunction);
      if(aa!=null){
        returnFunction(aa);
        return;
        return aa;
      }
    }

  }
  else if(widget.map.containsKey("children")){

    if(widget.map.containsKey('key')){
      if(widget.map['key']==clickEvent!['key']){
        return returnFunction(widget);
        return widget;
      }
      else{
        if(widget.getType()!='userRoleController') {
          findWidgetByKey(widget.widgets,clickEvent,returnFunction);
        }
      }
    }
    else{
      if(widget.getType()!='userRoleController') {
        findWidgetByKey(widget.widgets,clickEvent,returnFunction);
      }
    }
  }
  if(widget.map.containsKey("suffix")){
    if(widget.map.containsKey('key')){
      if(widget.map['key']==clickEvent!['key']){
        return returnFunction(widget);
        return widget;
      }
      else{
        var aa= func1ByKey(widget.suffix,clickEvent,returnFunction);
        if(aa!=null){
          returnFunction(aa);
          return;
          return aa;
        }
      }
    }
    else{
      var aa= func1ByKey(widget.suffix,clickEvent,returnFunction);
      if(aa!=null){
        returnFunction(aa);
        return;
        return aa;
      }
    }

  }
  else{
    // log("else3 ${widget.map}");
    if(widget.map.containsKey('key')){
      if(widget.map['key']==clickEvent!['key']){
        return returnFunction(widget);
        return widget;
      }
      // log("else2 ${widget.getType()}  has key ${widget.map['key']}    ${clickEvent['key']}");
    }
  }
  return null;
}
findAndUpdateTextEditingController(var widget,Map? clickEvent){
 // log("clickEvent['value'] ${clickEvent!['value']}");
  if(clickEvent!['value']!=null){
    widget.textEditingController.text=clickEvent['value'];
    widget.map['value']=clickEvent['value'];
  }
  if(clickEvent['obscureText']!=null){
    widget.obscureText.value=clickEvent['obscureText'];
    widget.map['obscureText']=clickEvent['obscureText'];
  }

}
updateByWidgetType(String widgetType,{var widget,Map? clickEvent}){
  //log("update $widgetType $clickEvent");
  switch (widgetType){
    case 'textField':{
      findAndUpdateTextEditingController( widget, clickEvent);
    }
    break;
    case 'text':{
      // log("TEXT $widgetType $widget $clickEvent");
      widget.text.value=clickEvent!['value'];
      widget.map['value']=clickEvent['value'];
    }
    break;
    case 'hiddenController':{
      widget.map['value']=clickEvent!['value'];
    }
    break;
    case 'visibilityController':{
      widget.map['isVisible']=clickEvent!['value'];
      widget.isVisible.value=clickEvent['value'];
    }
    break;
    case 'listViewBuilderController':{
      widget.map['value']=clickEvent!['value'];
      widget.updateValues(clickEvent['value']);
    }
    break;
    case 'imageController':{
      widget.map['image']=clickEvent!['value'];
      widget.image.value=clickEvent['value'];
    }
    break;
    case 'svgController':{
      widget.map['image']=clickEvent!['value']['image'];
      widget.image.value=clickEvent['value']['image'];
      if(clickEvent['value'].containsKey("height")){
        widget.map['height']=clickEvent['value']['height'];
        widget.height.value=clickEvent['value']['height'];
      }
      if(clickEvent['value'].containsKey("width")){
        widget.map['width']=clickEvent['value']['width'];
        widget.width.value=clickEvent['value']['width'];
      }
    }
    break;
    case 'button':{
      widget.map['clickEvent']=clickEvent!['value'];
    }
    break;
    default: {
      log("dfault");
    }
    break;
  }
}