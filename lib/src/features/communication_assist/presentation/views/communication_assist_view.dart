import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CommunicationAssistView extends StatefulWidget {
  const CommunicationAssistView({super.key});

  @override
  State<CommunicationAssistView> createState() => _CommunicationAssistView();
}

class _CommunicationAssistView extends State<CommunicationAssistView> {
  final SpeechToText _speechToText = SpeechToText();
  final TextEditingController _controller = TextEditingController();

  List<Map<String, String>> messages = [];
  bool _speechEnabled = false;
  bool _speechAvailable = false;
  String _currentWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechAvailable = await _speechToText.initialize(
        onError: (SpeechRecognitionError error) async {
          debugPrint(error.errorMsg.toString());
        },
        onStatus: statusListener);

    if (!_speechAvailable) {
      debugPrint("Speech recognition initialization failed");
    } else {
      debugPrint("Speech recognition initialized successfully");
    }

    setState(() {});
  }

  void statusListener(String status) async {
    debugPrint("status $status");
    if (status == "done" && _speechEnabled) {
      _sendUserMessage(_currentWords);
      setState(() {
        _currentWords = "";
        _speechEnabled = false;
      });

      await Future.delayed(const Duration(milliseconds: 50));
      await _startListening();
    }
  }

  Future _startListening() async {
    if (!_speechAvailable) {
      debugPrint("Speech recognition is not available.");
      return;
    }

    debugPrint("Starting speech recognition...");
    await _stopListening();
    await Future.delayed(const Duration(milliseconds: 50));

    try {
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(days: 1),
      );
      setState(() {
        _speechEnabled = true;
      });
    } catch (e) {
      debugPrint("Error starting speech recognition: $e");
    }
  }

  Future _stopListening() async {
    setState(() {
      _speechEnabled = false;
    });
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _currentWords = result.recognizedWords;
    });
  }

  void _sendUserMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      messages.add({'role': 'user', 'message': message});
    });
  }

  void _sendAiMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      messages.add({'role': 'ai', 'message': message});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication Assist'),
        actions: [
          IconButton(
            icon: Icon(
              _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
            ),
            onPressed:
                _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2, 
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message['role'] == 'user'
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: Text(
                      '${message['role'] == 'user' ? "User" : "AI"}: ${message['message'] ?? ''}',
                      style: TextStyle(
                        fontWeight: message['role'] == 'user'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type AI response...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () =>
                      _sendAiMessage(_controller.text), 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
