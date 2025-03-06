import 'package:flutter/material.dart';

void main() => runApp(const MediaQueryDemoApp());

class MediaQueryDemoApp extends StatelessWidget {
  const MediaQueryDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediaQuery Demo',
      home: const MediaQueryDemoScreen(),
    );
  }
}

class MediaQueryDemoScreen extends StatelessWidget {
  const MediaQueryDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch MediaQuery properties
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final deviceWidth = mediaQuery.size.width;
    final deviceHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MediaQuery Demo'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Device Orientation
              _buildOrientationSection(orientation),

              const SizedBox(height: 30),

              // Device Dimensions
              _buildDeviceDimensionsSection(deviceWidth, deviceHeight),

              const SizedBox(height: 30),

              // Responsive Layouts
              _buildResponsiveLayouts(deviceWidth, deviceHeight),

              const SizedBox(height: 30),

              // Responsive Font Size Example
              _buildResponsiveFontExample(deviceWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrientationSection(Orientation orientation) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Orientation:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            orientation == Orientation.portrait ? 'Portrait' : 'Landscape',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: orientation == Orientation.portrait
                  ? Colors.green
                  : Colors.orange,
            ),
          ),
          const SizedBox(height: 20),
          Icon(
            orientation == Orientation.portrait
                ? Icons.smartphone
                : Icons.tablet,
            size: 80,
            color: orientation == Orientation.portrait
                ? Colors.green
                : Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceDimensionsSection(double deviceWidth, double deviceHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Device Dimensions:',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Width: ${deviceWidth.toStringAsFixed(2)} px',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 5),
        Text(
          'Height: ${deviceHeight.toStringAsFixed(2)} px',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildResponsiveLayouts(double deviceWidth, double deviceHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Responsive Layouts:',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Full-width container
        Container(
          height: 50,
          width: deviceWidth,
          color: Colors.blue,
          child: const Center(
            child: Text(
              'Full Width Container',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Dynamic height container
        Container(
          height: deviceHeight / 4,
          width: deviceWidth * 0.8,
          color: Colors.amber,
          child: const Center(
            child: Text(
              'Dynamic Height Container (1/4 screen height)',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveFontExample(double deviceWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Responsive Font Example:',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'This text scales with screen width.',
          style: TextStyle(fontSize: deviceWidth * 0.05),
        ),
      ],
    );
  }
}
