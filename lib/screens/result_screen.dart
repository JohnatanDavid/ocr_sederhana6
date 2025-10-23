import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ResultScreen extends StatefulWidget { // [cite: 391]
  final String ocrText; // [cite: 392]

  const ResultScreen({super.key, required this.ocrText}); 
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _speak() async {
  if (widget.ocrText.isNotEmpty) {
    await flutterTts.speak(widget.ocrText); // 
  }
}
 // [cite: 394]
  @override
void initState() {
  super.initState();
  _initTts(); // Panggil fungsi inisialisasi
}

// Buat fungsi baru untuk inisialisasi
void _initTts() async {
  await flutterTts.setLanguage("id-ID"); // Set bahasa ke Indonesia 
  await flutterTts.setSpeechRate(0.5); // Atur kecepatan (opsional, 0.5 = normal)
  await flutterTts.setPitch(1.0); // Atur nada (opsional, 1.0 = normal)
}
@override
void dispose() {
  flutterTts.stop(); // Hentikan TTS 
  super.dispose();
}
  @override
  Widget build(BuildContext context) { // [cite: 399]
    return Scaffold( // [cite: 410]
      appBar: AppBar(title: const Text('Hasil OCR')), // [cite: 411]
      body: Padding( // [cite: 411]
        padding: const EdgeInsets.all(16.0), // [cite: 412]
        child: SingleChildScrollView( // [cite: 412]
          child: SelectableText( // [cite: 413]
            widget.ocrText.isEmpty
                ? 'Tidak ada teks ditemukan.' // [cite: 415]
                : widget.ocrText, // [cite: 416] (penghapusan \n saya hilangkan agar format asli terbaca)
            style: const TextStyle(fontSize: 18), // [cite: 417]
          ),
        ),
      ),
      floatingActionButton: Column( // Bungkus dengan Column
        mainAxisAlignment: MainAxisAlignment.end, // Agar tetap di bawah
        children: [
          // FAB UNTUK TTS (BARU)
        FloatingActionButton(
          onPressed: _speak, // Panggil fungsi 
          tooltip: 'Bacakan Teks',
          child: const Icon(Icons.volume_up), // Ikon sesuai instruksi [cite: 62]
          ),

          const SizedBox(height: 16), // Beri jarak antar tombol

          // FAB UNTUK HOME (YANG LAMA)
          FloatingActionButton(
            onPressed: () {
              // Kembali ke HomeScreen dan hapus semua rute di atasnya
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false, // Ini akan menghapus semua stack
                );
                },
            tooltip: 'Kembali ke Home',
            child: const Icon(Icons.home), // [cite: 28]
            ),
          ],
        ),
      );
    }
  }