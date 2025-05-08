/*
============
Title:
Notification Redirect Demo

📋 Project Summary:
============
This Flutter app demonstrates full Firebase Cloud Messaging (FCM) integration with support for:
✅ Foreground notifications
✅ Background (app in memory) notifications
✅ Terminated (cold start) notifications
✅ Tapping notifications to navigate to specific screens

It uses:
- `firebase_messaging` for push notifications from Firebase.
- `flutter_local_notifications` for displaying notifications while app is in the foreground.
- `AndroidNotificationChannel` to create a proper notification channel for Android.
- iOS support is included (commented out) — ready to be used by uncommenting relevant lines.

You can send payloads from Firebase like:
{
  "notification": { "title": "View Details", "body": "Click to see more" },
  "data": { "route": "details" }
}

============
📚 Structure & Explanation by Part:
============
Section                          | Purpose
------------------------------- | ------------------------------------------------------------------
`main()` & `Firebase.initializeApp()` | Initializes Firebase before the app starts.
`_firebaseMessagingBackgroundHandler()` | Handles FCM messages when app is in background.
`flutterLocalNotificationsPlugin`      | Used to show local notifications (foreground).
`_channel`                      | Defines Android's high-importance notification channel.
`_requestPermission()`          | Asks notification permission (iOS & Android 13+).
`_initLocalNotifications()`     | Sets up `flutter_local_notifications` and channel.
`_setupNotificationListeners()` | Handles notification reception in foreground, background & terminated states.
`_showLocalNotification()`      | Shows a local notification using received FCM.
`_handleNotificationTap()`      | Navigates to correct screen based on FCM payload.
`HomePage`, `DetailsPage`       | UI screens - Home by default, Details on notification tap.

============
🗺️ Roadmap (What to Add Next):
============
Step     | Feature                      | Description
----     | ---------------------------  | --------------------------------------------------
✅      | Basic Notification Handling  | Foreground, Background, and Terminated supported
✅      | Notification Navigation      | Tap opens specific screen using "route" in payload
🟡      | iOS Support                  | Uncomment iOS setup & test on real device
🔜      | Custom Sound / Vibration     | Enhance notification UI/UX with custom assets
🔜      | Notification History         | Save and show past notifications locally
🔜      | Token Management             | Upload FCM token to backend for user targeting
🔜      | Grouped Notifications        | Group multiple messages under one summary

============
✅ iOS Support Checklist:
============
- Uncomment all iOS-related lines in your code (`DarwinInitializationSettings`, `DarwinNotificationDetails`, etc).
- Ensure iOS notification permissions are requested.
- Add these to `Info.plist` (iOS/Runner/Info.plist):

<key>FirebaseAppDelegateProxyEnabled</key>
<false/>
<key>UIBackgroundModes</key>
<array>
  <string>fetch</string>
  <string>remote-notification</string>
</array>
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>

- Test on physical device (iOS simulator does not support push notifications)
============
*/


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

// Local notification plugin instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Notification channel (Android)
const AndroidNotificationChannel _channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'Used for important notifications.',
  importance: Importance.max,
);

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _initLocalNotifications();
    _setupNotificationListeners();
  }

  // Ask for notification permission
  void _requestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  // Setup local notifications
  void _initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Uncomment for iOS
    // const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      // iOS: iosSettings,
    );

await flutterLocalNotificationsPlugin.initialize(
  settings,
  onDidReceiveNotificationResponse: (NotificationResponse response) {
    _handleNotificationTap(response.payload);
  },
);


    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  // Setup all notification listeners (foreground, background, terminated)
  void _setupNotificationListeners() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      _showLocalNotification(message);
    });

    // App opened from background via notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationTap(message.data['route']);
    });

    // App launched from terminated state via notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationTap(message.data['route']);
      }
    });
  }

  // Display local notification in foreground
  void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    final data = message.data;

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
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
        payload: data['route'], // Used to navigate on tap
      );
    }
  }

  // Navigate to specific page based on notification payload
  void _handleNotificationTap(String? route) {
    if (route == 'details') {
      _navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (_) => const DetailsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Redirect Demo',
      navigatorKey: _navigatorKey,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: const Center(child: Text('Waiting for notifications...')),
    );
  }
}

// Details Page (Target screen on notification tap)
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Page')),
      body: const Center(child: Text('You navigated here via notification!')),
    );
  }
}
