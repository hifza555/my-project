import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const GuessGameApp());
}

class GuessGameApp extends StatelessWidget {
  const GuessGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess Numbers Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1B2E),
      ),
      home: SplashScreen(),
    );
  }
}
