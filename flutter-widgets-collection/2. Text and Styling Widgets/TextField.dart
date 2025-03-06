import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('TextField Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NameTextField(),
              const SizedBox(height: 20),
              EmailTextField(),
            ],
          ),
        ),
      ),
    ),
  ));
}

// TextField for name input
Widget NameTextField() {
  return const TextField(
    decoration: InputDecoration(
      labelText: 'Enter your name',
      hintText: 'First and Last Name',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.person),
    ),
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    textCapitalization: TextCapitalization.words,
    maxLength: 100,
    style: TextStyle(fontSize: 18),
    textAlign: TextAlign.left,
    cursorColor: Colors.blue,
    cursorWidth: 2.0,
  );
}

// TextField for email input
Widget EmailTextField() {
  return const TextField(
    decoration: InputDecoration(
      labelText: 'Enter your email',
      hintText: 'example@email.com',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.email),
    ),
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.done,
    maxLength: 50,
    style: TextStyle(fontSize: 18),
    textAlign: TextAlign.left,
    cursorColor: Colors.blue,
    cursorWidth: 2.0,
  );
}
