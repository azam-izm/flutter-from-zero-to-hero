import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Table Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(color: Colors.black),
            children: [
              TableRow(
                children: [
                  TableCell(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Header 1', style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
                  TableCell(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Header 2', style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Row 1, Cell 1'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Row 1, Cell 2'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Row 2, Cell 1'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Row 2, Cell 2'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
