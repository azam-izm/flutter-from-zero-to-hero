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

//--------------------------------------------
// Define Events
//--------------------------------------------
abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class IncrementCounter extends CounterEvent {}

class DecrementCounter extends CounterEvent {}

class DivideCounter extends CounterEvent {}

class MultiplyCounter extends CounterEvent {}

class ResetCounter extends CounterEvent {}

//--------------------------------------------
// Define State
//--------------------------------------------
class CounterState extends Equatable {
  final int counter;
  const CounterState({this.counter = 0});

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
    on<ResetCounter>((event, emit) => emit(state.copyWith(counter: 0)));
  }
  void _increment(IncrementCounter event, Emitter<CounterState> emit) => emit(state.copyWith(counter: state.counter + 1));
  void _decrement(DecrementCounter event, Emitter<CounterState> emit) => emit(state.copyWith(counter: state.counter - 1));
  void _divide(DivideCounter event, Emitter<CounterState> emit) => emit(state.copyWith(counter: state.counter != 0 ? state.counter ~/ 2 : 0));
  void _multiply(MultiplyCounter event, Emitter<CounterState> emit) => emit(state.copyWith(counter: state.counter * 2));
}

// Wrap the app with BlocProvider
void main() {
  runApp(BlocProvider(
    create: (_) => CounterBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterPage(),
    );
  }
}

// UI screen to display and interact with the counter
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
          return Text(
            '${state.counter}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        }),
      ),
      floatingActionButton: Container(
        color: Colors.blueGrey,
        width: double.infinity,
        height: 160,
        child: Stack(
          children: [
            /// LEFT SIDE (+ , -) vertically
            Positioned(
              left: 20,
              bottom: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(IncrementCounter());
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(DecrementCounter());
                    },
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),

            /// RIGHT SIDE (÷ , ×) vertically
            Positioned(
              right: 20,
              bottom: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(DivideCounter());
                    },
                    child: const Text("÷"),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(MultiplyCounter());
                    },
                    child: const Text("×"),
                  ),
                ],
              ),
            ),

            /// CENTER (reset stays same place)
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Center(
                child: FloatingActionButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(ResetCounter());
                  },
                  child: const Icon(Icons.refresh),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
