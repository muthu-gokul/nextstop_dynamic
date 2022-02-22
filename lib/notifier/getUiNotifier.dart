import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/utils/general.dart';
import '../api/ApiManager.dart';
import '../model/parameterMode.dart';
import '../constants.dart';
import 'package:get/get.dart';


class GetUiNotifier {

  Future<dynamic> getUiJson(String pageId,int? loginUserId) async {
    parameters=[
      ParameterModel(Key: "SpName", Type: "String", Value: "USP_GetPageInfo"),
      ParameterModel(Key: "LoginUserId", Type: "int", Value: loginUserId),
      ParameterModel(Key: "PageIdentifier", Type: "String", Value: pageId),
      ParameterModel(Key: "DataJson", Type: "String", Value: null),
      ParameterModel(Key: "ActionType", Type: "String", Value: "Get"),
      ParameterModel(Key: "database", Type: "String", Value:"Nextstop_Dev"),
    ];
    var body={
      "Fields": parameters.map((e) => e.toJson()).toList()
    };
    print(jsonEncode(body));
    String val="";
    try{
      await ApiManager().ApiCallGetInvoke(body).then((value) {


      //  log("$value");
        if(value[0]){
          val=value[1];
        }
        else{
          Get.dialog(  CupertinoAlertDialog(
            title: Icon(Icons.error_outline,color: Colors.red,size: 50,),
            content: Text("${value[1]}",
              style: TextStyle(fontSize: 18),),
          ));
        }

        /*if(value!="null"){
        //  var parsed=json.decode(value);

        }*/
      });
      return val;
    }catch(e){
          print("CATCH $e");
    }
  }

  Future<dynamic> postUiJson(int? loginUserId,String pageId,String dataJson,Map clickEvent) async {
    parameters=[
      ParameterModel(Key: "SpName", Type: "String", Value: "USP_GetPageInfo"),
      ParameterModel(Key: "LoginUserId", Type: "int", Value: loginUserId),
      ParameterModel(Key: "PageIdentifier", Type: "String", Value: pageId),
      ParameterModel(Key: "DataJson", Type: "String", Value: dataJson),
      ParameterModel(Key: "ActionType", Type: "String", Value: clickEvent[General.actionType]),
      ParameterModel(Key: "database", Type: "String", Value:"Nextstop_Dev"),
    ];
    var body={
      "Fields": parameters.map((e) => e.toJson()).toList()
    };
    print(jsonEncode(body));
    var val=[];
    try{
      await ApiManager().ApiCallGetInvoke(body).then((value) {
         log("$value");
        val=value;
        /*if(value!="null"){
        //  var parsed=json.decode(value);

        }*/
      });
      return val;
    }catch(e){
          print("CATCH $e");
    }

  }
  Future<dynamic> notificationTokenUpdate(String token,int loginUserId) async {
    parameters=[
      ParameterModel(Key: "SpName", Type: "String", Value: "USP_UpdateNotificationDetail"),
      ParameterModel(Key: "LoginUserId", Type: "int", Value: loginUserId),
      ParameterModel(Key: "TokenNumber", Type: "String", Value: token),
      ParameterModel(Key: "DeviceId", Type: "String", Value: null),
      ParameterModel(Key: "database", Type: "String", Value:"Nextstop_Dev"),
    ];
    var body={
      "Fields": parameters.map((e) => e.toJson()).toList()
    };
    var val=[];
    try{
      await ApiManager().ApiCallGetInvoke(body).then((value) {
        log("$value");
        val=value;
        /*if(value!="null"){
        //  var parsed=json.decode(value);

        }*/
      });
      return val;
    }catch(e){
      print("CATCH $e");
    }

  }
  Future<dynamic> errorLog(String e,String t) async {
    parameters=[
      ParameterModel(Key: "SpName", Type: "String", Value: "USP_InsertErrorLogMobileDetail"),
      ParameterModel(Key: "LoginUserId", Type: "int", Value: LOGINUSERID),
      ParameterModel(Key: "AppPage", Type: "String", Value: e),
      ParameterModel(Key: "ErrorDescription", Type: "String", Value: t),
      ParameterModel(Key: "database", Type: "String", Value:"Nextstop_Dev"),
    ];
    var body={
      "Fields": parameters.map((e) => e.toJson()).toList()
    };
    var val=[];
    try{
      await ApiManager().ApiCallGetInvoke(body).then((value) {
        log("$value");
        val=value;
        /*if(value!="null"){
        //  var parsed=json.decode(value);

        }*/
      });
      return val;
    }catch(e){
      print("CATCH $e");
    }

  }
}