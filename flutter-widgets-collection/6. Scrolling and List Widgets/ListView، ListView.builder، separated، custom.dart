import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('ListView Variants')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Example of a basic ListView with fixed items
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('ListView:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 150,
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: const [
                    ListTile(
                      leading: Icon(Icons.star),
                      title: Text('ListView Item 1'),
                    ),
                    ListTile(
                      leading: Icon(Icons.star),
                      title: Text('ListView Item 2'),
                    ),
                  ],
                ),
              ),

              // Example of ListView.builder for dynamic content
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('ListView.builder:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.build),
                      title: Text('Builder Item ${index + 1}'),
                    );
                  },
                ),
              ),

              // Example of ListView.separated with dividers between items
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('ListView.separated:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.line_style),
                      title: Text('Separated Item ${index + 1}'),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),

              // Example of ListView.custom for advanced customization
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('ListView.custom:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 150,
                child: ListView.custom(
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text('Custom Item ${index + 1}'),
                    ),
                    childCount: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
