// Salin semua kode ini ke lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'scan_screen.dart'; // [cite: 161]

class HomeScreen extends StatelessWidget { // [cite: 163]
  const HomeScreen({super.key}); // [cite: 164]

  @override
  Widget build(BuildContext context) { // [cite: 169]
    return Scaffold( // [cite: 178]
      appBar: AppBar(title: const Text('Menu Utama')), // [cite: 179]
      body: Center( // [cite: 179]
        child: ElevatedButton( // [cite: 180]
          onPressed: () { // [cite: 181]
            Navigator.push( // [cite: 182]
              context,
              MaterialPageRoute(builder: (context) => const ScanScreen()), // [cite: 184, 185]
            );
          },
          child: const Text('Mulai Scan Teks'), // [cite: 193]
        ),
      ),
    );
  }
}