import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


//BuildContext context
class ApiManager{

   ApiCallGetInvoke(var body,) async {
    try{

    // var itemsUrl="http://192.168.1.102//nextStop_dev///api/Mobile/GetInvoke";
      var itemsUrl="http://45.126.252.78/nextStop_dev/api/Mobile/GetInvoke";

      final response = await http.post(Uri.parse(itemsUrl),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body)
      ).timeout(Duration(seconds: 30),onTimeout: ()=>onTme());
      print("${response.statusCode} ${response.body}");
      if(response.statusCode==200){
        return [true,response.body];
      }
      else{

        var msg;
        // print(msg);
         print("${response.statusCode} ${response.body}");
        msg=json.decode(response.body);
        return [false,msg['Message']];
        // return response.statusCode.toString();
      }
    }
    catch(e){
      return [false,"Catch Api"];

    }
  }

  onTme(){
    return [false,"Connection TimeOut"];
  }
}
/*
http.post(url,
body: json.encode(body),
headers: { 'Content-type': 'application/json',
'Accept': 'application/json',
"Authorization": "Some token"},
encoding: encoding)*/
