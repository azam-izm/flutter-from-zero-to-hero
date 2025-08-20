/*
==========================
Multiple States with StateProvider (using a Data Class)
==========================

What it does:
    - Manages two related pieces of state (slider value & switch value)
      inside a single class (ToggleState).
    - Puts both the data and update logic inside the class itself.
    - Uses StateProvider instead of StateNotifier.

When to use:
    - When you want a lightweight solution without creating a separate Notifier.
    - Good for small to medium use cases where logic is simple.
    - Handy when you want immutable updates but don’t need advanced features of StateNotifier.

How it works:
    - ToggleState is an immutable data class with helper methods:
        * copyWithSlider() → updates slider and auto-adjusts switch.
        * copyWithSwitch() → updates switch and auto-adjusts slider.
    - StateProvider<ToggleState> holds the current state.
    - UI updates the state by replacing it with a new ToggleState copy.

Best Practices & Notes:
    1. Keep state updates pure and return new objects (immutability).
    2. Reassigning state is required since StateProvider works by replacement.
    3. Use StateNotifier for more complex state management,
       but StateProvider with a data class is simpler and perfectly valid for small apps.
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Model that represents the slider and switch state
class ToggleState {
  final double sliderValue;
  final bool switchValue;

  const ToggleState({this.sliderValue = 0.0, this.switchValue = false});

  // Creates a copy with updated slider value and automatically syncs the switch.
  ToggleState copyWithSlider(double value) {
    return ToggleState(
      sliderValue: value,
      switchValue: value >= 1.0,
    );
  }

  // Creates a copy with updated switch value and automatically syncs the slider.
  ToggleState copyWithSwitch(bool value) {
    return ToggleState(
      sliderValue: value ? 1.0 : 0.0,
      switchValue: value,
    );
  }
}

// Provider that stores the ToggleState
final toggleStateProvider = StateProvider<ToggleState>((ref) => const ToggleState());

void main() {
  runApp(const ProviderScope(child: ToggleApp()));
}

class ToggleApp extends StatelessWidget {
  const ToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TogglePage(),
    );
  }
}

class TogglePage extends StatelessWidget {
  const TogglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider & Switch Example')),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {

        final state = ref.watch(toggleStateProvider);
        final stateNotifier = ref.read(toggleStateProvider.notifier);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              value: state.sliderValue,
              onChanged: (value) => stateNotifier.state = state.copyWithSlider(value)
            ),
            Text(state.sliderValue.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            Switch(
              value: state.switchValue,
              onChanged: (value) => stateNotifier.state = state.copyWithSwitch(value)
            ),
          ],
        );
      })),
    );
  }
}
