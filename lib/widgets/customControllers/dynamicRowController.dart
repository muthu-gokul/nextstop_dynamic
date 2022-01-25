import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../circle.dart';
import '../sizeLocal.dart';
import 'callBack/myCallback.dart';

class DynamicTextBox extends StatelessWidget implements MyCallback2{
  Map map;
  late Widget widget;
  List<dynamic> list=<dynamic>[].obs;
  DynamicTextBox({required this.map}){
    print(map['value']);
    List<dynamic> values=map['value'];
    print(values.length);
    if(values.isEmpty){
      list.add(map.containsKey('child')?getChild(map['child']):Container());
    }
    else{
      values.forEach((element) {
        /*print(map['child']['key']);
        print(element[map['child']['key']]);
        print(map);
        print(element);*/
        map['child']['value']=element[map['child']['propertyKey']];
        /*print(map['child']['value']);
        print(element[map['child']['key']]);*/
        list.add(map.containsKey('child')?getChild(map['child']):Container());
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    //return map.containsKey('child')?getChild(map['child']):Container();
    return Container(
      //height: 50,
        width: SizeConfig.screenWidth,
        // child:   map.containsKey('child')?getChild(map['child']):Container(),
        child: Obx(
              ()=> Column(
            children: [
              for(int i=0;i<list.length;i++)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    list[i],
                    Spacer(),
                    GestureDetector(
                        onTap: (){
                          list.add(map.containsKey('child')?getChild(map['child']):Container());
                        },
                        child: Circle(hei: 30, color: Colors.red,widget: Center(child: Icon(Icons.add,color: Colors.white,size: 18,),),)
                    ),
                    Spacer(),
                    i==0?Container():GestureDetector(
                        onTap: (){
                          list.removeAt(i);
                        },
                        child: Circle(hei: 30, color: Colors.orangeAccent,widget: Center(child: Icon(Icons.clear,size: 16,),),)
                    ),
                    Spacer(),
                  ],
                )

            ],
          ),
        )
    );
  }

  bool validate(){
    List<dynamic> fields=[];
    List<bool> validList=[];
    bool isValid=true;
    list.forEach((element) {
      if(element.map.containsKey('hasInput')){
        if(element.map['hasInput']){
          if(element.map['required']){
            isValid= element.validate();
            validList.add(isValid);
            fields.add({
              element.map["key"]:element.getValue()
            });
          }
          else{
            fields.add({
              element.map["key"]:element.getValue()
            });
          }
        }
      }
    });
    return !validList.any((element) => element==false);
  }

  getValue(){
    int i=0;
    List<dynamic> res=[];
    list.forEach((element) {
      res.add({i:element.getValue()});
      i++;
    });
    return res;
  }

  @override
  getType() {
    return map['type'];
  }
}