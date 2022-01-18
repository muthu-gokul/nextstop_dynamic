import 'package:flutter/material.dart';
import '../sizeLocal.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';
import 'package:get/get.dart';

class UserRoleController extends StatelessWidget {
  Map map;
  MyCallback ontap;
  var selectedIndex=(-1).obs;
  UserRoleController({required this.map,required this.ontap}){
    selectedIndex.value=map['selectedIndex'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: 100,
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: map['value'].length,
        itemBuilder: (ctx,i){
          return  GestureDetector(
            onTap: (){
              selectedIndex.value=i;
              // ontap.ontap(map['eventName']);
            //  ontap.ontap(map['clickEvent']);
            },
            child: Container(
              color: Colors.transparent,
              margin: parseEdgeInsetsGeometry(map['margin']),
              child: Column(
                children: [
                    Obx(
                        ()=>Container(
                            height: double.parse(map['height'].toString()),
                            width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:double.maxFinite,
                            //width:map.containsKey('width')? double.parse(map['width'].toString()):double.maxFinite,
                            alignment: parseAlignment(map['alignment']),
                            decoration: BoxDecoration(
                              //borderRadius: parseBorderRadius(map['borderRadius']),
                                color: parseHexColor(selectedIndex.value==i?map['color']:map['unselectColor']),
                                shape: BoxShape.circle
                            )
                        ),
                    ),
                    SizedBox(height: 10,),
                    Text("${map['value'][i]['title']}",style: parseTextStyle(map['textStyle']),)
                ],
              ),
            ),
            /*child: Container(
              margin: parseEdgeInsetsGeometry(map['margin']),
              height: double.parse(map['height'].toString()),
              width:map.containsKey('pixelWidth')?double.parse(map['pixelWidth'].toString()): map.containsKey('width')?map['width']*SizeConfig.screenWidth:double.maxFinite,
              //width:map.containsKey('width')? double.parse(map['width'].toString()):double.maxFinite,
              alignment: parseAlignment(map['alignment']),
              decoration: BoxDecoration(
                //borderRadius: parseBorderRadius(map['borderRadius']),
                color: parseHexColor(map['color']),
                shape: BoxShape.circle
              ),
              child: map.containsKey('child')?getChild(map['child']):Container(),
            ),*/
          );
        },
      ),
    );
  }

  validate(){
    if(selectedIndex.value==-1){
      return false;
    }
    return true;
  }

  getValue(){
    return map['value'][selectedIndex.value]['value'];
  }

}