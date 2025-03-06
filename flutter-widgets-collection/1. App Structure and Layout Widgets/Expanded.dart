// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expanded Widget Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ExpandedWidgetExample(),
    );
  }
}

class ExpandedWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expanded Widget Example'),
      ),
      body: Column(
        children: [
          // Horizontal Row with Expanded Containers
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue[100],
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        '1 Flex',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        '2 Flex',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    color: Colors.orange,
                    child: const Center(
                      child: Text(
                        '1 Flex',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Vertical Column with Expanded Containers
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        '1 Flex',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.purple,
                    child: const Center(
                      child: Text(
                        '2 Flex',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.yellow,
                    child: const Center(
                      child: Text(
                        '1 Flex',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
