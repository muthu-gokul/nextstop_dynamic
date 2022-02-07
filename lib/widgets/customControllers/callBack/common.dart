
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../pages/dynamicPageInitiater.dart';





class Common{
  findUpdateByKeyWidgetType(List valueArray ,List widgets){

     valueArray.forEach((element) {
      findWidgetByKey(widgets,element,(wid){
        // log("query wid $wid ${wid.getType()}");
        updateByWidgetType(wid.getType(),widget: wid,clickEvent: element);
      });
    });
  }


}