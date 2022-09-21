import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<dynamic> _messageStream =
      StreamController.broadcast();

  static Stream<dynamic> get messageStream => _messageStream.stream;

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    //print('_backgroundHandler: ${message.messageId}');

    

    _messageStream.add(message);
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    //print('_onMessageHandler: ${message.messageId}');
    _messageStream.add(message);
  }

  static Future<void> _onOpenMessageOpenApp(RemoteMessage message) async {
    //print('_onOpenMessageOpenApp: ${message.messageId}');
    _messageStream.add(message);
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await messaging.getToken();
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    
    print(token);

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageOpenApp);
    //onResume
  }

  static endStream() {
    _messageStream.close();
  }
}
