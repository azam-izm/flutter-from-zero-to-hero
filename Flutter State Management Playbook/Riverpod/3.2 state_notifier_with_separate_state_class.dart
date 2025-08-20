/*
==========================
Multiple States in a Single StateNotifier (using a State Class)
==========================

What it does:
    - Manages two related pieces of state (slider value & switch value) 
      inside a StateNotifier, using a dedicated state class (ToggleState).
    - Keeps business logic (updates) separate from the UI.

When to use:
    - When you have multiple related variables and want type-safety.
    - Recommended for production apps where maintainability and readability matter.
    - Useful when you want to scale the state logic beyond just a few variables.

How it works:
    - ToggleState is a simple immutable data class that holds sliderValue & switchValue.
    - ToggleNotifier extends StateNotifier<ToggleState> and exposes methods:
        * updateSlider() → updates slider and auto-adjusts switch.
        * updateSwitch() → updates switch and auto-adjusts slider.
    - StateNotifierProvider exposes the current ToggleState to the widget tree.
    - UI only calls notifier methods (no logic inside widgets).

Best Practices & Notes:
    1. This is the **recommended way** in Riverpod for managing multiple variables.
    2. Clear separation of data (ToggleState), logic (ToggleNotifier), and UI.
    3. Safer and easier to extend compared to using a Map instead of ToggleState class.
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Immutable state class
class ToggleState {
  final double sliderValue;
  final bool switchValue;

  const ToggleState({this.sliderValue = 0.0, this.switchValue = false});

  ToggleState copyWith({double? sliderValue, bool? switchValue}) {
    return ToggleState(
      sliderValue: sliderValue ?? this.sliderValue,
      switchValue: switchValue ?? this.switchValue,
    );
  }
}

// StateNotifier that manages ToggleState
class ToggleNotifier extends StateNotifier<ToggleState> {
  ToggleNotifier() : super(const ToggleState());

  void updateSlider(double val) {
    state = state.copyWith(
      sliderValue: val,
      switchValue: val >= 1.0,
    );
  }

  void updateSwitch(bool val) {
    state = state.copyWith(
      sliderValue: val ? 1.0 : 0.0,
      switchValue: val,
    );
  }
}

// StateNotifierProvider exposing ToggleState
final toggleProvider = StateNotifierProvider<ToggleNotifier, ToggleState>((ref) => ToggleNotifier());

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
        body: Consumer(builder: (context, ref, child) {

          final state = ref.watch(toggleProvider);
          final notifier = ref.read(toggleProvider.notifier);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Slider(
                value: state.sliderValue,
                onChanged: notifier.updateSlider,
              ),
              Text(
                state.sliderValue.toStringAsFixed(2),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Switch(
                value: state.switchValue,
                onChanged: notifier.updateSwitch,
              ),
            ],
          );
        }));
  }
}
