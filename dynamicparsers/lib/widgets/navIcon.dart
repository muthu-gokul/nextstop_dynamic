import '../customControllers/callBack/myCallback.dart';
import 'package:flutter/material.dart';


import '../customControllers/utils.dart';

class NavIcon extends StatelessWidget implements MyCallback2{
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
          color: parseHexColor(map['color'],ontap),
          borderRadius:map.containsKey('shape')?null: parseBorderRadius(map['borderRadius']),
        ),


        child: Column(
          crossAxisAlignment:parseCrossAxisAlignment(map['crossAxisAlignment']),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 1.8,
              width: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: parseHexColor(map['strokeColor'],ontap),
              ),
            ),
            SizedBox(height: 4,),
            Container(
              height: 1.7,
              width: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: parseHexColor(map['strokeColor'],ontap),
              ),
            ),
            SizedBox(height: 4,),
            Container(
              height: 1.8,
              width: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: parseHexColor(map['strokeColor'],ontap),
              ),
            ),
          ],
        ),
      ),
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
