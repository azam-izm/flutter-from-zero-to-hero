/*
==========================
Multiple States in a Single StateNotifier (using Map)
==========================

What it does:
    - Manages two related pieces of state (slider value & switch value) 
      directly inside a StateNotifier without creating a separate state class.
    - Uses a Map<String, dynamic> to hold both states.

When to use:
    - When you want to keep multiple variables in one StateNotifier but 
      don’t want to create a separate data class.
    - Useful for quick prototypes or small apps.

How it works:
    - The StateNotifier holds a Map with two keys: "sliderValue" and "switchValue".
    - updateSlider() updates both slider and switch states when slider moves.
    - updateSwitch() updates both switch and slider states when switch toggles.
    - The provider exposes this Map to the widget tree.

Best Practices & Notes:
    1. Using a Map is flexible but less type-safe than a class. 
       (Mistyped keys or wrong types may cause runtime errors.)
    2. For larger apps, prefer using a proper state class (e.g. ToggleState).
    3. Works fine for small projects or learning purposes.
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier using a Map instead of a class
class ToggleNotifier extends StateNotifier<Map<String, dynamic>> {
  ToggleNotifier() : super({"sliderValue": 0.0, "switchValue": false});

  void updateSlider(double val) {
    state = {
      "sliderValue": val,
      "switchValue": val >= 1.0,
    };
  }

  void updateSwitch(bool val) {
    state = {
      "sliderValue": val ? 1.0 : 0.0,
      "switchValue": val,
    };
  }
}

// StateNotifierProvider exposing the Map state
final toggleProvider = StateNotifierProvider<ToggleNotifier, Map<String, dynamic>>((ref) =>ToggleNotifier());

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider - Switch - Value')),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(toggleProvider);
          final notifier = ref.read(toggleProvider.notifier);

          final sliderValue = state["sliderValue"] as double;
          final switchValue = state["switchValue"] as bool;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Slider(
                value: sliderValue,
                onChanged: notifier.updateSlider,
              ),
              Text(sliderValue.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,)),
              const SizedBox(height: 10),
              Switch(
                value: switchValue,
                onChanged: notifier.updateSwitch,
              ),
            ],
          );
        },
      ),
    );
  }
}
