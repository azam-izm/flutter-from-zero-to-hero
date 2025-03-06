import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeArea Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SafeArea Demo'),
        ),
        body: SafeArea(
          child: Center(
            child: Text(
              'This text is inside a SafeArea!',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
