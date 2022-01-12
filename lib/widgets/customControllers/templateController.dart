import 'package:flutter/material.dart';

abstract class TemplateMaster {
  factory TemplateMaster(String templateName){
    if(templateName=='template1'){
      return Template1();
    }
    else{
      return Template2();
    }
  }
  getWidget();
}


class Template1  implements TemplateMaster{
  @override
  getWidget() {
    return Row(
      children: const [
        Text("Title: "),
        Text("Value"),
      ],
    );
  }
}


class Template2 implements TemplateMaster {
  @override
  getWidget() {
    return Row(
      children: const [
        Text("Title: "),
        Spacer(),
        Text("Value"),
      ],
    );
  }
}

