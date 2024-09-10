import 'dart:convert';

class ChatResponse {
  final String input;
  final List<String> answer;
  final List<ChatMessage> chatHistory;

  ChatResponse({
    required this.input,
    required this.answer,
    required this.chatHistory,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      input: json['input'],
      answer: List<String>.from(
          jsonDecode(json['answer']).map((item) => item.toString())),
      chatHistory: List<ChatMessage>.from(
        json['chat_history'].map((x) => ChatMessage.fromJson(x)),
      ),
    );
  }
}

class ChatMessage {
  final String content;
  final String type;

  ChatMessage({
    required this.content,
    required this.type,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      content: json['content'],
      type: json['type'],
    );
  }
}
