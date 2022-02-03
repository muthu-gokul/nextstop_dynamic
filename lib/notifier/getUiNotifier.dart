import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/general.dart';
import '../api/ApiManager.dart';
import '../model/parameterMode.dart';



import '../constants.dart';




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
        val=value[1];
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

}