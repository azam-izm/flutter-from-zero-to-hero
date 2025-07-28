/*
---------------------------------------------
🚀 Flutter Local Storage - SharedPreferences
---------------------------------------------

📘 Purpose:
Demonstrate how to store a string value in SharedPreferences.
👉 After saving, value will not update instantly.
👉 It will only update when the app/screen is reloaded (e.g., via hot restart).

🧠 Use case: Verify that data is really saved in local storage.
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

/// Entry point widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const SharedPreferencesDemo(),
    );
  }
}

/// Main screen demonstrating SharedPreferences
class SharedPreferencesDemo extends StatefulWidget {
  const SharedPreferencesDemo({super.key});

  @override
  State<SharedPreferencesDemo> createState() => _SharedPreferencesDemoState();
}

class _SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  final TextEditingController _controller = TextEditingController();

  static const String KEYNAME = 'name'; // 🗝️ Key used to save/retrieve value
  String _storedValue = 'No data found';

  @override
  void initState() {
    super.initState();
    _loadStoredValue(); // 🔄 Load value on screen load
  }

  /// 📤 Save user input to SharedPreferences (no UI update here!)
  Future<void> _saveValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEYNAME, _controller.text.trim());

    /// 🔴 DON'T update _storedValue here — we only load on init
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Value saved. Please restart to see changes.')),
    );
  }

  /// 📥 Load stored value from SharedPreferences
  Future<void> _loadStoredValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = prefs.getString(KEYNAME) ?? 'No data found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SharedPreferences Example')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveValue,
              child: const Text('Save to SharedPreferences'),
            ),
            const SizedBox(height: 30),

            /// 📄 Display stored value
            Text('Stored Value:', style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              _storedValue,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
