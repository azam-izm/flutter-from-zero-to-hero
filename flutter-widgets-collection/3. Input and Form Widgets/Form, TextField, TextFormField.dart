import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form & TextFormField Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('TextFormField Demo')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: MyForm(),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String _savedValue = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Calls onSaved of TextFormField
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved Value: $_savedValue')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction, // Validate when user interacts
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter your name',
              border: OutlineInputBorder(),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              if (value.length < 3) {
                return 'Name must be at least 3 characters long';
              }
              return null; // Input is valid
            },
            onSaved: (value) {
              _savedValue = value ?? '';
              print('Saved Value: $_savedValue');
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
