import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sencees/src/core/utils/Utils.dart';
import 'package:sencees/src/features/communication_assist/controllers/chat_controller.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CommunicationAssistView extends ConsumerStatefulWidget {
  const CommunicationAssistView({super.key});

  @override
  ConsumerState<CommunicationAssistView> createState() =>
      _CommunicationAssistView();
}

class _CommunicationAssistView extends ConsumerState<CommunicationAssistView> {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _controller = TextEditingController();

  List<Map<String, String>> messages = [];
  List<String> aiSuggestions = [];
  bool _speechEnabled = false;
  bool _speechAvailable = false;
  bool _isLoading = false;
  String _currentWords = '';
  late String uuid;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initTts();
    uuid = Utils.generateUUID();
  }

  void _initSpeech() async {
    _speechAvailable = await _speechToText.initialize(
      onError: (SpeechRecognitionError error) async {
        debugPrint(error.errorMsg.toString());
      },
      onStatus: statusListener,
    );

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

  void _sendUserMessage(String message) async {
    if (message.trim().isEmpty) return;
    setState(() {
      messages.add({'role': 'user', 'message': message});
      _isLoading = true;
      aiSuggestions = [];
    });

    final chatController = ref.read(chatControllerProvider);
    final response = await chatController.sendMessage(uuid, message);
    print("------------------------------------");
    print(response);

    setState(() {
      _isLoading = false;
      if (response?.answer != null) {
        aiSuggestions = response!.answer;
      } else {
        aiSuggestions = [];
      }
    });
  }

  void _sendAiMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      messages.add({'role': 'ai', 'message': message});
      aiSuggestions = [];
    });

    _controller.clear();
  }

  void _initTts() {
    _flutterTts.setLanguage("en-US");
    _flutterTts.setSpeechRate(0.5);
    _flutterTts.setPitch(1.0);

    // Set completion handler to restart speech recognition after TTS
    _flutterTts.setCompletionHandler(() async {
      await _startListening();
    });
  }

  Future<void> _speak(String message) async {
    // Stop speech recognition if it is active
    if (_speechEnabled) {
      await _stopListening();
    }

    // Speak the message
    await _flutterTts.speak(message);
  }

  @override
  void dispose() {
    _flutterTts.stop(); // Stop TTS when disposing
    super.dispose();
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
              itemCount: messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= messages.length) {
                  return const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: Text(
                        'AI is thinking...',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  );
                }

                final message = messages[index];
                bool isUserMessage = message['role'] == 'user';

                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: isUserMessage
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        if (!isUserMessage)
                          IconButton(
                            icon: const Icon(Icons.volume_up),
                            onPressed: () => _speak(message['message'] ?? ''),
                          ),
                        Expanded(
                          child: Text(
                            '${isUserMessage ? "User" : "AI"}: ${message['message'] ?? ''}',
                            style: TextStyle(
                              fontWeight: isUserMessage
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (aiSuggestions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                children: aiSuggestions
                    .map(
                      (suggestion) => TextButton(
                        onPressed: () => _sendAiMessage(suggestion),
                        child: Text(suggestion),
                      ),
                    )
                    .toList(),
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
                  onPressed: () => _sendAiMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
