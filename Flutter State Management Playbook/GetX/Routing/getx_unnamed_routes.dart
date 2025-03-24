import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
-------------------------------------------------------------
📌 Unnamed Routes in GetX - Complete Guide (With Data Passing)
-------------------------------------------------------------

🔹 What are Unnamed Routes?
   - Unnamed routes (also called direct navigation) in GetX allow you to navigate between screens
     **without defining route names** in advance.

🔹 Why use Unnamed Routes?
   - More **flexibility** than named routes.
   - Avoids the need for a central route management file.
   - Useful for **dynamic routing** when routes depend on runtime data.

🔹 Key Methods:
   1⃣ `Get.to(() => Screen(), arguments: data)` - Navigate with data.
   2⃣ `Get.off(() => Screen(), arguments: data)` - Replace the current screen and pass data.
   3⃣ `Get.offAll(() => Screen(), arguments: data)` - Clear all previous screens and navigate with data.
   4⃣ `Get.back(result: data)` - Go back to the previous screen and return data.

🛠 Best Practices:
- Use unnamed routes for **simple navigation** (e.g., authentication flow).
- Use named routes when **scalability** and **deep linking** are needed.
- `Get.offAll()` is useful for logging out a user and clearing history.

-------------------------------------------------------------
*/

// 📌 Entry Point - Main Function
void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirstScreen(), 
  ));
}

// 📌 First Screen - Sending Data to Second Screen
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("First Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var result = await Get.to(
              () => const SecondScreen(),
              arguments: "Hello from FirstScreen", // ✅ Pass data
            );
            print("Returned Data: $result"); // ✅ Receive returned data
          },
          child: const Text("Go to Second Screen"),
        ),
      ),
    );
  }
}

// 📌 Second Screen - Receiving & Passing Data
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
                Get.off(
                  () => const ThirdScreen(),
                  arguments: "Hello from SecondScreen", // ✅ Pass data
                );
              },
              child: const Text("Replace with Third Screen"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back(result: "Data from SecondScreen"); // ✅ Return data
              },
              child: const Text("Go Back with Data"),
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Third Screen - Passing Data and Resetting Navigation Stack
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
                Get.offAll(
                  () => const FirstScreen(),
                  arguments: "Reset from ThirdScreen", // ✅ Pass data while resetting
                );
              },
              child: const Text("Go back to Home (Remove All)"),
            ),
          ],
        ),
      ),
    );
  }
}
