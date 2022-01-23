import 'package:nextstop_dynamic/widgets/customControllers/callBack/myCallback.dart';

import 'generalMethods.dart';

class General{

  void formSubmit(dynamic guid,List<dynamic> widgets,Map clickEvent,List queryString,{MyCallback? myCallback}){
    formSubmitMethod(guid, widgets,clickEvent,queryString,myCallback: myCallback);
  }


  void navigation(String page,int? typeOfNavigation){
    navigateTo(page,typeOfNavigation);
  }

  static String registrationPageIdentifier="REGI-STRA-TION-9876";
  static String homePageIdentifier="HOME-PAGE-3434-9898";
  static String profilePageIdentifier="PROF-ILE1-3434-6566";
  static String bookingPageIdentifier="BOOK-INGP-AGE1-7355";
  static String estimateBillPageIdentifier="ESTI-MATE-BILL-5698";
  static String scheduleRidePageIdentifier="SCHE-DULE-RIDE-5867";
}



String err001="Error 001";//INVALID JSON RESULT SET
String err002="No Page Found";