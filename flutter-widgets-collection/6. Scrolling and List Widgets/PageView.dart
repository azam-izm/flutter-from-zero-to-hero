import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageView Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('PageView Demo'),
        ),
        body: PageView(
          scrollDirection: Axis.horizontal, // Scroll horizontally (default)
          children: [
            Container(
              color: Colors.red,
              child: Center(
                child: Text(
                  'Page 1',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            Container(
              color: Colors.green,
              child: Center(
                child: Text(
                  'Page 2',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Page 3',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
