import 'package:flutter/material.dart';


import '../buttonController.dart';
import '../dynamicRowController.dart';
import '../hiddenController.dart';
import '../imageController.dart';
import '../inputBoxController.dart';
import '../profiePicController.dart';
import '../registrationPageController.dart';
import '../rowController.dart';
import '../sizedBoxController.dart';
import '../templateController.dart';
import '../textController.dart';

abstract class MyCallback {
  void ontap(Map? clickEvent);
}

abstract class MyCallback2 {
  validate();
  getValue();
}



List<dynamic> getWidgets(List parsed,MyCallback myCallback){
  //print(parsed.length);
  parsed.sort((a,b)=>int.parse(a['orderBy'].toString()).compareTo(int.parse(b['orderBy'].toString())));
  List<dynamic> widgets=[];
  parsed.forEach((element) {
    // print(element);
    if(element['type']=='text'){
      widgets.add(TextBoxController(map: element));
    }
    else if(element['type']=='textField'){
      widgets.add(TextFormFieldController(map: element));
    }
    else if(element['type']=='button'){
      widgets.add(ButtonController(map: element, ontap: myCallback,));
    }
    else if(element['type']=='dynamicTextBox'){
      widgets.add(DynamicTextBox(map: element,));
    }
    else if(element['type']=='sizedBox'){
      widgets.add(SizedBoxController(map: element,));
    }
    else if(element['type']=='template'){
      widgets.add(TemplateMaster(element['templateName']).getWidget());
    }
    else if(element['type']=='registrationTemplate'){
      widgets.add(RegistrationTemplate(element['templateName']).getWidget(element,myCallback));
    }
    else if(element['type']=='propicController'){
      widgets.add(ProfilePicController(data: element));
    }
    else if(element['type']=='imageController'){
      widgets.add(ImageController(map: element));
    }
    else if(element['type']=='rowController'){
      widgets.add(RowController(map: element,myCallback: myCallback,));
    }
    else if(element['type']=='hiddenController'){
      widgets.add(HiddenController(map: element));
    }
  });
  return widgets;
}



Widget getChild(Map map){
  if(map['type']=='text'){
   return TextBoxController(map: map);
  }
  else if(map['type']=='textField'){
    return TextFormFieldController(map: map);
  }
  else if(map['type']=='sizedBox'){
    return SizedBoxController(map: map);
  }
  else if(map['type']=='imageController'){
    return ImageController(map: map);
  }
  return Container();
/*  else if(element['type']=='button'){
    widgets.add(Btn(map: map, ontap: myCallback,));
  }*/
}
