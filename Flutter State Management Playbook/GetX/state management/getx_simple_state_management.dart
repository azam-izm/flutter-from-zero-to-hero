import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
 Introduction to GetX Simple State Management:

 GetX is a lightweight and powerful state management solution for Flutter. 
 It provides multiple ways to manage the state of an application, and in this example, 
 we will be using the **simple state management** approach using `GetBuilder`.
 Simple state management in GetX allows you to easily update and refresh the UI when 
 a change occurs in the state by manually triggering a UI rebuild with the `update()` method.

 In this demo, we have a simple counter app where the state (the counter value) is managed
 using the `CounterController` class. The `GetBuilder` widget listens to the controller
 and triggers UI updates when `update()` is called.
 */

void main() {
  runApp(const MyApp());
}

/*
MyApp is the root widget of our application.

In this widget, we initialize the GetMaterialApp, which provides the core 
functionality of GetX, such as navigation, state management, and more.
*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,  // Disables the debug banner
      home: CounterScreen(),  // CounterScreen will be the starting screen of the app
    );
  }
}

 // CounterController manages the state for the counter value.
 // This is where we define our logic for incrementing and decrementing the counter.
class CounterController extends GetxController {
  
  int count = 0; // The counter state variable

  // Method to increment the counter
  // This method increases the value of the counter by 1 and triggers a UI update.
  void increment() {
    count++;  // Increase the counter
    update();  // Trigger a rebuild of the widgets wrapped in GetBuilder
  }

  // Method to decrement the counter
  // This method decreases the value of the counter by 1 and triggers a UI update.
  void decrement() {
    count--;  // Decrease the counter
    update();  // Trigger a rebuild of the widgets wrapped in GetBuilder
  }
}

// CounterScreen is the widget where we display the counter value and the floating action buttons.
class CounterScreen extends StatelessWidget {
  CounterScreen({super.key});

  // Register the CounterController using Get.put().
  // Get.put() makes the controller available throughout the widget tree.
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter App - GetBuilder")),
      body: Center(
        // GetBuilder listens to changes in the CounterController and rebuilds only the widget wrapped inside it 
        // when `update()` is called.
        child: GetBuilder<CounterController>(
          builder: (controller) => Text(
            "Count: ${controller.count}",  // Display the current count
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Floating action button to increment the counter
          FloatingActionButton(
            onPressed: counterController.increment,
            child: const Icon(Icons.add),  // Icon for the increment button
          ),
          const SizedBox(height: 10),
          // Floating action button to decrement the counter
          FloatingActionButton(
            onPressed: counterController.decrement,
            child: const Icon(Icons.remove),  // Icon for the decrement button
          ),
        ],
      ),
    );
  }
}

/*
Explanation of Key Components:

1. **GetBuilder**: A widget that listens to changes in a specific controller
   and rebuilds itself when `update()` is called inside that controller.
   In this case, it listens to `CounterController` and rebuilds the `Text` widget
   displaying the counter value when `update()` is called.

2. **CounterController**: The controller managing the state (counter value).
   The `increment()` and `decrement()` methods change the state and trigger UI updates
   using the `update()` method.

3. **Get.put()**: Used to register the controller with GetX and make it accessible
   to the entire widget tree. In this case, the `CounterController` is made available
   to the `CounterScreen`.

4. **FloatingActionButton**: These buttons are used to increase or decrease the count,
   calling the `increment()` and `decrement()` methods on the `CounterController`.
*/