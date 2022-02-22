import 'package:flutter/material.dart';
import 'callBack/general.dart';
import 'callBack/myCallback.dart';
import 'utils.dart';

class GridViewBuilderController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  GridViewBuilderController({required this.map,required this.myCallback})
  {
    updateValues(map['value']);
  }

  updateValues(List values){
    values.forEach((element) {
      widgets.add(map.containsKey('childd')?getChild(map['childd'],myCallback: myCallback):Container());
      element.forEach((k, v) {
        func1ByKey(widgets[widgets.length-1], {"key":"$k"}, (wid){
          updateByWidgetType(wid.getType(),widget: wid,clickEvent: {"key":"$k","value":v});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: map.containsKey("maxCrossAxisExtent")?map['maxCrossAxisExtent']:200,
            childAspectRatio:map.containsKey('childAspectRatio')? map['childAspectRatio']:1.5,
            crossAxisSpacing:map.containsKey("crossAxisSpacing")?map['crossAxisSpacing']: 20,
            mainAxisSpacing: map.containsKey("mainAxisSpacing")?map['mainAxisSpacing']:20
        ),
        itemCount: widgets.length,
        itemBuilder: (BuildContext ctx, index) {
          return widgets[index];
        }
    );
  }

  @override
  getType() {
    return map['type'];
  }

  @override
  getValue() {
  }

  @override
  validate() {

  }




}