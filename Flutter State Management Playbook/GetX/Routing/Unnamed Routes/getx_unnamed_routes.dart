import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
-------------------------------------------------------------
📌 Unnamed Routes in GetX - Complete Guide 
-------------------------------------------------------------

🔹 What are Unnamed Routes?
   - Unnamed routes (also called direct navigation) in GetX allow you to navigate between screens
     **without defining route names** in advance.

🔹 Why use Unnamed Routes?
   - More **flexibility** than named routes.
   - Avoids the need for a central route management file.
   - Useful for **dynamic routing** when routes depend on runtime data.

🔹 Key Methods:
   1️⃣ `Get.to(Screen())` - Push a new screen (like `Navigator.push`).
   2️⃣ `Get.off(Screen())` - Replace the current screen (like `Navigator.pushReplacement`).
   3️⃣ `Get.offAll(Screen())` - Remove all previous screens (like `Navigator.pushAndRemoveUntil`).
   4️⃣ `Get.back()` - Pop the current screen (like `Navigator.pop`).

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
    home: FirstScreen(), // No need to define named routes!
  ));
}

// 📌 First Screen - First Screen in Navigation
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("First Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(const SecondScreen()); // ✅ Navigate without a route name
          },
          child: const Text("Go to Second Screen"),
        ),
      ),
    );
  }
}

// 📌 Second Screen - Demonstrating `Get.off()`
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.off(const ThirdScreen());
                /*
                ✅ `Get.off(ThirdScreen())`
                   - This replaces `SecondScreen` with `ThirdScreen`.
                   - The user **cannot navigate back** to `SecondScreen`.
                   - Use this when the previous screen is **no longer needed**.
                */
              },
              child: const Text("Replace with Third Screen"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back(); // ✅ Pop the screen (go back)
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Third Screen - Demonstrating `Get.offAll()`
class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Third Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.offAll(const FirstScreen());
            /*
            ✅ `Get.offAll(FirstScreen())`
               - Removes **ALL** previous screens from the stack.
               - The user **cannot go back** to `SecondScreen` or `ThirdScreen`.
               - Use this for logout flows or resetting navigation history.
            */
          },
          child: const Text("Go back to Home (Remove All)"),
        ),
      ),
    );
  }
}
