

import 'package:flutter/material.dart';

import 'searchDropdown/dropdown_search.dart';
import 'sizeLocal.dart';


class SearchPopUp extends StatefulWidget {
//  VoidCallback ontap;
  VoidCallback scrollTap;
  double width;
  String selectedValue;
  List<dynamic> data;
  Function(int) onitemTap;
  bool isToJson;
  String propertyName;
  String hinttext;

  bool isEnable;
  SearchPopUp({required this.width,required this.selectedValue,
    required this.data,required this.onitemTap,required this.isToJson,this.propertyName="",required this.hinttext,
    this.isEnable=true,required this.scrollTap});

  @override
  State<SearchPopUp> createState() => _SearchPopUpState();
}

class _SearchPopUpState extends State<SearchPopUp> {
  double textFormWidth=SizeConfig.screenWidth!-20;
  Color addNewTextFieldBorder=Colors.red;
  FocusNode f4 = FocusNode();
  // List<dynamic> filterData=[];
  final ValueNotifier<List<dynamic>> tasksNotifier = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    //  final node=FocusScope.of(context);
    return Container(
      width: textFormWidth,
      child: DropdownSearch<String>(
        // validator: (v) => v == null ? "required field" : null,
        //  dialogMaxWidth: 200,

        dropdownSearchDecoration: InputDecoration(
          hintText: widget.hinttext,
          //   labelText: "Menu mode *",
          contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          border: OutlineInputBorder(),
        ),
        popupShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        mode: Mode.MENU,
        showSelectedItems: false,
        popupElevation: 2,
        //items: widget.data,
        showClearButton: false,
        showSearchBox: false,
        // dropDownButton: Icon(Icons.eleven_mp),
        searchDelay: Duration(milliseconds: 0),
        ontap: (){
          widget.scrollTap();
          tasksNotifier.value=widget.data;
          // setState(() {
          //   filterData=widget.data;
          // });
        },
        selectWidget: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
          height: 50,
          width: textFormWidth,
          // margin: paddTextFieldHeader,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            //border: Border.all(color: widget.isEnable?addNewTextFieldBorder:Color(0xffC5C5C5),),
            border: Border.all(color:addNewTextFieldBorder),
            // color: widget.isEnable?Colors.white:disableColor,
            color: Colors.white,
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Text(widget.selectedValue.isEmpty?widget.hinttext:widget.selectedValue,
                style: TextStyle(color: Color(0xFF2E2E2E),fontSize: 16,fontFamily: widget.selectedValue.isEmpty?'RL':'RR'),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down,size: 30,color: Colors.blue,),
              SizedBox(width: 15,)
            ],
          ),
        ),
        dialogWidget: Container(
          height:  (widget.data.length*50.0),
          width: textFormWidth,
          margin: const EdgeInsets.only(top: 0,left: 0),
          padding: const EdgeInsets.only(top: 0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(0,0)
                )
              ]
          ),
          constraints: BoxConstraints(
              maxHeight: 300
          ),
            child: ValueListenableBuilder<List<dynamic>>(
              valueListenable: tasksNotifier,
              builder: (_,t,c){
                return ListView.builder(
                  itemCount: t.length,
                  itemBuilder: (ctx,index){
                    return   InkWell(
                      onTap:(){

                        Navigator.pop(ctx);
                        widget.onitemTap(index);
                      },
                      child: Container(
                        height: 50,
                        width:textFormWidth,
                        padding: EdgeInsets.only(left: 20,),
                        //  margin: EdgeInsets.only(bottom: 3),
                        alignment: Alignment.centerLeft,
                        // color:selectedValue==data![index]?AppTheme.red: Color(0xFFf6f6f6),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child:  Text(widget.isToJson?"${t[index].get(widget.propertyName)}":"${t[index]}",
                          style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Colors.grey
                            // color:selectedValue==data![index]?Colors.white: Color(0xFF555555),letterSpacing: 0.1
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )
         /* child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             *//* Container(
                height: 50,
                width: widget.width,
                margin: EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                child: TextFormField(
                 // style: textFormTs1,
                  focusNode: f4,
                  decoration: InputDecoration(
                      hintText: "Search",
                    //  hintStyle: textFormHintTs1,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15)
                  ),
                  onEditingComplete: (){
                    f4.unfocus();
                  },
                  onChanged: (v){
                    tasksNotifier.value=widget.data.where((element) => element.toString().toLowerCase().contains(v.toLowerCase())).toList();
                  },
                ),
              ),*//*
              Flexible(
                  child: ValueListenableBuilder<List<dynamic>>(
                    valueListenable: tasksNotifier,
                    builder: (_,t,c){
                      return ListView.builder(
                        itemCount: t.length,
                        itemBuilder: (ctx,index){
                          return   InkWell(
                            onTap:(){

                              Navigator.pop(ctx);
                              widget.onitemTap(index);
                            },
                            child: Container(
                              height: 50,
                              width:textFormWidth,
                              padding: EdgeInsets.only(left: 20,),
                              //  margin: EdgeInsets.only(bottom: 3),
                              alignment: Alignment.centerLeft,
                              // color:selectedValue==data![index]?AppTheme.red: Color(0xFFf6f6f6),
                              decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(8),
                                color: Colors.red,
                              ),
                              child:  Text(widget.isToJson?"${t[index].get(widget.propertyName)}":"${t[index]}",
                                style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Colors.grey
                                  // color:selectedValue==data![index]?Colors.white: Color(0xFF555555),letterSpacing: 0.1
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
              ),
            ],
          ),*/
        ),
        onChanged: (s){},
        /// popupItemDisabled: (String? s) => s?.startsWith('I') ?? false,
        clearButtonSplashRadius: 20,
        selectedItem:widget.selectedValue,
        onBeforeChange: (a, b) {
          return Future.value(true);
        },
      ),
    );
  }
}
