import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';
import 'utils.dart';

class ImageController extends StatelessWidget implements MyCallback2{
  Map map;
  ImageController({required this.map});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      map['image'],
      width: map.containsKey('width')?map['width']:null,
      height: map.containsKey('height')?map['height']:null,
      fit: BoxFit.cover,
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
  SvgController({required this.map});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      map['image'],
      width: map.containsKey('width')?map['width']:null,
      height: map.containsKey('height')?map['height']:null,
      fit: BoxFit.cover,
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