/*
========================================================
FLUTTER NAVIGATION: COMPREHENSIVE LECTURE (NAVIGATOR ONLY)
========================================================

ROADMAP:
1. What is Navigation?
2. Navigation Stack Basics
3. Core Navigator Methods
4. Best Practices & Pitfalls
========================================================
*/

import 'package:flutter/material.dart';

/*
========================================================
1. WHAT IS NAVIGATION?
========================================================

Definition:
Navigation refers to moving between screens in an app.
Flutter uses a "stack" model: routes are pushed/popped from a LIFO stack.

Purpose:
- Enable multi-screen user experiences.
- Manage app flow (e.g., login → FirstScreen → details).
- Handle back button behavior.
========================================================
*/

void main() {
  runApp(const MyApp());
}

// ========================================================
// MAIN APP WIDGET
// ========================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Navigation Lecture',
      home: FirstScreen(),
    );
  }
}

/*
========================================================
2. NAVIGATION STACK BASICS
========================================================

Visualizing the Stack:
- Initial Stack: [FirstScreen]
- After push: [FirstScreen, SecondScreen]
- After pop: [FirstScreen]
========================================================
*/

/*
========================================================
3. CORE NAVIGATOR METHODS
========================================================
*/

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Push a new screen onto the stack
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              child: const Text('Push to Second Screen'),
            ),
            const SizedBox(height: 20),

            // Replace the current screen with a new one
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              child: const Text('Push Replacement (Second Screen)'),
            ),
            const SizedBox(height: 20),

            // Conditional pop (Only pops if possible)
            ElevatedButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Conditional Pop'),
            ),
            const SizedBox(height: 20),

            // maybePop (Pops if possible, else does nothing)
            ElevatedButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              child: const Text('Maybe Pop'),
            ),
/*
  How maybePop Differs from Navigator.canPop
  Action vs. Check:

  Navigator.canPop is a synchronous method that simply checks if the current route can be popped. It returns true or false 
  immediately.
  Navigator.maybePop is an asynchronous method that attempts to pop the current route and returns a Future<bool> indicating 
  whether the pop was successful.
*/
          ],
        ),
      ),
    );
  }
}

// --------------------------
// Second Screen
// --------------------------
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
/*
  Navigator.pop (Pops (removes) the top-most route from the navigation stack)
  Used when you want to go back to the previous screen, it's Safe, will not crash if it's the last route
*/

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Pop to First Screen'),
            ),
            const SizedBox(height: 20),

            // Push to Third Screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdScreen()),
                );
              },
              child: const Text('Push to Third Screen'),
            ),
            const SizedBox(height: 20),

            // Push and remove all previous screens
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdScreen()),
                  (route) => false, // Removes all previous routes
                );
              },
              child: const Text('Push and Remove All'),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------
// Third Screen
// --------------------------
class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Third Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
/*
  Navigator.of(context).removeRoute(route)
  Removes a specific route from the stack
  Used to remove a route from anywhere in the stack
  The route is removed, but the user stays on the current screen unless the removed route was on top
  When you need to dynamically remove a route (e.g., after logout or cleanup)
  Can cause a crash if the route doesn't exist or is the only route left
*/
            ElevatedButton(
              onPressed: () {
                final currentRoute = ModalRoute.of(context);

                if (Navigator.canPop(context) && currentRoute != null) {
                  Navigator.of(context).removeRoute(currentRoute);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No routes left to remove!")),
                  );
                }
              },
              child: const Text('Remove Current Route'),
            ),
            const SizedBox(height: 20),

            // Pop until reaching the first screen
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Pop Until First Screen'),
            ),
            const SizedBox(height: 20),

            // Remove previous route
            ElevatedButton(
              onPressed: () {
                final currentRoute = ModalRoute.of(context);
                if (currentRoute != null) {
                  Navigator.of(context).removeRouteBelow(currentRoute);
                }
              },
              child: const Text('Remove Route Below'),
            ),
            const SizedBox(height: 20),

            // Replace current route
            ElevatedButton(
              onPressed: () {
                final currentRoute = ModalRoute.of(context);
                if (currentRoute != null) {
                  Navigator.replace(
                    context,
                    oldRoute: currentRoute,
                    newRoute: MaterialPageRoute(
                        builder: (context) => const FirstScreen()),
                  );
                }
              },
              child: const Text('Replace Current Route with FirstScreen'),
            ),
            const SizedBox(height: 20),

            // Push using Navigator.of
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              child: const Text('Navigator.of - Push to Second Screen'),
            ),
            const SizedBox(height: 20),

            // Restorable Push (State restoration navigation)
            ElevatedButton(
              onPressed: () {
                Navigator.restorablePush(
                  context,
                  (context, arguments) => MaterialPageRoute(
                    builder: (context) => const SecondScreen(),
                  ),
                );
              },
              child: const Text('Restorable Push to Second Screen'),
            ),
            const SizedBox(height: 20),

            // Push to First Screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstScreen()),
                );
              },
              child: const Text('Push to First Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

/*
========================================================
4. BEST PRACTICES & PITFALLS
========================================================

✅ Best Practices:
- Use `pushAndRemoveUntil` for clearing history after logout.
- Prefer `pushReplacement` when replacing authentication screens.
- Use `Navigator.canPop` before calling `pop()` to avoid crashes.
- `restorablePush` is recommended for preserving state in critical flows.

⚠️ Pitfalls:
- Don't overuse `pushAndRemoveUntil`, as it clears all history.
- Avoid using `removeRoute` unless necessary (can cause navigation bugs).
- Be cautious when replacing screens dynamically (`replace` can break the flow).
========================================================


===========
= SUMMARY =
===========

1️⃣ Navigation Concept:
   - Flutter uses a **stack-based** navigation system (LIFO).
   - Screens (routes) are pushed onto or popped from the stack.

2️⃣ Core Methods:
   ✅ `Navigator.push(context, MaterialPageRoute(...))` → Push a new screen.
   ✅ `Navigator.pop(context)` → Pop the current screen.
   ✅ `Navigator.pushReplacement(context, MaterialPageRoute(...))` → Replace current screen.
   ✅ `Navigator.pushAndRemoveUntil(context, MaterialPageRoute(...), (route) => false)`
      → Clear back stack & push a new screen.
   ✅ `Navigator.popUntil(context, (route) => route.isFirst)` → Go back to the first screen.
   ✅ `Navigator.canPop(context)` → Check if popping is possible.
   ✅ `Navigator.maybePop(context)` → Try to pop, else do nothing.
   ✅ `Navigator.removeRoute(route)` → Remove a specific route.
   ✅ `Navigator.removeRouteBelow(route)` → Remove the route below the current one.
   ✅ `Navigator.replace(context, oldRoute: ..., newRoute: ...)` → Replace a specific route.
   ✅ `Navigator.restorablePush(context, builder)` → Push with **state restoration**.

3️⃣ Best Practices:
   ✅ Use `pushReplacement` for authentication flows.
   ✅ Prefer `pushAndRemoveUntil` for logout scenarios.
   ✅ Always check `Navigator.canPop()` before calling `pop()` to prevent crashes.
   ✅ `restorablePush` helps maintain navigation state after app restarts.

4️⃣ Common Pitfalls:
   ❌ Overusing `pushAndRemoveUntil` clears all history unnecessarily.
   ❌ Using `removeRoute` incorrectly may break navigation.
   ❌ Avoid `replace` unless necessary, as it disrupts navigation flow.

✅ **Key Takeaway:** Mastering `Navigator` ensures seamless multi-screen navigation in Flutter! 🚀
========================================================
*/
