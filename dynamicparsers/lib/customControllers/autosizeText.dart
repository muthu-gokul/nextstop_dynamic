import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'callBack/myCallback.dart';

import 'utils.dart';

class AutoSizeTextController extends StatelessWidget implements MyCallback2{
  Map map;
  Rxn ts=Rxn();
  Rxn text=Rxn();
  MyCallback myCallback;
  AutoSizeTextController({required this.map,required this.myCallback}){

    ts.value=map['style'];
    text.value=map['value'];

  }

  @override
  Widget build(BuildContext context) {

    return Obx(
            ()=>Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(text.value,style: parseTextStyle(ts.value,myCallback),),
          ),
        )
      /*()=> Container(
          key: globalKey,
          child: AutoSizeText(

            text.value,
            style:parseTextStyle( ts.value),
            maxLines: map['maxLines'],

          ),
        )*/
    );
  }

  @override
  getType() {
    return map['type'];
  }

  @override
  getValue() {
    // TODO: implement getValue
    throw UnimplementedError();
  }

  @override
  validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }
}
