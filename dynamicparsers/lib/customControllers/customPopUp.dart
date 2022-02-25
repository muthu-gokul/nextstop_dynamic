
import 'dart:developer';

import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:dynamicparsers/customControllers/utils.dart';
import 'package:dynamicparsers/widgets/popOver/popover.dart';
import 'package:dynamicparsers/widgets/sizeLocal.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomPopup extends StatelessWidget implements MyCallback2{
  List<dynamic>? data;
 late  String hintText;
late double leftMargin,reducedDropDownWidth;



  Map map;
  MyCallback myCallback;
  CustomPopup({required this.map,required this.myCallback}){
    data=map['data'];
    hintText=map['hintText'];
    showKey=map.containsKey("showKey")?map['showKey']:"";
    leftMargin =map.containsKey("leftMargin")?map['leftMargin']:0.0;
    reducedDropDownWidth =map.containsKey("reducedDropDownWidth")?map['reducedDropDownWidth']:0.0;
  }

  late String showKey;
  Rxn sv=Rxn();


  var isValid=true.obs;
  var errorText="* Required".obs;

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
            ()=>ButtonTheme(
              alignedDropdown: true,
              child: Container(
                margin: parseEdgeInsetsGeometry(map['margin']),
                //padding: parseEdgeInsetsGeometry(map['padding']),
               // width: SizeConfig.screenWidth!-30.0,
                decoration: BoxDecoration(
                  borderRadius:map.containsKey('shape')?null: parseBorderRadius(map['borderRadius']),
                  border: Border.all(color: parseHexColor(map['borderColor'],myCallback)!),
                  color:parseHexColor(map['color'],myCallback),
                ),
                alignment: Alignment.centerLeft,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<dynamic>(
                    // focusColor:Colors.white,
                    value: sv.value,
                   // elevation: 50,
                    style:  TextStyle(color: parseHexColor(map['textColor'], myCallback),fontSize: map['fontSize'],fontFamily: sv.value==null?'RL':'RR'),
                    iconEnabledColor:parseHexColor(map['arrowColor'], myCallback),
                    isExpanded: true,
                    iconSize: 30,
                    //dropdownColor: Colors.grey.shade100,
                    borderRadius:  parseBorderRadius(map['borderRadius']),
                    icon:  Icon(Icons.keyboard_arrow_down_rounded  ,),
                    items:data!.map<DropdownMenuItem<dynamic>>((dynamic value) {
                      return DropdownMenuItem<dynamic>(
                        value: value,
                        child: Text(showKey.isEmpty?"${value}":"${value[showKey]}",
                          style:TextStyle(color: parseHexColor(map['textColor'], myCallback),fontSize: map['fontSize'],fontFamily:'RR'),
                        ),
                      );
                    }).toList(),
                    hint:Text(
                        "${map['hintText']}",
                        style: TextStyle(color: parseHexColor(map['textColor'], myCallback),fontSize: map['fontSize'],fontFamily:'RR')
                    ),
                    onChanged: (dynamic value) {
                      //print(value);
                      sv.value=value;
                    },
                  ),
                ),
              ),
            )
        ),
        Obx(
                ()=>isValid.value?Container():Container(
                margin: parseEdgeInsetsGeometry(map['errorTextMargin']),
                child: Text(errorText.value,style: map.containsKey('errorTextStyle') ? parseTextStyle(map['errorTextStyle'],myCallback) : null,)
            )
        ),
      ],
    );

    /*return GestureDetector(
        onTap: (){
          showPopover(
            barrierColor: Colors.transparent,
            context: context,
            transitionDuration: const Duration(milliseconds: 150),
            bodyBuilder: (c) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data!.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx,index){
                      return   InkWell(
                        onTap: () {
                          log("${data![index]}");
                          sv.value=data![index];
                          Navigator.pop(ctx);
                        },
                        child: Container(
                          height: 50,
                          width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:0-reducedDropDownWidth-50,
                          padding: EdgeInsets.only(left: 20,),
                          //  margin: EdgeInsets.only(bottom: 3),
                          alignment: Alignment.centerLeft,
                          // color:selectedValue==data![index]?AppTheme.red: Color(0xFFf6f6f6),
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child:  Text(showKey.isEmpty?"${data![index]}":"${data![index][showKey]}",
                            style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Color(0xFF505050)
                              // color:selectedValue==data![index]?Colors.white: Color(0xFF555555),letterSpacing: 0.1
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            onPop: () => print('Popover was popped!'),
            direction: PopoverDirection.bottom,
            // width: 245,
            width: map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:0-reducedDropDownWidth-50,
            height: data!.length*50.0,
            arrowHeight: 0,
            arrowWidth: 0,
            //  backgroundColor: Color(0xFFf6f6f6),
            backgroundColor: Colors.red,
            contentDyOffset: 5,
            //isAttachRight: false,
            shadow:[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: Offset(0,0)
              )
            ],
            margin: 0,
            isCustom: true,
            leftMargin: leftMargin,
            constraints: BoxConstraints(
                maxHeight: 180
            ),
          );
        },
        child: Container(
          height: map.containsKey("height")?map['height']:50,
          width: map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:0-50,
          margin:parseEdgeInsetsGeometry(map['margin']),
          decoration: BoxDecoration(
            borderRadius:map.containsKey('shape')?null: parseBorderRadius(map['borderRadius']),
            border: Border.all(color: parseHexColor(map['borderColor'],myCallback)!),
            color:parseHexColor(map['color'],myCallback),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Obx(
                    () =>Text(sv.value==null?hintText:showKey.isEmpty?"${sv.value}":"${sv.value[showKey]}",
                  style: TextStyle(color: parseHexColor(map['textColor'], myCallback),fontSize: map['fontSize'],fontFamily: sv.value==null?'RL':'RR'),
                ),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down,size: 30,color:parseHexColor(map['arrowColor'], myCallback),),
              SizedBox(width: 15,)
            ],
          ),
        ),
      );*/

  }

  @override
  getType() {
   return map['type'];
  }

  @override
  getValue() {
    return sv.value;
  }

  @override
  validate() {
     if(sv.value==null){
       isValid.value=false;
     }
     else{
       isValid.value=true;
     }
     return isValid.value;
  }
}
