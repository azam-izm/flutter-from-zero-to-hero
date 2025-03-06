import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const ThemeChangerApp(),
    );
  }
}

class ThemeChangerApp extends StatefulWidget {
  const ThemeChangerApp({Key? key}) : super(key: key);

  @override
  State<ThemeChangerApp> createState() => _ThemeChangerAppState();
}

class _ThemeChangerAppState extends State<ThemeChangerApp> {
  Color? _currentColor;

  static const Map<String, Color> themeColors = {
    'Red': Colors.red,
    'Blue': Colors.blue,
    'Green': Colors.green,
    'Purple': Colors.purple,
    'Orange': Colors.orange,
    'Cyan': Colors.cyan,
  };

  static const double _dropdownWidth = 200;
  static const double _dropdownHeight = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Theme Color Selector',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        color: _currentColor ?? Colors.grey[300],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: _buildDropdown(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      width: _dropdownWidth,
      height: _dropdownHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownMenu<String>(
        width: _dropdownWidth,
        initialSelection: _getSelectedColorName(),
        onSelected: _onColorSelected,
        dropdownMenuEntries: themeColors.keys.map((colorName) {
          return DropdownMenuEntry<String>(value: colorName, label: colorName);
        }).toList(),
        enableFilter: true,
        hintText: 'Select theme color',
        textStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        menuStyle: MenuStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          elevation: MaterialStateProperty.all(8.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
      ),
    );
  }

  String? _getSelectedColorName() {
    if (_currentColor == null) return null;
    return themeColors.keys.firstWhere(
      (k) => themeColors[k] == _currentColor,
      orElse: () => 'Red',
    );
  }

  void _onColorSelected(String? newValue) {
    setState(() {
      _currentColor = newValue != null ? themeColors[newValue] : null;
    });
  }
}
