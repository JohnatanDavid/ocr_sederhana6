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
        child: Padding( // [cite: 180]
          padding: const EdgeInsets.all(16.0),
    child: ListTile(
      leading: Icon(Icons.camera_alt, color: Colors.blue), // [cite: 20]
      title: Text('Mulai Pindai Teks Baru'), // [cite: 20]
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      onTap: () { // [cite: 181]
            Navigator.push( // [cite: 182]
              context,
              MaterialPageRoute(builder: (context) => const ScanScreen()), // [cite: 184, 185]
            );
            },
          ),
        ),
      ),
    ); // 
  }
}