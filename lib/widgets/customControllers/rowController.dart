import 'package:flutter/material.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class RowController extends StatelessWidget {
  Map map;
  MyCallback myCallback;
  List widgets=[];
  RowController({required this.map,required this.myCallback})
  {
    if(map.containsKey('children')){
      widgets=getWidgets(map['children'], myCallback);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     // width: SizeConfig.screenWidth,
      child: Row(
        crossAxisAlignment: parseCrossAxisAlignment(map['crossAxisAlignment']),
        mainAxisAlignment: parseMainAxisAlignment(map['mainAxisAlignment']),
        children: [
          for(int i=0;i<widgets.length;i++)
            widgets[i]
        ],
      ),
    );
  }


}