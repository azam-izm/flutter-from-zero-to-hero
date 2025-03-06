import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Card Example',
      home: CardExample(),
    );
  }
}

class CardExample extends StatelessWidget {
  const CardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          Card(
            elevation: 5, // Controls the shadow depth
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(10)), // Rounded corners
            ),
            color: Colors.lightBlueAccent, // Background color of the card
            child: ListTile(
              title: Text('Card 1',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text('This is the first card in the list'),
            ),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            color: Colors.orangeAccent,
            child: ListTile(
              title: Text('Card 2',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text('This is the second card in the list'),
            ),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            color: Colors.greenAccent,
            child: ListTile(
              title: Text('Card 3',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text('This is the third card in the list'),
            ),
          ),
        ],
      ),
    );
  }
}
