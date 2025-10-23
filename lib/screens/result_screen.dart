import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget { // [cite: 391]
  final String ocrText; // [cite: 392]

  const ResultScreen({super.key, required this.ocrText}); // [cite: 394]

  @override
  Widget build(BuildContext context) { // [cite: 399]
    return Scaffold( // [cite: 410]
      appBar: AppBar(title: const Text('Hasil OCR')), // [cite: 411]
      body: Padding( // [cite: 411]
        padding: const EdgeInsets.all(16.0), // [cite: 412]
        child: SingleChildScrollView( // [cite: 412]
          child: SelectableText( // [cite: 413]
            ocrText.isEmpty
                ? 'Tidak ada teks ditemukan.' // [cite: 415]
                : ocrText, // [cite: 416] (penghapusan \n saya hilangkan agar format asli terbaca)
            style: const TextStyle(fontSize: 18), // [cite: 417]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Kembali ke HomeScreen dan hapus semua rute di atasnya
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false, // Ini akan menghapus semua stack
          );
        },
        tooltip: 'Kembali ke Home',
        child: const Icon(Icons.home), // Ikon home sesuai instruksi
      ),
    );
  }
}