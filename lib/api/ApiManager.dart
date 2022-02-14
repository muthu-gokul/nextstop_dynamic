import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


//BuildContext context
class ApiManager{

   ApiCallGetInvoke(var body,) async {
    try{
     // var itemsUrl="http://183.82.32.76/restroApi///api/Mobile/GetInvoke";
    //  var itemsUrl="http://192.168.1.102//Quarry_Dev/QuarryApi_Dev///api/Mobile/GetInvoke";
    // var itemsUrl="http://192.168.1.102//nextStop_dev///api/Mobile/GetInvoke";
      var itemsUrl="http://45.126.252.78/nextStop_dev/api/Mobile/GetInvoke";
     // var itemsUrl="https://quarrydemoapi.herokuapp.com/api/users/login";
    //  var itemsUrl="https://spectacular-salty-meeting.glitch.me/api/users/login";
    //  var itemsUrl="http://10.0.2.2:8080/api/users/login";
    //  var itemsUrl="http://117.247.181.35/restroApi///api/Mobile/GetInvoke";
      final response = await http.post(Uri.parse(itemsUrl),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body)
      );
      print("${response.statusCode} ${response.body}");
      if(response.statusCode==200){
        return [true,response.body];
      }
      else{

        var msg;
        // print(msg);
         print("${response.statusCode} ${response.body}");
        msg=json.decode(response.body);
        return [false,response.body];
        // return response.statusCode.toString();
      }
    }
    catch(e){
      return [false,"Catch Api"];

    }
  }
}
/*
http.post(url,
body: json.encode(body),
headers: { 'Content-type': 'application/json',
'Accept': 'application/json',
"Authorization": "Some token"},
encoding: encoding)*/
