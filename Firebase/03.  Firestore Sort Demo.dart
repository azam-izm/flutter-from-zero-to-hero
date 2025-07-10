import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Firestore Sort Demo',
      home: MessagesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController messageController = TextEditingController();
  String sortOption = 'time_desc'; // default sort

  // Add a message to Firestore
  void addMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add({
        'text': text,
        'createdAt': Timestamp.now(),
      });
      messageController.clear();
    }
  }

  // Build the Firestore query based on selected sort
  Query getSortedQuery() {
    final messages = FirebaseFirestore.instance.collection('messages');
    if (sortOption == 'alpha') {
      return messages.orderBy('text');
    } else if (sortOption == 'alpha_desc') {
      return messages.orderBy('text', descending: true);
    } else if (sortOption == 'time_asc') {
      return messages.orderBy('createdAt');
    } else {
      // time_desc (default)
      return messages.orderBy('createdAt', descending: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorted Messages'),
        actions: [
          DropdownButton<String>(
            value: sortOption,
            underline: const SizedBox(),
            onChanged: (value) {
              setState(() {
                sortOption = value!;
              });
            },
            items: const [
              DropdownMenuItem(value: 'time_desc', child: Text('Newest')),
              DropdownMenuItem(value: 'time_asc', child: Text('Oldest')),
              DropdownMenuItem(value: 'alpha', child: Text('A-Z')),
              DropdownMenuItem(value: 'alpha_desc', child: Text('Z-A')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getSortedQuery().snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages found.'));
                } else if (snapshot.hasData) {

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {

                      final doc = docs[index];
                      final text = doc['text'];
                      return ListTile(title: Text(text));
                    },
                  );
                } else {
                  return const Center(child: Text('Something unexpected happened.'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter message',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => addMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addMessage,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
