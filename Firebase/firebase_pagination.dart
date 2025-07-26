import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Pagination',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PaginationScreen(),
    );
  }
}

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<String> _posts = []; // Store text strings directly
  bool _isLoading = false;
  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  final int _batchSize = 15;

  @override
  void initState() {
    super.initState();
    _loadPosts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !_isLoading && // Checks if _isLoading is false to start loading more items
          _hasMore) {
        _loadPosts();
      }
    });
  }

  // Fetches posts from Firestore with pagination
  Future<void> _loadPosts() async {
    if (_isLoading || !_hasMore) return; // Exit if already loading or no more posts to fetch

    setState(() => _isLoading = true); // Show loading indicator

    try {
      // Create query to fetch posts from 'pagination' collection, ordered by 'text'
      Query<Map<String, dynamic>> query = FirebaseFirestore.instance
          .collection('pagination')
          .orderBy('text')
          .limit(_batchSize); // Limit to batch size (e.g., 5 posts)

      // If there's a last document, start after it for pagination
      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      // Execute query and get results
      QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();

      // If no documents are returned, stop pagination
      if (snapshot.docs.isEmpty) {
        setState(() {
          _hasMore = false; // No more posts to load
          _isLoading = false; // Hide loading indicator
        });
        return;
      } else {
        // If documents are found, update state with new posts
        setState(() {
          _posts.addAll(snapshot.docs.map((doc) => doc['text'] ?? 'No Text')); // Add 'text' field to posts list
          _lastDocument = snapshot.docs.last; // Store last document for next fetch
          _isLoading = false; // Hide loading indicator
          _hasMore = snapshot.docs.length == _batchSize; // Check if more posts exist
        });
      }
    } catch (e) {
      // Handle any errors during fetch
      setState(() => _isLoading = false); // Hide loading indicator
      print('Error: $e'); // Log error for debugging
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination')),
      body: _posts.isEmpty && !_isLoading
          ? const Center(child: Text('No posts found'))
          : ListView.builder(
              controller: _scrollController,
              itemCount: _posts.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _posts.length) {
                  return _isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }
                return ListTile(
                  title: Text(_posts[index]),
                  contentPadding: const EdgeInsets.all(8.0),
                );
              },
            ),
    );
  }
}
