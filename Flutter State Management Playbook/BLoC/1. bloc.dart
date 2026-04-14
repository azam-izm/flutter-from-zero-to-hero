/*
--------------------------------------------
       📌 Flutter BLoC Counter App
--------------------------------------------

🔹 Purpose:
   This Flutter app demonstrates how to use the BLoC (Business Logic Component)
   pattern to manage state. It shows a counter that can be incremented, decremented,
   multiplied, divided, and reset, all handled using BlocProvider and BlocBuilder.

🔹 Key Concepts Covered:
   1️⃣ BlocProvider → Provides the BLoC instance to the widget tree.
   2️⃣ BlocBuilder → Listens to state changes and rebuilds UI accordingly.
   3️⃣ CounterEvent → Defines all actions that can change the counter.
   4️⃣ CounterState → Holds the current counter value.
   5️⃣ CounterBloc → Handles events and updates the state.

--------------------------------------------
*/

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

// Wrap the app with BlocProvider
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          primarySwatch: Colors.grey,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Counter Bloc App',
        home: const CounterScreen(),
      ),
    );
  }
}

// UI screen to display and interact with the counter
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Counter App Using Bloc', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // BlocBuilder listens to CounterBloc and rebuilds the Text widget
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text('Counter: ${state.counter}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
              },
            ),
            const SizedBox(height: 20),
            // Buttons arranged using Wrap for responsive layout
            Wrap(
              spacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _counterButton(context, '+', IncrementCounter()),
                _counterButton(context, '-', DecrementCounter()),
                _counterButton(context, '÷2', DivideCounter()),
                _counterButton(context, '×2', MultiplyCounter()),
                _counterButton(context, 'Reset', ResetCounter()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a styled counter button
  Widget _counterButton(
      BuildContext context, String label, CounterEvent event) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () => context.read<CounterBloc>().add(event),
      child: Text(label),
    );
  }
}

//--------------------------------------------
// Define Events
//--------------------------------------------

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

// Increment the counter by 1
class IncrementCounter extends CounterEvent {}

// Decrement the counter by 1
class DecrementCounter extends CounterEvent {}

// Divide the counter by 2 (integer division)
class DivideCounter extends CounterEvent {}

// Multiply the counter by 2
class MultiplyCounter extends CounterEvent {}

// Reset the counter to 0
class ResetCounter extends CounterEvent {}

//--------------------------------------------
// Define State
//--------------------------------------------

class CounterState extends Equatable {

  final int counter;
  const CounterState({this.counter = 0});

  // Returns a new state with updated counter value
  CounterState copyWith({int? counter}) {
    return CounterState(counter: counter ?? this.counter);
  }

  @override
  List<Object> get props => [counter];
}

//--------------------------------------------
// Define Bloc
//--------------------------------------------

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<IncrementCounter>(_increment);
    on<DecrementCounter>(_decrement);
    on<DivideCounter>(_divide);
    on<MultiplyCounter>(_multiply);
    on<ResetCounter>((event, emit) => emit(const CounterState(counter: 0)));
  }

  void _increment(IncrementCounter event, Emitter<CounterState> emit) => emit(state.copyWith(counter: state.counter + 1));
  void _decrement(event, emit) => emit(state.copyWith(counter: state.counter - 1));
  void _divide(event, emit) => emit(state.copyWith(counter: state.counter != 0 ? state.counter ~/ 2 : 0));
  void _multiply(event, emit) => emit(state.copyWith(counter: state.counter * 2));
}

/*
--------------------------------------------
📌 Dry Run (Execution Flow)
--------------------------------------------
1️⃣ CounterBloc → Initialized with counter = 0.  
2️⃣ BlocProvider → Makes CounterBloc available to widget tree.  
3️⃣ BlocBuilder → Listens to CounterState and rebuilds Text widget.  
4️⃣ Buttons → Dispatch CounterEvent to CounterBloc:
     - IncrementCounter → +1
     - DecrementCounter → -1
     - DivideCounter → ÷2
     - MultiplyCounter → ×2
     - ResetCounter → 0
5️⃣ CounterState.copyWith → Produces new state for BlocBuilder to rebuild UI.

✅ Key Takeaways:
- Bloc separates **UI from business logic**.  
- BlocBuilder only rebuilds widgets that depend on state.  
- Equatable ensures efficient rebuilds by comparing state objects.  
- Use MultiBlocProvider to add more blocs easily.  
--------------------------------------------
*/
