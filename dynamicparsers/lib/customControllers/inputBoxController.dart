import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';
class TextFormFieldController extends StatelessWidget implements MyCallback2{
  Map map;
  late TextEditingController textEditingController;
  Widget? suffix;
  Widget? prefix;
  MyCallback myCallback;
  TextFormFieldController({required this.map,required this.myCallback}){
    textEditingController= new TextEditingController(text: map['value']);
    obscureText.value=map.containsKey('obscureText')?map['obscureText']:false;
    if(map.containsKey('suffix')){
      suffix=getChild(map['suffix'],myCallback: myCallback);
    }
    if(map.containsKey('prefix')){
      prefix=getChild(map['prefix'],myCallback: myCallback);
    }
  }

  var isValid=true.obs;
  var obscureText=false.obs;
  var errorText="* Required".obs;


  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      alignment: Alignment.centerLeft,
      margin: parseEdgeInsetsGeometry(map['margin']),
      width: map.containsKey('width') ?double.parse(map['width'].toString())*SizeConfig.screenWidth!:SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FocusScope(
            child: Focus(
              onFocusChange: (focus){
                if(focus && map.containsKey('clickEvent')){
                  myCallback.ontap(map['clickEvent']);
                }
                log("focys $focus");
              },
              child: Obx(
                ()=>TextFormField(
                  controller: textEditingController,
                  style: map.containsKey('textStyle') ? parseTextStyle(map['textStyle'],myCallback) : null,
                  scrollPadding: EdgeInsets.only(bottom: 100),
                  obscureText: obscureText.value,
                  obscuringCharacter: '*',
                  readOnly: map.containsKey('readOnly')?map['readOnly']:false,
                  // onTap: map.containsKey('clickEvent')?(){
                  //   // ontap.ontap(map['eventName']);
                  //   myCallback.ontap(map['clickEvent']);
                  // }:null,
                  decoration: InputDecoration(
                      hintText: map['hintText'],
                      hintStyle: map.containsKey('hintTextStyle') ? parseTextStyle(map['hintTextStyle'],myCallback) : null,
                      enabled: map.containsKey('enable')?map['enable']:true,

                      filled: true,
                      fillColor: map.containsKey('enable')?map['enable']?parseHexColor(map['color'],myCallback):parseHexColor(map['disableColor'],myCallback):parseHexColor(map['color'],myCallback),
                      border: OutlineInputBorder(
                          borderRadius: parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['borderColor'],myCallback)!
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['borderColor'],myCallback)!
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['focusedBorderColor'],myCallback)!
                          )
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['disabledBorderColor'],myCallback)!
                          )
                      ),
                      contentPadding: EdgeInsets.only(top: map['topContentPadding']??0,
                          left: map['leftContentPadding']??10.0),
                      suffixIcon: suffix,
                      prefixIcon: prefix,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(map.containsKey('textLength')?int.parse(map['textLength'].toString()):null),
                    FilteringTextInputFormatter.allow(RegExp(map.containsKey('regExp')?map['regExp']:'[A-Za-z0-9@., ]')),
                  ],
                  keyboardType: parseTextInputType(map['textInputType']),
                  onChanged: (v){
                    myCallback.onTextChanged(v,map);
                  },
                  maxLines: map.containsKey("maxLines")?map['maxLines']:1,
                ),
              )
            ),
          ),
          Obx(
                  ()=>isValid.value?Container():Container(
                  margin: parseEdgeInsetsGeometry(map['errorTextMargin']),
                  child: Text(errorText.value,style: map.containsKey('errorTextStyle') ? parseTextStyle(map['errorTextStyle'],myCallback) : null,)
              )
          ),
        ],
      ),
    );
  }

  @override
  validate(){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Required";
    }
    else{
      isValid.value=true;
    }
    return isValid.value;
  }

  minLengthCheck(dynamic min){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Minimum Length is $min";
    }
    else if(textEditingController.text.length<int.parse(min.toString())){
      isValid.value=false;
      errorText.value="* Minimum Length is $min";

    }
    else{
      isValid.value=true;
    }
    return isValid.value;
  }

  maxLengthCheck(dynamic max){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Maximum Length is $max";
    }
    else if(textEditingController.text.length>int.parse(max.toString())){
      isValid.value=false;
      errorText.value="* Maximum Length is $max";

    }
    else{
      isValid.value=true;
    }
    return isValid.value;
  }
  emailValidation(){

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    if (!regex.hasMatch(textEditingController.text)) {
      isValid.value=false;
      errorText.value='* Email format is invalid';

    }
    else {
      isValid.value=true;
    }
    return isValid.value;
  }

  @override
  getValue(){
    return textEditingController.text;
  }

  @override
  getType() {
    return map['type'];
  }

}