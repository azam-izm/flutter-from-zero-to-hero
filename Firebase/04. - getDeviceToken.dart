import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures binding is initialized before calling Firebase methods

  
  await Firebase.initializeApp(                        // Initializes Firebase using the generated options
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Get Device Token',
      debugShowCheckedModeBanner: false,
      home: TokenPage(), 
    );
  }
}

// Main page for displaying token information
class TokenPage extends StatefulWidget {
  const TokenPage({super.key});

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  final FirebaseMessaging messaging = FirebaseMessaging.instance; // Firebase Messaging instance

  String? _deviceToken; // Stores current device token
  String? _refreshedToken; // Stores token when it's refreshed

  @override
  void initState() {
    super.initState();
    _getDeviceToken();       // Fetch the initial device token
    _monitorTokenRefresh();  // Listen for token refresh events
  }

  // Fetches the current device token
  Future<void> _getDeviceToken() async {
    final token = await messaging.getToken(); // Retrieves device token from FCM
    setState(() {
      _deviceToken = token; // Updates UI with token
    });
    print("Device Token: $_deviceToken");
  }

  // Listens for token refresh and updates UI when token changes
  void _monitorTokenRefresh() {
    messaging.onTokenRefresh.listen((newToken) {
      setState(() {
        _refreshedToken = newToken; // Updates UI with refreshed token
      });
      print("Token refreshed: $newToken"); // Optional: You can send newToken to your backend server here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FCM Token")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Current Token:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SelectableText(
              _deviceToken ?? "Fetching token...", 
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text("Refreshed Token:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SelectableText(
              _refreshedToken ?? "Waiting for refresh...",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
