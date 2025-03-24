import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
-------------------------------------------------------------
📌 Named Routes in GetX - Complete Guide 
-------------------------------------------------------------

🔹 What are Named Routes?
   - Named routes allow navigation using **predefined route names** instead of direct screen instances.
   - This helps in managing complex navigation flows and deep linking.

🔹 Why use Named Routes?
   ✅ **Improved Maintainability** - Easier to manage and update routes.
   ✅ **Deep Linking Support** - Enables direct navigation to specific screens via URLs.
   ✅ **Cleaner Code** - Avoids passing screen instances directly.

🔹 Key Methods:
   1️⃣ `Get.toNamed("/routeName", arguments: data)` - Navigate to a named route with data.
   2️⃣ `Get.offNamed("/routeName", arguments: data)` - Replace the current screen with a named route and pass data.
   3️⃣ `Get.offAllNamed("/routeName", arguments: data)` - Clear all previous screens and navigate with data.
   4️⃣ `Get.back(result: data)` - Go back to the previous screen and return data.

🔹 Data Passing & Receiving Hierarchy:
   - **FirstScreen → SecondScreen:** Passes data using `Get.toNamed('/second', arguments: data)`.
   - **SecondScreen → ThirdScreen:** Passes data using `Get.offNamed('/third', arguments: data)`.
   - **ThirdScreen → FirstScreen:** Passes data while clearing all screens using `Get.offAllNamed('/', arguments: data)`.
   - **SecondScreen → FirstScreen:** Returns data using `Get.back(result: data)`.
   - **Receiving Data:** Use `Get.arguments` to get data from the previous screen.
   - **Returning Data:** Use `Get.back(result: data)` to send data back to the previous screen.
   - **Can a screen both send and receive data?** Yes, a screen can receive data via `Get.arguments` and send data back using `Get.back(result: data)`.

🛠 Best Practices:
- Use named routes for **large applications** requiring deep linking.
- Define all routes centrally in `GetMaterialApp.routes` or `GetMaterialApp.onGenerateRoute`.
- Use `Get.arguments` to receive data between screens.

-------------------------------------------------------------
*/

// 📌 Entry Point - Main Function
void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const FirstScreen()),
      GetPage(name: '/second', page: () => const SecondScreen()),
      GetPage(name: '/third', page: () => const ThirdScreen()),
    ],
  ));
}

// 📌 First Screen - Home Screen with Navigation
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? receivedData = Get.arguments; // ✅ Capture data from ThirdScreen

    return Scaffold(
      appBar: AppBar(title: const Text("First Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (receivedData != null)
              Text("Received: $receivedData"), // ✅ Display received data
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var result = await Get.toNamed('/second', arguments: "Hello from FirstScreen");
                print("Returned Data: $result");
              },
              child: const Text("Go to Second Screen"),
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Second Screen - Demonstrating `Get.offNamed()` and Receiving Data
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? receivedData = Get.arguments; // ✅ Receive data

    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Received: $receivedData"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offNamed('/third', arguments: "Hello from SecondScreen"); // ✅ Pass data to next screen
              },
              child: const Text("Replace with Third Screen"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back(result: "Data from SecondScreen"); // ✅ Pass data back to previous screen
              },
              child: const Text("Go Back with Data"),
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Third Screen - Demonstrating `Get.offAllNamed()`
class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? receivedData = Get.arguments; // ✅ Receive data

    return Scaffold(
      appBar: AppBar(title: const Text("Third Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Received: $receivedData"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/', arguments: "Reset from ThirdScreen"); // ✅ Pass data while resetting
              },
              child: const Text("Go back to Home (Remove All)"),
            ),
          ],
        ),
      ),
    );
  }
}
