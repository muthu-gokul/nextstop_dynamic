import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class ProfilePicController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  ProfilePicController({required this.map,required this.myCallback});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: parseAlignment(map['alignment']),
      child: Stack(
        children: [
          Container(
            height: map.containsKey('height')?map['height']:110,
            width: map.containsKey('width')?map['width']:110,
            margin: EdgeInsets.only(top: 10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: parseHexColor(map['bgColor'],myCallback),
                border: Border.all(color: parseHexColor(map['borderColor'],myCallback)!,width: 3),
                //  color: AppTheme.yellowColor,
                boxShadow: []
            ),
            child:SvgPicture.asset(map['imagePath']),
          ),
          Positioned(
              bottom: 0,
              right:0,
              child: Container(
                  height: 35,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[700]
                  ),
                  child: Icon(Icons.camera_alt_outlined,color: Colors.white,size: 20,)
              )
          )
        ],
      ),
    );
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

  @override
  getType() {
    return map['type'];
  }
}
