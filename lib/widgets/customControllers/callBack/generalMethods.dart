
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'general.dart';

//FORM SUBMISSION CLICK EVENT AND RESULT JSON GENERATION
void formSubmitMethod(dynamic guid,List<dynamic> widgets,Map clickEvent){

  var result={
    "Guid":guid,
    "FieldArray":[]
  };
  List<bool> validList=[];
  bool isValid=true;

  result["FieldArray"]=[];
  List<dynamic> fields=[];
  validList=[];
  widgets.forEach((element) {
    //print(element);
    if(element.map.containsKey('hasInput')){
      // print(element.map["key"]);
      if(element.map['hasInput']){
        if(element.map['required']){

          if(element.map.containsKey('groupValidation')){
            for(int i=0;i<element.map['groupValidation'].length;i++){
              element.map['groupValidation'][i].forEach((key, value) {
                if(key=='Required'){
                  isValid=element.validate();
                  validList.add(isValid);
                }
                else if(key=='MinimumLength'){
                  isValid=element.minLengthCheck(value);
                  validList.add(isValid);
                }
                else if(key=='EmailValidation'){
                  isValid=element.emailValidation();
                  validList.add(isValid);
                }
                else if(key=='CompareTo'){
                  String v1,v2=element.getValue().toString();
                  widgets.forEach((e1) {
                    if(e1.map['key']==value){
                      v1=e1.getValue().toString();
                     /* print("element.getValue ${v1} $v2");*/
                      if(v1==v2){
                        isValid=true;
                        validList.add(isValid);
                      }
                      else{
                        isValid=false;
                        validList.add(isValid);
                      }
                    }
                  });
                }
              });
              if(isValid){
                continue;
              }
              else{
                break;
              }
            }
            fields.add({
              "${element.map["key"]}":element.getValue()
             // element.map["key"]:element.getValue()
            });
          }
          else{
            isValid=element.validate();
            validList.add(isValid);
            fields.add({
              "${element.map["key"]}":element.getValue()
             // element.map["key"]:element.getValue()
            });
          }
        }
        else{
          fields.add({
           "${element.map["key"]}":element.getValue()
           // element.map["key"]:element.getValue()
          });
        }
      }
    }
  });

  if(!validList.any((element) => element==false)){
   // print("VALID ${fields}");
    result["Guid"]=guid;
    result["FieldArray"]=fields;
    print((result));
    String? resJson= resultToJson(result);
    if(resJson==null){
      print("Invalid json");
      errorDialog(err001);
    }
    else{
      print("Valid json $resJson");
      if(clickEvent.containsKey('navigateToPage')){
        navigateTo(clickEvent['navigateToPage'],clickEvent['typeOfNavigation']);
      }
    }
   // Provider.of<GetUiNotifier>(context, listen: false).postUiJson(context, guid, result.toString());
  }
  else{
    print("INVALID ${fields}");
  }
}

//RESULT JSON
String? resultToJson(Map map){
  try{
    return jsonEncode(map);
  }catch(e){
    return null;
  }
}


//NAVIGATION
navigateTo(String page,int? typeOfNavigation,){
  if(typeOfNavigation==3){
    Get.back();
  }
  else{
    if(page=="SecurityDetails"){
     // getXNavigation(typeOfNavigation, SecurityDetails());
    }
    else if(page=="SecurityReports"){
    //  getXNavigation(typeOfNavigation, Reports());
    }
    else if(page=="GetStart"){
   //   getXNavigation(typeOfNavigation, DesignationSelect());
    }
    else{
      errorDialog(err002);
    }
  }

}

//GETX NAVIGATION
getXNavigation(int? typeOfNavigation,Widget widget){
  //Navigate to next Screen without Pop Previous Screen
  if(typeOfNavigation==1){
    Get.to(widget);
  }
  //Navigate to next Screen  Popping all  Previous Screen
  else if(typeOfNavigation==2){
    Get.off(widget);
  }
  //Pop Current Page
  else if(typeOfNavigation==3){
    Get.back();
  }
  else{
    Get.to(widget);
  }
}


//ERROR POPUP
errorDialog(String content){
  Get.defaultDialog(
    title: "Alert!",
    titlePadding: EdgeInsets.only(top: 20),
    content: Text(content,style: TextStyle(fontSize: 16,fontFamily: 'RR',color: Color(0xff9E9E9E)),),
    radius: 8.0,
  );
}