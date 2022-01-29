import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nextstop_dynamic/widgets/customControllers/template/mapTemplate.dart';
import 'package:nextstop_dynamic/widgets/customControllers/template/pickerTemplate.dart';
import 'package:nextstop_dynamic/widgets/customControllers/utils.dart';


import '../../navIcon.dart';
import '../alignController.dart';
import '../buttonController.dart';
import '../columnController.dart';
import '../dynamicRowController.dart';
import '../hiddenController.dart';
import '../imageController.dart';
import '../inputBoxController.dart';
import '../positionController.dart';
import '../profiePicController.dart';
import '../registrationPageController.dart';
import '../rowController.dart';
import '../sizedBoxController.dart';
import '../spacerController.dart';
import '../stackController.dart';
import '../templateController.dart';
import '../textController.dart';
import '../userRoleController.dart';

abstract class MyCallback {
  void ontap(Map? clickEvent);
  void onTextChanged(String text, Map map,);
  void onMapLocationChanged(Map map);
  //void ontap2(Map? clickEvent);
}

abstract class MyCallback2 {
  validate();
  getValue();
  getType();
}
abstract class TestCallback{
  onCameraChange();
  onMapTap(LatLng latLng);
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
    else if(element['type']=='spacerController'){
      widgets.add(SpacerController(map: element,));
    }
    else if(element['type']=='textField'){
      widgets.add(TextFormFieldController(map: element,myCallback: myCallback,));
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
      widgets.add(ProfilePicController(map: element));
    }
    else if(element['type']=='imageController'){
      widgets.add(ImageController(map: element));
    }
    else if(element['type']=='svgController'){
      widgets.add(SvgController(map: element));
    }
    else if(element['type']=='rowController'){
      widgets.add(RowController(map: element,myCallback: myCallback,));
    }
    else if(element['type']=='columnController'){
      widgets.add(ColumnController(map: element,myCallback: myCallback,));
    }
    else if(element['type']=='stackController'){
      widgets.add(StackController(map: element,myCallback: myCallback,));
    }
    else if(element['type']=='hiddenController'){
      widgets.add(HiddenController(map: element));
    }
    else if(element['type']=='userRoleController'){
      widgets.add(UserRoleController(map: element, ontap: myCallback,));
    }
    else if(element['type']=='navIcon'){
      widgets.add(NavIcon(map: element, ontap: myCallback,));
    }
    else if(element['type']=='positionController'){
      widgets.add(PositionController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='alignController'){
      widgets.add(AlignController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='pickerTemplate'){
      widgets.add(PickerTemplate(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='mapTemplate'){
      widgets.add(MapTemplate(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='icon'){
      widgets.add( parseIcon(element));
    }
  });
  return widgets;
}



Widget getChild(Map map, {MyCallback? myCallback}){
  Widget widget=Container();
  if(map['type']=='text'){
  // return TextBoxController(map: map);
    widget= TextBoxController(map: map);
  }
  else if(map['type']=='spacerController'){
  //  return TextFormFieldController(map: map);
    widget=  SpacerController(map: map,);
  }
  else if(map['type']=='textField'){
  //  return TextFormFieldController(map: map);
    widget=  TextFormFieldController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='sizedBox'){
    //return SizedBoxController(map: map);
    widget=  SizedBoxController(map: map);
  }
  else if(map['type']=='imageController'){
    //return ImageController(map: map);
    widget=  ImageController(map: map);
  }
  else if(map['type']=='svgController'){
   // return SvgController(map: map);
    widget=  SvgController(map: map);
  }
  else if(map['type']=='icon'){
   // return parseIcon(map);
    widget=  parseIcon(map);
  }
  else if(map['type']=='stackController'){
 //   return StackController(map: map,myCallback: myCallback!,);
    widget=  StackController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='positionController'){
   // return PositionController(map: map,myCallback: myCallback!,);
    widget=  PositionController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='alignController'){
 //   return AlignController(map: map,myCallback: myCallback!,);
    widget=  AlignController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='navIcon'){
    //return NavIcon(map: map, ontap: myCallback!,);
    widget=  NavIcon(map: map, ontap: myCallback!,);
  }
  else if(map['type']=='button'){
   // return ButtonController(map: map, ontap: myCallback!,);
    widget=  ButtonController(map: map, ontap: myCallback!,);
  }
  else if(map['type']=='columnController'){
   // return ColumnController(map: map,myCallback: myCallback!,);
    widget=  ColumnController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='rowController'){
   // return ColumnController(map: map,myCallback: myCallback!,);
    widget=  RowController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='pickerTemplate'){
   // return ColumnController(map: map,myCallback: myCallback!,);
    widget=  PickerTemplate(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='mapTemplate'){
   // return ColumnController(map: map,myCallback: myCallback!,);
    widget=  MapTemplate(map: map,myCallback: myCallback!,);
  }
  //return Container();
  return widget;

/*  else if(element['type']=='button'){
    widgets.add(Btn(map: map, ontap: myCallback,));
  }*/
}
