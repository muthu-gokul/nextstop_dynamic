import 'package:flutter/material.dart';

import 'callBack/myCallback.dart';

import '../widgets/sizeLocal.dart';


abstract class RegistrationTemplate {
  factory RegistrationTemplate(String templateName){
    if(templateName=='registrationTemplate1'){
      return RegistrationTemplate1();
    }
    else{
      return RegistrationTemplate2();
    }
  }
  getWidget(Map data,MyCallback myCallback);
}


class RegistrationTemplate1  implements RegistrationTemplate{
  @override
  getWidget(Map data,MyCallback myCallback) {

    Map s={
      "margin": "10,0,10,10",
      "borderRadius": "5,5,5,5",
      "borderColor": "D2D2D2",
      "focusedBorderColor": "929BC4",
      "disabledBorderColor": "FFF44336",
      "color": "FFffffff",
      "disableColor": "FFF5EFEE",
      "hintTextStyle": {
        "color": "B6B6B6",
        "fontSize": 15.0,
        "fontFamily":"RR"
      },
      "errorTextStyle": {
        "color": "#F44336",
        "fontSize": 14.0,
        "fontWeight": "normal"
      },
      "textStyle": {
        "color": "7F7F7F",
        "fontSize": 15.0,
        "fontFamily":"RR"
      }
    };

    List<dynamic> widgets=[];
    List<dynamic> sortList=[];
    sortList=data['children'];
    sortList.sort((a,b)=>int.parse(a['orderBy'].toString()).compareTo(int.parse(b['orderBy'].toString())));
    if(data['isInvokeSubTemplate']){
      sortList.forEach((ele){
        if(ele.containsKey('isInvokeSubTemplate')){
          if(ele['isInvokeSubTemplate']){
            if(ele['type']=='textField'){
              s.forEach((key, value) {
                ele[key]=value;
              });
            }
            else if(ele['type']=='dynamicTextBox'){
              s.forEach((key, value) {
                ele['child'][key]=value;
              });
            }
          }
        }
        else{
          if(ele['type']=='textField'){
            s.forEach((key, value) {
              ele[key]=value;
            });
          }
          else if(ele['type']=='dynamicTextBox'){
            s.forEach((key, value) {
              ele['child'][key]=value;
            });
          }
        }
      });
    }

    widgets=getWidgets(data['children'], myCallback);

    return Container(
      alignment: Alignment.center,
      height: SizeConfig.screenHeight!-SizeConfig.topPad!,
      width: SizeConfig.screenWidth,
      child: NestedScrollView(
          floatHeaderSlivers: false,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                // title: const Text(''),
                floating: false,
                pinned: true,
                expandedHeight: 200.0,
                forceElevated: innerBoxIsScrolled,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image:AssetImage(data['appBarImage']),  fit: BoxFit.cover, )
                  ),
                ),
                backgroundColor: Colors.transparent,
                title: Transform(
                  transform: Matrix4.skewX(2.8),
                  origin:Offset(0,-50),
                  child: Container(
                      width: 250,
                      padding: EdgeInsets.only(left: 0.0,right: 15.0,top: 15.0,bottom: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65)
                      ),
                      child: Center(
                          child: Text(
                              data['title']
                          )
                      )
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              for(int i=0;i<widgets.length;i++)
                widgets[i],
             // CompanySettingsTextField(hintText: "Enter Name", ),
             /* Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      margin: EdgeInsets.only(top: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          border: Border.all(color: Colors.cyanAccent,width: 3),
                          //  color: AppTheme.yellowColor,
                          boxShadow: []
                      ),
                      child:SvgPicture.asset("assets/designation/security.svg"),
                    ),
                    Positioned(
                        bottom: 0,
                        right:0,
                        child: Container(
                            height: 35,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[700]
                            ),
                            child: Icon(Icons.camera_alt_outlined,color: Colors.white,size: 20,)
                        )
                    )
                  ],
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(height: 15,),
              CompanySettingsTextField(hintText: "Enter Name", ),
              SizedBox(height: 15,),
              CompanySettingsTextField(hintText: "Enter 4 digit PIN", ),
              SizedBox(height: 15,),
              CompanySettingsTextField(hintText: "Confirm 4 digit PIN",),
              SizedBox(height: 15,),
              CompanySettingsTextField(hintText: "Contact number",),
              SizedBox(height: 15,),
              CompanySettingsTextField(hintText: "Address",),
              SizedBox(height: 15,),
              CompanySettingsTextField(hintText: "Aadhar number",),
              SizedBox(height: 15,),
              CompanySettingsTextField(hintText: "Security agency",),
              SizedBox(height: 15,),
              CompanySettingsTextField(hintText: "Gate No",),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){


                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: [
                    //   BoxShadow(color: Colors.green, spreadRadius: 3),
                    // ],
                    color: Color(0xff371176),
                  ),
                  child:Center(child: Text('Done',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xffffffff),fontFamily:'RR'), )) ,
                ),
              ),
              SizedBox(height: 25,),*/
            ],
          )
      ),
    );
  }
}


class RegistrationTemplate2 implements RegistrationTemplate {
  @override
  getWidget(Map data,MyCallback myCallback) {
    return Row(
      children: const [
        Text("Title: "),
        Spacer(),
        Text("Value"),
      ],
    );
  }
}

