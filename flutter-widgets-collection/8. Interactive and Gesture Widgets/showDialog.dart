import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'showDialog Example',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showBasicDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic Dialog'),
          content: const Text('This is a simple alert dialog.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation Dialog'),
          content: const Text('Do you want to continue?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('OK'),
            ),
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You selected OK!')),
        );
      }
    });
  }

  void _showCustomStyledDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Custom Dialog',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text('This dialog has a custom shape and padding.'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('DISMISS'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFullScreenDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54, // Custom background color
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Full-Screen Dialog')),
          body: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ),
        );
      },
    );
  }

  void _showBarrierDismissibleDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows dismissal by tapping outside
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Dismissible Dialog'),
          content: Text('Tap outside to dismiss this dialog.'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('showDialog Examples')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showBasicDialog(context),
              child: const Text('Show Basic Dialog'),
            ),
            ElevatedButton(
              onPressed: () => _showConfirmationDialog(context),
              child: const Text('Show Confirmation Dialog'),
            ),
            ElevatedButton(
              onPressed: () => _showCustomStyledDialog(context),
              child: const Text('Show Custom Dialog'),
            ),
            ElevatedButton(
              onPressed: () => _showFullScreenDialog(context),
              child: const Text('Show Full-Screen Dialog'),
            ),
            ElevatedButton(
              onPressed: () => _showBarrierDismissibleDialog(context),
              child: const Text('Show Barrier Dismissible Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
