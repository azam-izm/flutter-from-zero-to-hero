import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GestureDetector Example',
      home: const GestureDetectorExample(),
    );
  }
}

class GestureDetectorExample extends StatefulWidget {
  const GestureDetectorExample({Key? key}) : super(key: key);

  @override
  _GestureDetectorExampleState createState() => _GestureDetectorExampleState();
}

class _GestureDetectorExampleState extends State<GestureDetectorExample> {
  String _message = 'Tap or swipe on the box!';

  void _onTap() {
    setState(() {
      _message = 'Box tapped!';
    });
  }

  void _onDoubleTap() {
    setState(() {
      _message = 'Box double-tapped!';
    });
  }

  void _onLongPress() {
    setState(() {
      _message = 'Box long pressed!';
    });
  }

  void _onVerticalDrag() {
    setState(() {
      _message = 'Vertical drag detected!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GestureDetector Example'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _onTap,
          onDoubleTap: _onDoubleTap,
          onLongPress: _onLongPress,
          onVerticalDragUpdate: (_) => _onVerticalDrag(),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
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
