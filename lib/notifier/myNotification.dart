import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message}");
}
class MyNotification{
  MyNotificationCallBack? myNotificationCallBack;
  late final FirebaseMessaging _messaging;

  void setMyCallBack(MyNotificationCallBack myNotificationCallBack){
    this.myNotificationCallBack=myNotificationCallBack;
  }


  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message title Open: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data['valueArray'].runtimeType} ${jsonDecode(message.data['valueArray'])}');
        myNotificationCallBack!.onNotificationReceived(jsonDecode(message.data['valueArray']));
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('onMessage Click OpenedApp title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
        myNotificationCallBack!.onNotificationReceived(jsonDecode(message.data['valueArray']));
      });

    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      myNotificationCallBack!.onNotificationReceived(jsonDecode(initialMessage.data['valueArray']));
    }
  }


}


class MyNotificationCallBack{
  void onNotificationReceived(List valueArray){}
}