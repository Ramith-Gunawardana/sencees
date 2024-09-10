import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:flutter/services.dart';
import 'dart:typed_data';

class CommunicationAnalyzerView extends StatefulWidget {
  const CommunicationAnalyzerView({super.key});

  @override
  _CommunicationAnalyzerViewState createState() =>
      _CommunicationAnalyzerViewState();
}

class _CommunicationAnalyzerViewState extends State<CommunicationAnalyzerView> {
  double result = 0.0;

  // Function to load the audio file and run the model on it
  Future<void> runModelOnAudio() async {

    
    final interpreter = await tfl.Interpreter.fromAsset(
        'assets/models/CNN-LSTM_best_model.tflite');

    // Load the audio file from assets
    ByteData audioData = await rootBundle.load('assets/audio/sample_audio.wav');

    // Preprocess the audio data here (e.g., convert to MFCCs or other features)
    Uint8List audioBytes = audioData.buffer.asUint8List();

    // Prepare the input in the shape expected by your model
    // This will vary depending on the model, but let's assume a simple input
    final input = [audioBytes]; // Replace this with actual input structure

    var output = List.filled(1, 0).reshape([1, 1]);

    // Run the model on the processed audio data
    interpreter.run(input, output);

    setState(() {
      result = output[0][0];
    });

    print(output); // Output from the model
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade700,
          title: const Text("Audio Model Predictor"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: MaterialButton(
                color: Colors.black,
                child: const Text('Process Audio'),
                onPressed: () {
                  runModelOnAudio();
                },
              ),
            ),
            Text(
              result.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
