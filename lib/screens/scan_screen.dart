// Salin semua kode ini ke lib/screens/scan_screen.dart
import 'dart:io'; // [cite: 205]
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // [cite: 207]
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'; // [cite: 208]
// import 'package:path/path.dart as path; // Tidak terpakai di kode ini
// import 'package:path_provider/path_provider.dart'; // Tidak terpakai di kode ini
import 'result_screen.dart'; // [cite: 212]

late List<CameraDescription> cameras; // [cite: 214]

class ScanScreen extends StatefulWidget { // [cite: 215]
  const ScanScreen({super.key}); // [cite: 216]

  @override
  State<ScanScreen> createState() => _ScanScreenState(); // [cite: 218]
}

class _ScanScreenState extends State<ScanScreen> { // [cite: 228]
  late CameraController _controller; // [cite: 227, 229] (digabung)
  late Future<void> _initializeControllerFuture; // [cite: 232]
  bool _isCameraInitialized = false;

  @override
  void initState() { // [cite: 237]
    super.initState();
    initCamera(); // [cite: 241]
  }

  void initCamera() async { // [cite: 247]
    cameras = await availableCameras(); // [cite: 249]
    _controller = CameraController(cameras[0], ResolutionPreset.medium); // [cite: 251, 252]
    _initializeControllerFuture = _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isCameraInitialized = true; // Tandai bahwa kamera siap
        });
      }
    }).catchError((Object e) {
      if (e is CameraException) {
        // Handle error
        print('Error initializing camera: ${e.description}');
      }
    });
  }

  @override
  void dispose() { // [cite: 268]
    _controller.dispose(); // [cite: 270]
    super.dispose();
  }

  Future<String> _ocrFromFile(File imageFile) async { // [cite: 279]
    final inputImage = InputImage.fromFile(imageFile); // [cite: 279]
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin); // [cite: 280, 281]
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage); // [cite: 282, 283]
    textRecognizer.close(); // [cite: 284]
    return recognizedText.text; // [cite: 285]
  }

  Future<void> _takePicture() async { // [cite: 296]
    try {
      await _initializeControllerFuture; // [cite: 298]
      if (!mounted) return; // [cite: 299]

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Memproses OCR, mohon tunggu...'), // [cite: 303]
            duration: Duration(seconds: 2)),
      );

      final XFile image = await _controller.takePicture(); // [cite: 306]
      final String ocrText = await _ocrFromFile(File(image.path)); // [cite: 309]

      if (!mounted) return; // [cite: 312]

      Navigator.push( // [cite: 314]
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(ocrText: ocrText)), // [cite: 318, 319]
      );
    } catch (e) { // [cite: 323]
      if (!mounted) return; // [cite: 325]
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Pemindaian Gagal! Periksa Izin Kamera atau coba lagi.'), // [cite: 45]
      ));
    }
  }

  @override
  Widget build(BuildContext context) { // [cite: 334]
    if (!_isCameraInitialized) { // [cite: 335] (modifikasi)
      return Scaffold(
      backgroundColor: Colors.grey[900], // [cite: 40]
        body: Center( // [cite: 41]
          child: Column( // [cite:  
          mainAxisAlignment: MainAxisAlignment.center, // Agar rapi di tengah
          children: [
              CircularProgressIndicator(color: Colors.yellow), // [cite: 41]
              const SizedBox(height: 20), // Memberi jarak
              const Text( // [cite: 42]
              'Memuat Kamera... Harap tunggu.',
              style: TextStyle(color: Colors.white, fontSize: 18), // [cite: 42]
            ),
            ],
          ),
        ),
      );
    }
    return Scaffold( // [cite: 342]
      appBar: AppBar(title: const Text('Kamera OCR')), // [cite: 343]
      body: Column( // [cite: 344]
        children: [
          Expanded( // [cite: 348]
            child: AspectRatio( // [cite: 352]
              aspectRatio: _controller.value.aspectRatio, // [cite: 353, 354]
              child: CameraPreview(_controller), // [cite: 355]
            ),
          ),
          Padding( // [cite: 364]
            padding: const EdgeInsets.all(16.0), // [cite: 365]
            child: ElevatedButton.icon( // [cite: 366]
              onPressed: _takePicture, // [cite: 367] (diganti ke _takePicture)
              icon: const Icon(Icons.camera), // [cite: 386]
              label: const Text('Ambil Foto & Scan'), // [cite: 387]
            ),
          ),
        ],
      ),
    );
  }
}