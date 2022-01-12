import 'package:flutter/material.dart';
import 'utils.dart';

class ImageController extends StatelessWidget {
  Map map;
  ImageController({required this.map});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      map['image'],
      width: map['width'],
      fit: BoxFit.cover,
    );
  }
}