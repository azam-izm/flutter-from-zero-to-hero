/*
==============
1) 
Go to android --> app --> src --> main --> AndroidManifest.xml

and replace these properties with these values

<meta-data
           android:name="com.google.firebase.messaging.default_notification_channel_id"
           android:value="high_importance_channel" />

2)
IMPORT THIS PACKAGE
flutter_local_notifications
==============
*/

/*
===============
Topic:
Firebase Push Notifications in Flutter: Foreground, Background & Terminated Handling (Android & iOS Ready)


📋 Project Summary:

This Flutter application demonstrates how to integrate Firebase Cloud Messaging (FCM)
to receive and display push notifications in all app states:

🔹 Foreground  
🔹 Background  
🔹 Terminated (Cold Start)

The app also sets up local notifications using `flutter_local_notifications`
to display messages when the app is active, and prepares iOS support (commented for now).


📚 Structure & Explanation by Part

| Section                          | Purpose                                                                 |
|----------------------------------|-------------------------------------------------------------------------|
| main() & Firebase.initializeApp()   | Initializes Firebase before running the app.                              |
| _firebaseMessagingBackgroundHandler | Handles background messages when the app is not in the foreground.        |
| FlutterLocalNotificationsPlugin     | Manages showing native notifications in-app using local notification API. |
| _channel                         | Defines the Android notification channel for high-importance notifications.  |
| _requestNotificationPermission() | Requests permission from the user to send notifications (mandatory for iOS and recommended for Android 13+). |
| _initializeLocalNotifications()  | Sets up the local notification system and Android notification channel. |
| _listenToForegroundMessages()    | Listens to real-time FCM messages when app is open and displays them.   |
| _handleTerminatedMessages()      | Checks if the app was launched by tapping a notification (terminated state). |


🗺️ Roadmap (What to Add Next):

| Step | Feature                      | Description                                                              |
|------|------------------------------|--------------------------------------------------------------------------|
| ✅   | Basic Notification Handling  | Foreground, Background, and Terminated messages supported                |
| 🟡   | iOS Support                  | Uncomment and test with real iOS device, add DarwinNotificationDetails   |
| 🔜   | Notification Navigation      | Add deep linking or screen navigation when tapping a notification        |
| 🔜   | Custom Data Payload Handling | Handle data messages (custom payloads without title/body)                |
| 🔜   | Notification History         | Store and display past notifications locally                             |
| 🔜   | Device Token Handling        | Display or upload FCM token for targeting specific devices               |


===============
*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

// Initialize the notification plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Define a notification channel for Android
const AndroidNotificationChannel _channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FCM Notification Demo',
      debugShowCheckedModeBanner: false,
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
    _initializeLocalNotifications();
    _listenToForegroundMessages();
    _handleTerminatedMessages(); // 🔹 Handle messages when app is terminated
  }

  // Ask user for notification permission
  void _requestNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  // Initialize flutter_local_notifications
  void _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Uncomment for iOS support
    // const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      // iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(settings);

    // Create Android notification channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  // Handle notifications when app is in foreground
  void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          0,
          notification.title ?? 'No Title',
          notification.body ?? 'No Body',
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              importance: Importance.max,
              priority: Priority.high,
            ),
            // iOS: DarwinNotificationDetails(), // Uncomment for iOS
          ),
        );
      }
    });
  }

  // Handle notifications when app is launched from terminated state
  void _handleTerminatedMessages() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null && initialMessage.notification != null) {
      final notification = initialMessage.notification!;
      flutterLocalNotificationsPlugin.show(
        0,
        notification.title ?? 'No Title',
        notification.body ?? 'No Body',
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.max,
            priority: Priority.high,
          ),
          // iOS: DarwinNotificationDetails(), // Uncomment for iOS
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Push Notifications')),
      body: const Center(
        child: Text(
          'Waiting for FCM message...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
