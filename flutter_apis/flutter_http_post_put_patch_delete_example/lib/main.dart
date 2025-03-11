/*
 * 📌 Topic: Flutter HTTP Methods Example
 * --------------------------------------
 * This Flutter project demonstrates how to use different HTTP methods
 * (`POST`, `PUT`, `PATCH`, `DELETE`) using the `http` package.
 *
 * ✅ Features:
 * - User Registration (`POST`) → Sends email & password to an API.
 * - User Update (`PUT`) → Replaces the existing user details.
 * - User Partial Update (`PATCH`) → Modifies only a specific user field.
 * - User Deletion (`DELETE`) → Removes a user from the database.
 *
 * 🛠 Structure:
 * - `main.dart` → Entry point, initializes `HttpMethodsScreen`.
 * - `http_methods_service.dart` → Contains UI & API request logic.
 *
 * 📌 How It Works:
 * - The app provides input fields for email, password, and name.
 * - Users can perform API actions using buttons for each method.
 * - The app displays dynamic response messages for feedback.
 *
 */

import 'package:flutter/material.dart';
import 'http_methods_service.dart';

void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
/// Initializes the Flutter app with `HttpMethodsScreen` as the home page.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      home: HttpMethodsScreen(), // Loads the HTTP methods UI
    );
  }
}
