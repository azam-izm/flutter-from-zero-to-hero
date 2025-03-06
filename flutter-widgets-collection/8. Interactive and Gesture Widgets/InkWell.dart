import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'InkWell Example',
      home: InkWellExample(),
    );
  }
}

class InkWellExample extends StatefulWidget {
  const InkWellExample({Key? key}) : super(key: key);

  @override
  _InkWellExampleState createState() => _InkWellExampleState();
}

class _InkWellExampleState extends State<InkWellExample> {
  String _message = 'Tap the box to see ripple effect';

  void _onTap() {
    setState(() {
      _message = 'Box tapped!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InkWell Example'),
      ),
      body: Center(
        child: InkWell(
          onTap: _onTap,
          splashColor: Colors.blueAccent, // Splash color
          highlightColor: Colors.blue, // Highlight color
          borderRadius:
              BorderRadius.circular(10), // Rounded corners for the ripple
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                _message,
                style: const TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
