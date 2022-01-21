import 'package:flutter/material.dart';

import 'customControllers/callBack/myCallback.dart';
import 'customControllers/utils.dart';

class NavIcon extends StatelessWidget {
  MyCallback ontap;
  Map map;
  NavIcon({required this.ontap,required this.map});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("hi");
        ontap.ontap(map['clickEvent']);
      },
      child: Container(
        height: double.parse(map['height'].toString()),
        width: double.parse(map['width'].toString()),
        margin: parseEdgeInsetsGeometry(map['margin']),
        padding: parseEdgeInsetsGeometry(map['padding']),
        decoration: BoxDecoration(
          color: parseHexColor(map['color']),
          borderRadius:map.containsKey('shape')?null: parseBorderRadius(map['borderRadius']),
        ),


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 1.8,
              width: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
              ),
            ),
            SizedBox(height: 4,),
            Container(
              height: 1.7,
              width: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
              ),
            ),
            SizedBox(height: 4,),
            Container(
              height: 1.8,
              width: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
