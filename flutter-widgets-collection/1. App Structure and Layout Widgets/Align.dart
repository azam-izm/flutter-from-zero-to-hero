/*
  📚 Chapter: Mastering the Align Widget in Flutter
 
   🏗️ Overview:
   The Align widget is used to position widgets inside its parent using alignment coordinates.
   This lecture covers:
   - `Align` for precise widget positioning
   - `Stack` and `Positioned` for layered UI elements
   - Combining `Align` with `Transform.scale` for resizing effects
 
   🚀 By the end, you'll understand how to use `Align` effectively in real-world layouts!
Author: Muhammad Azam
*/

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
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // 🔵 A blue square aligned to the top-left
            topLeft(),

            // 🎨 A row of overlapping circles at the top, centered horizontally
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                colors.length,
                (index) => overlappingCircle(colors[index]),
              ),
            ),

            // 🌎 Glowing energy rings (orbit effect) aligned to the top-right
            ...List.generate(5, (index) {
              double scale = 1 - (index * 0.15);
              return Align(
                alignment: Alignment.topRight,
                child: Transform.scale(
                  scale: scale,
                  child: glowingCircle(Colors.blueAccent.withOpacity(0.3)),
                ),
              );
            }),

            // 🎨 Colorful circles aligned to bottom-left, decreasing in size
            ...List.generate(8, (index) {
              double scale = 1 - (index * 0.1);
              return Align(
                alignment: Alignment.bottomLeft,
                child: Transform.scale(
                  scale: scale,
                  child: circleWidget(
                    Colors.primaries[index % Colors.primaries.length],
                  ),
                ),
              );
            }),

            // 🔵 A blue square aligned to the bottom-right
            bottomRight(),
          ],
        ),
      ),
    );
  }
}

/*
 * 🔵 TopLeft Square
 * A simple blue square positioned at the top-left using `Align`.
 */
Widget topLeft() {
  return Align(
    alignment: Alignment.topLeft, // ✅ Positioned in top-left
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: const Center(
        child: Text(
          "Top Left",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

// 🎨 List of predefined colors for the overlapping circles
const List<Color> colors = [
  Colors.purple,
  Colors.indigo,
  Colors.blue,
  Colors.teal,
  Colors.green,
];

/*
 * 🟢 OverlappingCircle
 * This widget creates a row of overlapping circles.
 * It uses `Align` with `widthFactor` to control the overlap.
 */

Widget overlappingCircle(Color color) {
  return Align(
    widthFactor: 0.4, // 40% width shown, rest overlaps
    child: Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.black, width: 2),
      ),
    ),
  );
}

/*
 * 🌀 GlowingCircle
 * Creates a glowing circle effect using border and shadow.
 * Now aligned to the top-right for a unique effect.
 */
Widget glowingCircle(Color color) {
  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: color, width: 3),
      boxShadow: [BoxShadow(color: color, blurRadius: 15)],
    ),
  );
}

/*
 * 🎨 CircleWidget
 * Creates a filled circle with a semi-transparent effect.
 * Used in the bottom-left alignment for a shrinking effect.
 */
Widget circleWidget(Color color) {
  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color.withOpacity(0.8),
      border: Border.all(color: Colors.white, width: 2),
    ),
  );
}

/*
 * 🔵 BottomRight Square
 * A simple blue square positioned at the bottom-right using `Align`.
 */
Widget bottomRight() {
  return Align(
    alignment: Alignment.bottomRight, // ✅ Positioned in bottom-right
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: const Center(
        child: Text(
          "Bottom Right",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
