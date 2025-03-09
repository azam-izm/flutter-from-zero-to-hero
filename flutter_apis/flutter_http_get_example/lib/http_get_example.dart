import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'todo_model.dart';

// A screen that fetches and displays a list of todos using `http.get`
class HttpGetExample extends StatelessWidget {
  const HttpGetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos List - http.get Example"),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<ModelClass>(
        future: fetchTodos(), // Fetch data from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data?.todos?.length ?? 0,
              itemBuilder: (context, index) {
                Todos todo = snapshot.data!.todos![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    title: Text(
                      todo.todo ?? "No Title",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Completed: ${(todo.completed ?? false) ? '✅ Yes' : '❌ No'}",
                      style: TextStyle(
                        color: todo.completed! ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    tileColor: Colors.grey[100],
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text(
              'Oops! Something went wrong!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ); // Default fallback in case of an unknown error
        },
      ),
    );
  }
}

// Fetches todo items from the API using an HTTP GET request.
Future<ModelClass> fetchTodos() async {
  final url = Uri.parse('https://dummyjson.com/todos'); // API endpoint
  final response = await http.get(url); // Making a GET request

  if (response.statusCode == 200) {
    // If successful, decode the JSON response
    Map<String, dynamic> data = jsonDecode(response.body);
    return ModelClass.fromJson(data); // Convert JSON to ModelClass object
  } else {
    // If the request fails, throw an exception
    throw Exception('Failed to load todos');
  }
}
