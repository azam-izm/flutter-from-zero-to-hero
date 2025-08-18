/*
--------------------------------------------
       📌 Flutter Counter App Using Cubit
--------------------------------------------

🔹 Purpose:
   This Flutter app demonstrates how to manage state using *Cubit*, 
   a simpler and lighter version of BLoC. It shows a counter that can be:
   - Incremented (+1)
   - Decremented (-1)
   - Multiplied by 2
   - Divided by 2 (integer division)
   - Reset to 0

   Cubit is ideal for simple state management where you just need to emit 
   new states without defining separate events.

🔹 Key Concepts Covered:
   1️⃣ Cubit → Manages state and emits new values directly.
   2️⃣ BlocProvider → Provides the Cubit instance to the widget tree.
   3️⃣ BlocBuilder → Listens to the Cubit and rebuilds UI when the state changes.
   4️⃣ StatelessWidget → UI reacts to Cubit state changes.
   5️⃣ VoidCallback → Simplifies triggering Cubit methods from buttons.

--------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//--------------------------------------------
// Define Cubit
//--------------------------------------------

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0); // initial counter value

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void multiply() => emit(state * 2);
  void divide() => emit(state != 0 ? state ~/ 2 : 0);
  void reset() => emit(0);
}

//--------------------------------------------
// Entry Point
//--------------------------------------------

void main() {
  runApp(const MyApp());
}

// Wrap app with BlocProvider
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          primarySwatch: Colors.grey,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Counter Cubit App',
        home: const CounterScreen(),
      ),
    );
  }
}

//--------------------------------------------
// UI Screen
//--------------------------------------------

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Counter App Using Cubit',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // BlocBuilder listens to CounterCubit and rebuilds UI when state changes
            BlocBuilder<CounterCubit, int>(
              builder: (context, counter) {
                return Text(
                  'Counter: $counter',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _counterButton(context, '+', () => context.read<CounterCubit>().increment()),
                _counterButton(context, '-', () => context.read<CounterCubit>().decrement()),
                _counterButton(context, '÷2', () => context.read<CounterCubit>().divide()),
                _counterButton(context, '×2', () => context.read<CounterCubit>().multiply()),
                _counterButton(context, 'Reset', () => context.read<CounterCubit>().reset()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a styled button
  Widget _counterButton(BuildContext context, String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

/*
--------------------------------------------
📌 Dry Run (Execution Flow)
--------------------------------------------
1️⃣ CounterCubit → Initialized with state = 0.
2️⃣ BlocProvider → Makes CounterCubit accessible to the widget tree.
3️⃣ BlocBuilder → Listens to the Cubit state and rebuilds the Text widget.
4️⃣ Button Press → Calls Cubit method:
     - increment() → state + 1
     - decrement() → state - 1
     - multiply() → state * 2
     - divide() → state ~/ 2 (prevents division by 0)
     - reset() → state = 0
5️⃣ Cubit emits new state → BlocBuilder rebuilds UI automatically.

✅ Key Takeaways:
- Cubit is simpler than BLoC, no events needed.
- BlocProvider exposes the Cubit to the widget tree.
- BlocBuilder reacts to state changes efficiently.
- Perfect for small, self-contained state management.
--------------------------------------------
*/
