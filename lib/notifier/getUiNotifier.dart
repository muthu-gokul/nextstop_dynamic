import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import '../api/ApiManager.dart';
import '../model/parameterMode.dart';



import '../constants.dart';




class GetUiNotifier extends ChangeNotifier{

  Future<dynamic> getUiJson(BuildContext context,String pageId) async {
    parameters=[
      ParameterModel(Key: "SpName", Type: "String", Value: "USP_GetPageInfo"),
      ParameterModel(Key: "PageId", Type: "String", Value: pageId),
      ParameterModel(Key: "database", Type: "String", Value:"QMS"),
    ];
    var body={
      "Fields": parameters.map((e) => e.toJson()).toList()
    };
    print(jsonEncode(body));
    String val="";
    try{
      await ApiManager().ApiCallGetInvoke(body,context).then((value) {
      //  log("$value");
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
  Future<dynamic> postUiJson(BuildContext context,String responseId,String responseJson) async {
    parameters=[
      ParameterModel(Key: "SpName", Type: "String", Value: "USP_PostPageInfo"),
      ParameterModel(Key: "PageId", Type: "String", Value: responseId),
      ParameterModel(Key: "PageJson", Type: "String", Value: responseJson),
      ParameterModel(Key: "database", Type: "String", Value:"QMS"),
    ];
    var body={
      "Fields": parameters.map((e) => e.toJson()).toList()
    };

    String val="";
    try{
      await ApiManager().ApiCallGetInvoke(body,context).then((value) {
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