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
      title: 'StreamBuilder with cloud_firestore: Simple Add, Edit, Delete Operations',
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
  final TextEditingController updateController = TextEditingController();

  // Add a new message
  void addMessage() {
    final messageText = messageController.text.trim();

    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add({'text': messageText});
      messageController.clear();

    }
  }

  // Delete a message by ID
  void deleteMessage(String id) {
    FirebaseFirestore.instance.collection('messages').doc(id).delete();
  }

  // Show dialog to update message
  void showUpdateDialog(String id, String currentText) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Show current message in the title
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Update Message'),
              const SizedBox(height: 4),
              Text('Current: $currentText',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          content: TextField(
            controller: updateController,
            decoration: const InputDecoration(hintText: 'Enter new message'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                updateController.clear();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                updateMessage(id); // Pass ID directly
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Update message by ID
  void updateMessage(String id) {
    final newText = updateController.text.trim();
    if (newText.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').doc(id).update({'text': newText});
      updateController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: Column(
        children: [
          // Display messages using StreamBuilder
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('messages').snapshots(),
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

                      return ListTile(
                        title: Text(text),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => showUpdateDialog(doc.id, text),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteMessage(doc.id),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Something unexpected happened.'));
                }
              },
            ),
          ),

          // Input field + Add button
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
