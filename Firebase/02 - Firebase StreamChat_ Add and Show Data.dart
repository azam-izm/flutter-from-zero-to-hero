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
      title: 'Firebase Enhanced Chat',
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
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _updateController = TextEditingController();
  String? _selectedDocumentId; // To keep track of the document being updated

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('messages')
          .add({'text': text, 'createdAt': Timestamp.now()}); // Added timestamp
      _messageController.clear();
    }
  }

  void _deleteMessage(String documentId) async {
    await FirebaseFirestore.instance
        .collection('messages')
        .doc(documentId)
        .delete();
  }

  void _startUpdate(String documentId, String currentText) {
    setState(() {
      _selectedDocumentId = documentId;
      _updateController.text = currentText;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Message'),
        content: TextField(
          controller: _updateController,
          decoration: const InputDecoration(hintText: 'Enter new message'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _selectedDocumentId = null;
                _updateController.clear();
              });
            },
          ),
          ElevatedButton(
            child: const Text('Update'),
            onPressed: () {
              _updateMessage(documentId, _updateController.text.trim());
              Navigator.of(context).pop();
              setState(() {
                _selectedDocumentId = null;
                _updateController.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  void _updateMessage(String documentId, String newText) async {
    if (newText.isNotEmpty && _selectedDocumentId != null) {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(_selectedDocumentId) // Use _selectedDocumentId here
          .update({
        'text': newText,
        'updatedAt': Timestamp.now(),
      });
    }
  }

  // Function to query messages containing a specific word
  void _queryMessages(String query) async {
    if (query.isNotEmpty) {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('messages')
              .where('text', isGreaterThanOrEqualTo: query)
              .where('text',
                  isLessThan: query + 'z') // Simple way to query containing
              .get();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Found ${snapshot.docs.length} messages containing "$query"')),
      );
      // You can then update the UI to display these queried messages if needed.
      // For this example, we're just showing a snackbar.
      for (var doc in snapshot.docs) {
        print('Queried Message: ${doc.data()['text']}');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a query.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  final queryController = TextEditingController();
                  return AlertDialog(
                    title: const Text('Search Messages'),
                    content: TextField(
                      controller: queryController,
                      decoration:
                          const InputDecoration(hintText: 'Enter search term'),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Search'),
                        onPressed: () {
                          _queryMessages(queryController.text.trim());
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('createdAt')
                  .snapshots(), // Ordering by timestamp
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }
                final docs = snapshot.data!.docs;
                /*
                =====================
                QuerySnapshot contains a property called .docs
                You must use .docs because that’s the official API of QuerySnapshot. There is no other way to directly get the list of documents.

                Without .docs, you’re just holding the snapshot, not the actual documents inside it.
                =====================
                */
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['text'] ?? 'No Text'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _startUpdate(doc.id, data['text']),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteMessage(doc.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter message',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      final text = value.trim();
                      if (text.isNotEmpty) {
                        _sendMessage(); // _sendMessage already uses _messageController.text
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
