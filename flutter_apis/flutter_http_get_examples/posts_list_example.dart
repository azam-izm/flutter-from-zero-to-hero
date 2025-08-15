import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostsScreen(),
    );
  }
}

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<ListOfModel> postsList = []; // Stores API data

  // Fetch data from API and store in postsList
  Future<void> fetchPosts() async {
    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        postsList = data.map((e) => ListOfModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts List"),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (postsList.isNotEmpty) {
            return ListView.builder(
              itemCount: postsList.length,
              itemBuilder: (context, index) {
                final post = postsList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: ListTile(
                    title: Text(
                      post.title ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(post.body ?? ""),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'No posts available',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
        },
      ),
    );
  }
}

// Model class
class ListOfModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  ListOfModel({this.userId, this.id, this.title, this.body});

  ListOfModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}
