import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Widget Example',
      home: const ImageExample(),
    );
  }
}

class ImageExample extends StatelessWidget {
  const ImageExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Widget Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Asset Image',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Image(
              image: AssetImage('assets/flutter_logo.png'), // Use an asset image
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Network Image',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Image(
              image: NetworkImage(
                  'https://flutter.dev/assets/homepage/carousel/slide_1-bg-4554bbae30578bc1772e747b8d1b7e1b9680fc5f4f77f91b1c5e2ee371fa6374.png'),
              width: 300,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Circular Network Image',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ClipOval(
              child: Image.network(
                'https://avatars.githubusercontent.com/u/14101776?s=200&v=4',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Images displayed successfully!')),
                );
              },
              child: const Text('Show Snackbar'),
            ),
          ],
        ),
      ),
    );
  }
}
