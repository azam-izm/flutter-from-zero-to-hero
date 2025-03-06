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
        appBar: AppBar(title: const Text('GridView Variants')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Example of a basic GridView with fixed items
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('GridView:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 300,
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(10),
                  children: const [
                    Card(color: Colors.red, child: Center(child: Text('Item 1'))),
                    Card(color: Colors.blue, child: Center(child: Text('Item 2'))),
                    Card(color: Colors.green, child: Center(child: Text('Item 3'))),
                    Card(color: Colors.yellow, child: Center(child: Text('Item 4'))),
                  ],
                ),
              ),

              // Example of GridView.builder for dynamic content
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('GridView.builder:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.amber,
                      child: Center(child: Text('Builder Item ${index + 1}')),
                    );
                  },
                ),
              ),

              // Example of GridView.extent with a max cross-axis extent
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('GridView.extent:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 300,
                child: GridView.extent(
                  maxCrossAxisExtent: 150,
                  padding: const EdgeInsets.all(10),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: List.generate(
                    8,
                    (index) => Card(
                      color: Colors.purple,
                      child: Center(child: Text('Extent Item ${index + 1}')),
                    ),
                  ),
                ),
              ),

              // Example of GridView.custom for advanced customization
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('GridView.custom:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 300,
                child: GridView.custom(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) => Card(
                      color: Colors.teal,
                      child: Center(child: Text('Custom Item ${index + 1}')),
                    ),
                    childCount: 6,
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
