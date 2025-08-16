import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stateless as Stateful',
      home: NotifyListenerScreen(),
    );
  }
}

class NotifyListenerScreen extends StatelessWidget {
  NotifyListenerScreen({super.key});

  // Counter using ValueNotifier
  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless Widget Acting Stateful'),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: counter,
          builder: (context, value, child) {
            return Text(
              counter.value.toString(),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.value++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
