// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, sort_child_properties_last

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scaffold-widget----Gmail-like App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: GmailScreen(),
    );
  }
}

class GmailScreen extends StatefulWidget {
  @override
  _GmailScreenState createState() => _GmailScreenState();
}

class _GmailScreenState extends State<GmailScreen> {
  List<String> emails = [
    "Meeting with client at 3 PM",
    "Flutter project update",
    "Dinner invitation",
    "Important notice",
    "Team meeting notes",
    "Offer letter update",
  ];

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _deleteEmail(int index) {
    setState(() {
      String deletedEmail = emails.removeAt(index);
      _showSnackBar("Deleted: $deletedEmail");
    });
  }

  void _composeEmail() {
    _showSnackBar("Compose a new email!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gmail Clone"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSnackBar("Search not implemented yet!"),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text(
                "Navigation",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inbox),
              title: const Text("Inbox"),
              onTap: () => _showSnackBar("Inbox tapped"),
            ),
            ListTile(
              leading: const Icon(Icons.send),
              title: const Text("Sent"),
              onTap: () => _showSnackBar("Sent tapped"),
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Trash"),
              onTap: () => _showSnackBar("Trash tapped"),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  emails[index][0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(emails[index]),
              subtitle: const Text("Tap to open email"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteEmail(index),
              ),
              onTap: () => _showSnackBar("Opening: ${emails[index]}"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _composeEmail,
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
