import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpMethodsScreen extends StatefulWidget {
  const HttpMethodsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HttpMethodsScreenState createState() => _HttpMethodsScreenState();
}

class _HttpMethodsScreenState extends State<HttpMethodsScreen> {
  final TextEditingController emailController =
      TextEditingController(text: "eve.holt@reqres.in");
  final TextEditingController passwordController =
      TextEditingController(text: "pistol");
  final TextEditingController nameController = TextEditingController();

  /// Displays a snackbar message
  void showMessage(String message, {Color color = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  /// Sends a POST request to register a user.
  Future<void> postRequest() async {
    try {
      final url = Uri.parse('https://reqres.in/api/register');
      final response = await http.post(
        url,
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        showMessage("✅ Registration Successful!", color: Colors.green);
      } else {
        showMessage("❌ Failed: ${response.body}", color: Colors.red);
      }
    } catch (e) {
      showMessage("❌ Error: $e", color: Colors.red);
    }
  }

  /// Sends a PUT request to update user details.
  Future<void> putRequest() async {
    if (nameController.text.trim().isEmpty) {
      showMessage("❌ Name cannot be empty!", color: Colors.red);
      return;
    }

    try {
      final url = Uri.parse('https://reqres.in/api/users/2');
      final response = await http.put(
        url,
        body: jsonEncode(
            {"name": nameController.text, "job": "Flutter Developer"}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        showMessage("✅ User Updated!", color: Colors.green);
      } else {
        showMessage("❌ Failed: ${response.body}", color: Colors.red);
      }
    } catch (e) {
      showMessage("❌ Error: $e", color: Colors.red);
    }
  }

  /// Sends a PATCH request to partially update user details.
  Future<void> patchRequest() async {
    if (nameController.text.trim().isEmpty) {
      showMessage("❌ Name cannot be empty!", color: Colors.red);
      return;
    }

    try {
      final url = Uri.parse('https://reqres.in/api/users/2');
      final response = await http.patch(
        url,
        body: jsonEncode({"name": nameController.text}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        showMessage("✅ User Partially Updated!", color: Colors.green);
      } else {
        showMessage("❌ Failed: ${response.body}", color: Colors.red);
      }
    } catch (e) {
      showMessage("❌ Error: $e", color: Colors.red);
    }
  }

  /// Sends a DELETE request to remove a user.
  Future<void> deleteRequest() async {
    try {
      final url = Uri.parse('https://reqres.in/api/users/2');
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        showMessage("✅ User Deleted Successfully!", color: Colors.green);
      } else {
        showMessage("❌ Failed: Something went wrong!", color: Colors.red);
      }
    } catch (e) {
      showMessage("❌ Error: $e", color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("HTTP Methods Example"),
          backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // ✅ Replaced Column with ListView to prevent overflow
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(labelText: "New Name (for PUT/PATCH)"),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                postRequest();
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "POST - Register",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                putRequest();
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "PUT - Update User",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                patchRequest();
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "PATCH - Partial Update",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                deleteRequest();
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "DELETE - Remove User",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
