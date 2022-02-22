import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:dynamicparsers/customControllers/callBack/myCallback.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
class PickerTemplate extends StatelessWidget implements MyCallback,MyCallback2{
  Map map;
  MyCallback myCallback;
  List widgets=[];
  PickerTemplate({required this.map,required this.myCallback})
  {
    if(map.containsKey('children')){
      map['children'].forEach((e){
        if(e['key']==3){
          e['child']['children'][2]['value']=time;
          e['child']['children'][1]['value']="${DateFormat("dd - MMM - yyyy").format(_selectedDate.value)} / ";
        }

      });
      widgets=getWidgets(map['children'], this);
    }
    log("picker $widgets $time");
  }


  TimeOfDay selectedTime = TimeOfDay.now();
  String time=formatDate(
      DateTime(2019, 08, 1, TimeOfDay.now().hour, TimeOfDay.now().minute),
      [hh, ':', nn, " ", am]).toString();

  var  _selectedDate = DateTime.now().obs;
  void _onSelectedDateChanged(DateTime newDate) {
      _selectedDate.value = newDate;
      widgets.forEach((element) {
        if(element.map['key']==3){
          element.widget.widgets[1].text.value= "${DateFormat("dd - MMM - yyyy").format(_selectedDate.value)} / ";
        }
      });
  }

  Color selectedDateStyleColor=Colors.white;
  Color selectedSingleDateDecorationColor=Colors.red;
  // Color selectedSingleDateDecorationColor=primaryColor;

  @override
  Widget build(BuildContext context) {
    dp.DatePickerRangeStyles styles = dp.DatePickerRangeStyles(
        selectedDateStyle: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: selectedDateStyleColor),
        selectedSingleDateDecoration: BoxDecoration(
            color: selectedSingleDateDecorationColor,
            shape: BoxShape.circle
        ),
        dayHeaderStyle: DayHeaderStyle(
            textStyle: TextStyle(
                color: Colors.grey,
                // color: primaryTextColor2,
                fontFamily: 'RM'
            )
        ),
       // dayHeaderTitleBuilder: _dayHeaderTitleBuilder
    );
    return Column(
      children: [
        Obx(
          ()=> Container(
            height: 250,
            child: dp.DayPicker.single(
              selectedDate: _selectedDate.value,
              onChanged: _onSelectedDateChanged,
              firstDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
              lastDate: DateTime(2100),
              datePickerStyles: styles,
              /*datePickerLayoutSettings: dp.DatePickerLayoutSettings(
                  maxDayPickerRowCount: 2,
                  showPrevMonthEnd: true,
                  showNextMonthStart: true
              ),*/

            ),
          ),
        ),
        SizedBox(height: 20,),
        for(int i=0;i<widgets.length;i++)
          widgets[i]
      ],
    );
  }
  _selectTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {

        selectedTime = timeOfDay;
        time = formatDate(
            DateTime(2019, 08, 1, timeOfDay.hour, timeOfDay.minute),
            [hh, ':', nn, " ", am]).toString();
        widgets.forEach((element) {
          if(element.map['key']==3){
            element.widget.widgets[2].text.value=time;
          }
        });

        log("selectedTime ${selectedTime} $s");

    }
  }
  @override
  void ontap(Map? clickEvent) {
    log("pickerclickEvent ");
    _selectTime();
  }

  @override
  void onTextChanged(String text,Map map) {
    // TODO: implement onTextChanged
  }

  @override
  void onMapLocationChanged(Map map) {
    // TODO: implement onMapLocationChanged
  }

  @override
  getCurrentPageWidgets() {
    // TODO: implement getCurrentPageWidgets
    throw UnimplementedError();
  }

  @override
  Color parseColor(String color) {
   return myCallback.parseColor(color);
  }

  @override
  getType() {
    return map['type'];
  }

  @override
  getValue() {
    // TODO: implement getValue
    throw UnimplementedError();
  }

  @override
  validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }
}
