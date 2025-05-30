import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
* GetX Reactive State Management Masterclass
* 
* Core Concepts Covered:
* 1. Individual Rx Variables (.obs)
* 2. Custom Reactive Classes
* 3. Controller Lifecycle & Workers
* 4. Stream Integration
* 5. Multiple Reactive UI Patterns

Author: Muhammad Azam
*/

/* 1️⃣ INDIVIDUAL RX VARIABLES CONTROLLER */
class CounterController extends GetxController {
// RxInt count = RxInt(0); // Using `RxInt` to make the counter observable

/*
1️⃣ Individual Rx Variables Approach
* Basic reactive state using primitive types
* Best for simple, isolated state values
* Uses .obs and Obx widget
*/
  RxInt count = 0.obs;
  // The `.obs` method is used to turn any normal variable into a reactive variable (e.g., `RxInt`, `RxString`, `RxBool`, etc.).
  // These reactive variables need to be wrapped inside widgets like `Obx()` to automatically update the UI whenever the value changes.

  void increment() => count++; // Increases the count
  void decrement() => count--; // Decreases the count

  // Rx<int> count = Rx<int>(0);
  // void increment() => count.value++; // Access the value with `.value`
  // void decrement() => count.value--; // Access the value with `.value`'

  // Stream integration example
  final _streamController = Stream<int>.periodic(
    const Duration(seconds: 1),(x) => x,).asBroadcastStream();

  @override
  void onInit() {
    /* 🛠️ WORKER IMPLEMENTATIONS */
    // Ever - triggers on every change
    ever(count, (val) => print('🔔 Count changed to: $val'));

    // Debounce - triggers after 1 second inactivity
    debounce(count, (val) => print('⏳ Debounced value: $val'),
        time: const Duration(seconds: 1));

    // Interval - updates every 2 seconds during changes
    interval(count, (val) => print('⏱️ Interval update: $val'),
        time: const Duration(seconds: 2));

    // Once - triggers only on first change
    once(count, (val) {
      Get.snackbar(
        'First Change!',
        'Welcome to reactive counting!',
        backgroundColor: Colors.deepPurpleAccent, 
        colorText: Colors.white, 
        snackPosition: SnackPosition.BOTTOM, 
        duration: const Duration(seconds: 3), 
      );
    });

    super.onInit();
  }

  Stream<int> get counterStream => _streamController;
}

/* 2️⃣ CUSTOM REACTIVE CLASS */
class User extends GetxController {
  var name = 'Azam'.obs;
  var age = 27.obs;

  @override
  void onInit() {
    // Name change listener
    ever(name, (newName) => print('📛 Name updated to: $newName'));

    // Age milestone listener
    once(age, (_) {
      Get.defaultDialog(
        title: 'First Age Change!',
        titleStyle: const TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        content: const Text('Happy birthday journey begins! 🎉'),
        backgroundColor: Colors.deepPurpleAccent,
        barrierDismissible: false, // Prevents user from closing it immediately
      );

      // Auto-close the dialog after 3 seconds
      Future.delayed(const Duration(seconds: 3), () => Get.back());
    });

    super.onInit();
  }

  void birthday() {
    age.value++;
    name.value = 'Azam ${age.value}';

    // Special 30th birthday trigger
    if (age.value == 30) {
      once(age, (_) {
        Get.snackbar(
          'Milestone!',
          'Welcome to your 30s!',
          backgroundColor: Colors.deepPurpleAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP, 
          duration: const Duration(seconds: 3),
        );
      });
    }
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF110427),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  CounterScreen({super.key});

  final CounterController counter = Get.put(CounterController());
  final User user = Get.put(User());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 4, 
        centerTitle: true,
        title: Obx(() => Text(
              "Reactive Counter: ${counter.count}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22, 
                fontWeight: FontWeight.w600, 
              ),
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* 🎛️ REACTIVE UI DEMONSTRATIONS */

            // 1. Basic Obx usage
            Obx(() => Text(
                  "Obx Count: ${counter.count}",
                  style: const TextStyle(
                    color: Color(0xFFEBEAFF),
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                  ),
                )),

            const SizedBox(height: 10),

            // 2. Obx with value access
            Obx(() => Text(
                  "Obx with Value Access: ${counter.count.value}",
                  style: const TextStyle(
                    color: Color(0xFFEBEAFF),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                )),

            const SizedBox(height: 20),

            // 3. GetX widget with type specification
            GetX<CounterController>(
              builder: (controller) => Text(
                "GetX Widget: ${controller.count}",
                style: const TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 4. GetX widget with value access
            GetX<CounterController>(
              builder: (controller) => Text(
                "GetX with Value Access: ${controller.count}",
                style: const TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 5. Stream integration
            StreamBuilder<int>(
              stream: counter.counterStream,
              builder: (_, snap) => Text(
                "Stream Value: ${snap.data ?? 0}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 6. Custom reactive object
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User: ${user.name}",
                      style: const TextStyle(
                        color: Color(0xFFEBEAFF),
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Age: ${user.age}",
                      style: const TextStyle(
                        color: Color(0xFFEBEAFF),
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: counter.increment,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 12), // Consistent spacing
          FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: counter.decrement,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: user.birthday,
            child: const Icon(Icons.cake),
          ),
        ],
      ),
    );
  }
}

/*

* 📘 LECTURE KEY POINTS

* 1. Reactive Variable Types:
*    - .obs for primitives (int, String, bool)
*    - Rx<T> for custom types
*    - Obx/GetX for widget binding

* Workers in GetX:
*    - ever(): Runs every time the variable changes.
*    - debounce(): Waits for inactivity before executing (best for search fields).
*    - interval(): Runs at fixed intervals while value changes (throttling).
*    - once(): Runs only on the first value change.

* 3. Lifecycle Management:
*    - onInit(): Initialize workers/streams
*    - onClose(): Cleanup resources
*    - Automatic disposal with Get.put()

* 4. Stream Integration:
*    - Combine with Obx for automatic updates
*    - Use StreamBuilder for direct access
*    - Remember to cancel subscriptions

* 5. Best Practices:
*    - Keep controllers focused
*    - Use workers for side effects
*    - Prefer Obx for simple cases
*    - Combine reactive approaches strategically

*/

/*
=========================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

/// Controller using GetX
class CounterController extends GetxController {
  var count = 0.obs; // .obs makes it reactive

  void increment() => count++;
  void decrement() => count--;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Counter',
      debugShowCheckedModeBanner: false,
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterController controller = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(title: const Text('GetX Counter')),
      body: Center(
        child: Obx(() => Text(
              'Counter: ${controller.count}',
              style: const TextStyle(fontSize: 30),
            )),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: controller.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: controller.decrement,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
=========================================================
*/
