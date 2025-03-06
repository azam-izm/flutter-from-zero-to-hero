import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _opacity = 1.0; // Current opacity of the child

  void _toggleOpacity() {
    setState(() {
      _opacity = _opacity == 1.0 ? 0.1 : 1.0; // Toggle between 1 and 0
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedOpacity Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedOpacity Demo'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: _toggleOpacity,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1), // Duration of the animation
              opacity: _opacity, // Current opacity
              curve: Curves.easeInOut, // Type of curve for animation
              child: Container(
                width: 200,
                height: 200,
                color: Colors.black,
                child: const Center(
                  child: Text(
                    'Tap to Fade',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
