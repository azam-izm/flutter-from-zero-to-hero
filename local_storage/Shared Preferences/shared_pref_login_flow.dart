/*
---------------------------------------------
🚀 Login Flow with SharedPreferences and Intro Screen in Flutter
---------------------------------------------
📘 Purpose:
To create a realistic app navigation flow using SharedPreferences 
that mimics the login/logout behavior of apps like Facebook or Twitter. 
It includes persistent login, intro screen on fresh launch, and proper 
routing between screens based on authentication state.
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Flow App',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

// 🟡 Splash/Intro Screen (Shown only for 3 seconds on app launch)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateBasedOnLoginStatus();
  }

  void navigateBasedOnLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isUserLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 3));

    if (isUserLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child:
              Text('🌟 Welcome to Our App!', style: TextStyle(fontSize: 24))),
    );
  }
}

// 🔵 Login Screen
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> login(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => login(context),
          child: const Text('Login → Go to Home'),
        ),
      ),
    );
  }
}

// 🟢 Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🏠 Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => logout(context),
          child: const Text('Logout → Go to Login'),
        ),
      ),
    );
  }
}
