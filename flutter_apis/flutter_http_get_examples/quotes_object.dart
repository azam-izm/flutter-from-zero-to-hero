import 'package:flutter/material.dart';
import 'dart:convert';
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
      home: HttpGetExample(),
    );
  }
}

// A screen that fetches and displays a list of quotes using `http.get`
class HttpGetExample extends StatefulWidget {
  const HttpGetExample({super.key});

  @override
  State<HttpGetExample> createState() => _HttpGetExampleState();
}

class _HttpGetExampleState extends State<HttpGetExample> {
  ModelClass? quotesData;

  // Fetches quotes from the API and stores them in quotesData
  Future<void> fetchQuotes() async {
    try {
      final url = Uri.parse('https://dummyjson.com/quotes'); // API endpoint
      final response = await http.get(url); // Making a GET request

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        quotesData = ModelClass.fromJson(data); // Store in variable
      } else {
        throw Exception('Failed to load quotes: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<void>(
        future: fetchQuotes(), // Fetch data from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (quotesData != null && quotesData!.quotes != null) {
            return ListView.separated(
                itemCount: quotesData!.quotes!.length,
                itemBuilder: (context, index) {
                  Quotes quote = quotesData!.quotes![index];
                  return ListTile(
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
                  );
                },
                separatorBuilder: (context, child) => const Divider());
          } else {
            return const Center(
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

// Model class to represent the API response structure.
class ModelClass {
  List<Quotes>? quotes; // List of quotes
  int? total; // Total number of quotes
  int? skip; // Number of skipped quotes (for pagination)
  int? limit; // Number of quotes returned per request

  ModelClass({this.quotes, this.total, this.skip, this.limit});

  // Converts JSON response into a Dart object.
  ModelClass.fromJson(Map<String, dynamic> json) {
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes!.add(Quotes.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
}

// Represents a single quote item.
class Quotes {
  int? id; // Unique identifier for the quote
  String? quote; // The quote text
  String? author; // Author of the quote

  Quotes({this.id, this.quote, this.author});

  // Converts JSON object into a Dart object.
  Quotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quote = json['quote'];
    author = json['author'];
  }
}
