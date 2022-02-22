import 'package:dynamicparsers/widgets/sizeLocal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class ImageController extends StatelessWidget implements MyCallback2{
  Map map;
  ImageController({required this.map}){
    image.value=map['image'];
  }
  var image="".obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>Image.asset(
              image.value,
              width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:null,
              height: map.containsKey('height')?map['height']:null,
              fit: BoxFit.cover,
        )
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

class SvgController extends StatelessWidget implements MyCallback2{
  Map map;
  SvgController({required this.map}){
    image.value=map['image'];
    width.value=map.containsKey('width')?map['width']:null;
    height.value=map.containsKey('height')?map['height']:null;
  }
  var image="".obs;
  Rxn height=Rxn();
  Rxn width=Rxn();


  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>SvgPicture.asset(
          image.value,
          width: width.value,
          height: height.value,
          fit: BoxFit.cover,
        )
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