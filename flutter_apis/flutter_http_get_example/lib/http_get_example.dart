import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'todo_model.dart';

// A screen that fetches and displays a list of quotes using `http.get`
class HttpGetExample extends StatelessWidget {
  const HttpGetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes List - http.get Example"),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<ModelClass>(
        future: fetchQuotes(), // Fetch data from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.quotes?.length ?? 0,
              itemBuilder: (context, index) {
                Quotes quote = snapshot.data!.quotes![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    title: Text(
                      '"${quote.quote}"',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "- ${quote.author}",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    tileColor: Colors.grey[100],
                  ),
                );
              },
            );
          } else {
            return const Center( // Default fallback in case of an unknown error
            child: Text(
              'Oops! Something went wrong!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ); 
          } 
        },
      ),
    );
  }
}

// Fetches quotes from the API using an HTTP GET request.
Future<ModelClass> fetchQuotes() async {
  try {
    final url = Uri.parse('https://dummyjson.com/quotes'); // API endpoint
    final response = await http.get(url); // Making a GET request

    if (response.statusCode == 200) {
      // If successful, decode the JSON response
      Map<String, dynamic> data = jsonDecode(response.body);
      return ModelClass.fromJson(data); // Convert JSON to ModelClass object
    } else {
      // If the request fails, throw an exception with status code
      throw Exception('Failed to load quotes: ${response.statusCode}');
    }
  } catch (error) {
    // Catch network errors, timeouts, or JSON parsing issues
    throw Exception('An error occurred: $error');
  }
}
