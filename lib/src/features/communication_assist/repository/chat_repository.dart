// repository/chat_repository.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sencees/src/features/communication_assist/models/chat_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sencees/src/core/constants/app_urls.dart';

class ChatRepo {
  Future<ChatResponse> sendMessage(String sessionId, String userMessage) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("accessToken");
    print(sessionId);
    print(userMessage);
    print(accessToken);

    final response = await http.post(
      Uri.parse('${BASE_URL}chat'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'session_id': sessionId,
        'user_message': userMessage,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = response.body;
      print(responseBody);

      if (responseBody.isEmpty) {
        throw Exception('Empty response body');
      }

      // Try to decode the response body
      try {
        final jsonResponse = jsonDecode(responseBody);
        return ChatResponse.fromJson(jsonResponse);
      } catch (e) {
        throw Exception('Failed to decode response: $e');
      }
    } else {
      throw Exception(
          'Failed to send message, status code: ${response.statusCode}');
    }
  }
}

final chatRepositoryProvider = Provider((ref) => ChatRepo());
