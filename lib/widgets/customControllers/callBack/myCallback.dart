import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nextstop_dynamic/widgets/customControllers/template/mapTemplate.dart';
import 'package:nextstop_dynamic/widgets/customControllers/template/pickerTemplate.dart';
import 'package:nextstop_dynamic/widgets/customControllers/utils.dart';


import '../../navIcon.dart';
import '../alignController.dart';
import '../buttonController.dart';
import '../columnController.dart';
import '../customScrollViewController.dart';
import '../dynamicRowController.dart';
import '../expandedController.dart';
import '../hiddenController.dart';
import '../imageController.dart';
import '../inputBoxController.dart';
import '../listviewBuilderController.dart';
import '../pageviewController.dart';
import '../positionController.dart';
import '../profiePicController.dart';
import '../registrationPageController.dart';
import '../rowController.dart';
import '../sizedBoxController.dart';
import '../spacerController.dart';
import '../stackController.dart';
import '../tabbarController.dart';
import '../templateController.dart';
import '../textController.dart';
import '../userRoleController.dart';
import '../visibilityController.dart';

abstract class MyCallback {
  void ontap(Map? clickEvent);
  void onTextChanged(String text, Map map,);
  void onMapLocationChanged(Map map);
  getCurrentPageWidgets();
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

abstract class TabPageViewCallback{
  onChanged(int index);
  changeControllerIndex(int index);
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
    else if(element['type']=='mapTemplateParent'){
      widgets.add(MapTemplateParent(element['templateName'],element,myCallback,));
    }
    else if(element['type']=='expandedController'){
      widgets.add(ExpandedController(map: element, ontap: myCallback,));
    }
    else if(element['type']=='listViewBuilderController'){
      widgets.add(ListViewBuilderController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='customScrollViewController'){
      widgets.add(CustomScrollViewController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='visibilityController'){
      widgets.add(VisibilityController(map: element, ontap: myCallback,));
    }
    else if(element['type']=='tabbarController'){
      widgets.add(TabbarController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='pageViewController'){
      widgets.add(PageViewController(map: element, myCallback: myCallback,));
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
    widget= TextBoxController(map: map);
  }
  else if(map['type']=='spacerController'){
    widget=  SpacerController(map: map,);
  }
  else if(map['type']=='textField'){
    widget=  TextFormFieldController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='hiddenController'){
      widget=HiddenController(map: map);
    }
  else if(map['type']=='sizedBox'){
    widget=  SizedBoxController(map: map);
  }
  else if(map['type']=='imageController'){
    widget=  ImageController(map: map);
  }
  else if(map['type']=='svgController'){
    widget=  SvgController(map: map);
  }
  else if(map['type']=='icon'){
    widget=  parseIcon(map);
  }
  else if(map['type']=='stackController'){
    widget=  StackController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='positionController'){
    widget=  PositionController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='alignController'){
    widget=  AlignController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='navIcon'){
    widget=  NavIcon(map: map, ontap: myCallback!,);
  }
  else if(map['type']=='button'){
    widget=  ButtonController(map: map, ontap: myCallback!,);
  }
  else if(map['type']=='columnController'){
    widget=  ColumnController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='rowController'){
    widget=  RowController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='pickerTemplate'){
    widget=  PickerTemplate(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='mapTemplateParent'){
    widget=  MapTemplateParent(map['templateName'],map,myCallback!,);
  }

  else if(map['type']=='expandedController'){
    widget=  ExpandedController(map: map, ontap: myCallback!,);
  }
  else if(map['type']=='listViewBuilderController'){
    widget=  ListViewBuilderController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='customScrollViewController'){
    widget=  CustomScrollViewController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='visibilityController'){
    widget=  VisibilityController(map: map, ontap: myCallback!,);
  }
  else if(map['type']=='userRoleController'){
    widget=  UserRoleController(map: map, ontap: myCallback!,);
  }
  else if(map['type']=='tabbarController'){
    widget=  TabbarController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='pageViewController'){
    widget=  PageViewController(map: map, myCallback: myCallback!,);
  }
  return widget;

}
