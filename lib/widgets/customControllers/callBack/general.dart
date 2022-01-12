import 'generalMethods.dart';

class General{

  void formSubmit(dynamic guid,List<dynamic> widgets,Map clickEvent){
    formSubmitMethod(guid, widgets,clickEvent);
  }


  void navigation(String page,int? typeOfNavigation){
    navigateTo(page,typeOfNavigation);
  }

  static String registrationPageIdentifier="REGI-STRA-TION-9876";
}



String err001="Error 001";//INVALID JSON RESULT SET
String err002="No Page Found";