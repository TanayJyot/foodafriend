import 'package:buildspace_s5/deliverer/screens/order_tracking.dart';
import 'package:buildspace_s5/shared/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}


class FCM_Service {
  final _firebaseMessaging = FirebaseMessaging.instance;

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => const OrderTrackingPage(
            sourceLocation: sourceLocation, destination: destination)));
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(provisional: true);
    final fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fcmToken");
    initPushNotifications();
  }
}
