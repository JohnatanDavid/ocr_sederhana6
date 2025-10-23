// Salin semua kode ini ke lib/screens/splash_screen.dart
import 'dart:async'; // [cite: 89]
import 'package:flutter/material.dart';
import 'home_screen.dart'; // [cite: 90]

class SplashScreen extends StatefulWidget { // [cite: 93]
  const SplashScreen({super.key}); // [cite: 95]

  @override
  State<SplashScreen> createState() => _SplashScreenState(); // [cite: 97]
}

class _SplashScreenState extends State<SplashScreen> { // [cite: 98]
  @override
  void initState() { // [cite: 108]
    super.initState();
    Timer(const Duration(seconds: 2), () { // [cite: 110]
      Navigator.pushReplacement( // [cite: 111]
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()), // [cite: 113, 114]
      );
    });
  }

  @override
  Widget build(BuildContext context) { // [cite: 125]
    return Scaffold( // [cite: 128]
      backgroundColor: Colors.blue, // [cite: 130]
      body: Center( // [cite: 132]
        child: Column( // [cite: 134]
          mainAxisAlignment: MainAxisAlignment.center, // [cite: 136]
          children: const [
            CircularProgressIndicator(color: Colors.white), // [cite: 140]
            SizedBox(height: 20), // [cite: 143]
            Text( // [cite: 144]
              'OCR Scanner',
              style: TextStyle(color: Colors.white, fontSize: 24), // [cite: 146, 147]
            ),
          ],
        ),
      ),
    );
  }
}