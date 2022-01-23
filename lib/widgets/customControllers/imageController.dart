import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'utils.dart';

class ImageController extends StatelessWidget {
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
}

class SvgController extends StatelessWidget {
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
}