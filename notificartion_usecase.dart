import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageType}");
}

class NotificationHandler {
  static final NotificationHandler instance = NotificationHandler();
  NotificationHandler() {
    onRefreshToken();
  }
  Future<bool> requestPermisiion() async {
    FirebaseMessaging fcmNotification = FirebaseMessaging.instance;

    NotificationSettings settings = await fcmNotification.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      log(message.data.toString());
    }
  }

  onRefreshToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    log(name: 'fcmToken', token ?? '');
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      // send the new token
      log(name: 'fcmToken', fcmToken);
    }).onError((err) {});
  }

  foregroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
  }

// For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
// final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
// if (apnsToken != null) {
  // APNS token is available, make FCM plugin API requests...
// }
}


initNotifications() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDq2_deFDo0ahrgRF-CA2bQIPlo8vJN-9I',
          appId: '1:134470058592:android:c514cc5f2b56bfd984f905',
          messagingSenderId: '134470058592',
          projectId: '134470058592'));

  await NotificationHandler.instance.requestPermisiion();
  await NotificationHandler.instance.onRefreshToken();
  await NotificationHandler.instance.foregroundMessages();
}
