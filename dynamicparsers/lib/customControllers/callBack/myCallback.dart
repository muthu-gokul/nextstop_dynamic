import 'dart:convert';

import 'package:dynamicparsers/customControllers/template/mapTemplate.dart';
import 'package:dynamicparsers/customControllers/template/pickerTemplate.dart';
import 'package:dynamicparsers/widgets/navIcon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



import '../alignController.dart';
import '../arcContainer.dart';
import '../autosizeText.dart';
import '../buttonController.dart';
import '../checkBox.dart';
import '../circleController.dart';
import '../columnController.dart';
import '../customPopUp.dart';
import '../customScrollViewController.dart';
import '../dynamicRowController.dart';
import '../expandedController.dart';
import '../expansionTileController.dart';
import '../flexibleController.dart';
import '../gridviewBuilderController.dart';
import '../hiddenController.dart';
import '../imageController.dart';
import '../inputBoxController.dart';
import '../listviewBuilderController.dart';
import '../opacityController.dart';
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
import '../utils.dart';
import '../visibilityController.dart';

 abstract class MyCallback {
  ontap(Map? clickEvent);
  void onTextChanged(String text, Map map,){}
  void onMapLocationChanged(Map map){}
  getCurrentPageWidgets(){}
  Color parseColor(String color);
  reloadPage(){}
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
  parsed.forEach((ele) {
    // print(element);
    var element=jsonDecode(jsonEncode(ele));
    if(element['type']=='text'){
      widgets.add(TextBoxController(map: element,myCallback: myCallback,));
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
      widgets.add(ProfilePicController(map: element,myCallback: myCallback,));
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
    else if(element['type']=='customCheckBox'){
      widgets.add(CustomCheckBox(map: element,myCallback: myCallback,));
    }
    else if(element['type']=='arcContainer'){
      widgets.add(ArcContainer(map: element, ontap: myCallback,));
    }
    else if(element['type']=='autoSizeText'){
      widgets.add(AutoSizeTextController(map: element,myCallback: myCallback,));
    }
    else if(element['type']=='icon'){
      widgets.add( parseIcon(element,myCallback));
    }
    else if(element['type']=='tabbarController'){
      widgets.add(TabbarController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='pageViewController'){
      widgets.add(PageViewController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='gridViewBuilderController'){
      widgets.add(GridViewBuilderController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='flexibleController'){
      widgets.add(FlexibleController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='circleController'){
      widgets.add(CircleController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='opacityController'){
      widgets.add(OpacityController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='customPopup'){
      widgets.add(CustomPopup(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='sliverListController'){
      widgets.add(SliverListController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='expansionTileController'){
      widgets.add(ExpansionTileController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='sliverFillRemainingController'){
      widgets.add(SliverFillRemainingController(map: element, myCallback: myCallback,));
    }
    else if(element['type']=='sliverAppBarController'){
      widgets.add(SliverAppBarController(map: element, myCallback: myCallback,));
    }
  });
  return widgets;
}

Widget getChild(Map mapp, {MyCallback? myCallback}){
  Widget widget=Container();
  Map map=jsonDecode(jsonEncode(mapp));
  if(map['type']=='text'){
    widget= TextBoxController(map: map,myCallback: myCallback!,);
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
    widget=  parseIcon(map,myCallback!);
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
  else if(map['type']=='arcContainer'){
    widget=  ArcContainer(map: map, ontap: myCallback!,);
  }
  else if(map['type']=='customCheckBox'){
    widget=  CustomCheckBox(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='autoSizeText'){
    widget=  AutoSizeTextController(map: map,myCallback: myCallback!,);
  }
  else if(map['type']=='tabbarController'){
    widget=  TabbarController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='pageViewController'){
    widget=  PageViewController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='gridViewBuilderController'){
    widget=  GridViewBuilderController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='flexibleController'){
    widget=  FlexibleController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='circleController'){
    widget=  CircleController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='opacityController'){
    widget=  OpacityController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='customPopup'){
    widget=  CustomPopup(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='sliverListController'){
    widget=  SliverListController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='expansionTileController'){
    widget=  ExpansionTileController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='sliverFillRemainingController'){
    widget=  SliverFillRemainingController(map: map, myCallback: myCallback!,);
  }
  else if(map['type']=='sliverAppBarController'){
    widget=  SliverAppBarController(map: map, myCallback: myCallback!,);
  }
  return widget;

}
