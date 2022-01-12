import 'package:flutter/material.dart';

import '../sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';
class TextFormFieldController extends StatelessWidget implements MyCallback2{
  Map map;
  late TextEditingController textEditingController;
  TextFormFieldController({required this.map}){
    textEditingController= new TextEditingController(text: map['value']);
  }

  var isValid=true.obs;
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
          TextFormField(
            controller: textEditingController,
            style: map.containsKey('textStyle') ? parseTextStyle(map['textStyle']) : null,
            scrollPadding: EdgeInsets.only(bottom: 100),
            obscureText: map.containsKey('obscureText')?map['obscureText']:false,
            obscuringCharacter: '*',
            decoration: InputDecoration(
                hintText: map['hintText'],
                hintStyle: map.containsKey('hintTextStyle') ? parseTextStyle(map['hintTextStyle']) : null,
                enabled: map.containsKey('enable')?map['enable']:true,
                filled: true,
                fillColor: map.containsKey('enable')?map['enable']?parseHexColor(map['color']):parseHexColor(map['disableColor']):parseHexColor(map['color']),
                border: OutlineInputBorder(
                    borderRadius: parseBorderRadius(map['borderRadius']),
                    borderSide: BorderSide(
                        color: parseHexColor(map['borderColor'])
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: parseBorderRadius(map['borderRadius']),
                    borderSide: BorderSide(
                        color: parseHexColor(map['borderColor'])
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: parseBorderRadius(map['borderRadius']),
                    borderSide: BorderSide(
                        color: parseHexColor(map['focusedBorderColor'])
                    )
                ),
                disabledBorder: OutlineInputBorder(
                    borderRadius: parseBorderRadius(map['borderRadius']),
                    borderSide: BorderSide(
                        color: parseHexColor(map['disabledBorderColor'])
                    )
                ),
                contentPadding: EdgeInsets.only(top: 0,left: 10)
            ),
          ),
          Obx(
                  ()=>isValid.value?Container():Container(
                  margin: parseEdgeInsetsGeometry(map['errorTextMargin']),
                  child: Text(errorText.value,style: map.containsKey('errorTextStyle') ? parseTextStyle(map['errorTextStyle']) : null,)
              )
          ),
        ],
      ),
    );
  }

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

  getValue(){
    return textEditingController.text;
  }

}