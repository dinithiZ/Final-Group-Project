import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Request notification permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        String? payload = notificationResponse.payload;
        if (payload != null) {
          _handleMessageClick(payload); // Define logic for clicking notifications
        }
      },
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      _onMessage(message);
      _storeNotificationInFirestore(message.notification); // Store notification in Firestore
    });

    // Handle background notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data != null) {
        _handleMessageClick(message.data['payload']);
      }
    });
  }

  static Future<void> _onMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'high_importance_channel', 'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformDetails,
        payload: message.data['payload'], // Attach payload for handling clicks
      );
    }
  }

  // Store notification data in Firestore
  static Future<void> _storeNotificationInFirestore(RemoteNotification? notification) async {
    if (notification != null) {
      CollectionReference notifications = FirebaseFirestore.instance.collection('notifications');

      await notifications.add({
        'title': notification.title,
        'body': notification.body,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((value) => print("Notification stored"))
        .catchError((error) => print("Failed to store notification: $error"));
    }
  }

  // Handle notification click
  static void _handleMessageClick(String? payload) {
    if (payload != null) {
      print("Notification clicked with payload: $payload");
    }
  }
}
