import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliver Widgets Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sliver Widgets Demo'),
        ),
        body: CustomScrollView(
          slivers: [
            // SliverAppBar that expands and collapses
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('SliverAppBar'),
                background: Image.network(
                  'https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // SliverList to display a list of items
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    title: Text('Item ${index + 1}'),
                    subtitle: Text('This is item number ${index + 1}'),
                  );
                },
                childCount: 10,
              ),
            ),
            // SliverGrid to display a grid of items
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    color: Colors.blueAccent,
                    child: Center(
                      child: Text(
                        'Grid Item ${index + 1}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                childCount: 8,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
