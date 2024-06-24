import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationProvider with ChangeNotifier {
  late FirebaseMessaging _messaging;
  String? _notificationTitle;
  String? _notificationBody;
  bool _initialized = false;

  NotificationProvider() {
    initialize();
  }

  String? get notificationTitle => _notificationTitle;
  String? get notificationBody => _notificationBody;

  Future<void> initialize() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    await requestNotificationPermissions();

    String? token = await _messaging.getToken();
    print("Firebase Messaging Token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        _notificationTitle = message.notification?.title;
        _notificationBody = message.notification?.body;
        notifyListeners();
      }
    });

    _initialized = true;
  }

  Future<void> requestNotificationPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      _notificationTitle = message.notification?.title;
      _notificationBody = message.notification?.body;
      notifyListeners();
    }
  }

  Future<void> sendNotification(String title, String body) async {
    if (!_initialized) {
      print('NotificationProvider not initialized yet');
      return;
    }

    String? token = await _messaging.getToken();
    // print(token);
    if (token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'https://helloworld-5kftm4coma-uc.a.run.app/sendNotification'), // Replace with your actual Cloud Function URL
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'body': body,
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print(
            'Failed to send notification. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
