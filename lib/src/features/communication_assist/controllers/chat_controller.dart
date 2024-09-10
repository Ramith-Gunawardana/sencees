// controllers/chat_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sencees/src/features/communication_assist/models/chat_message.dart';
import 'package:sencees/src/features/communication_assist/repository/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository);
});

class ChatController {
  final ChatRepo _chatRepository;

  ChatController({required ChatRepo chatRepository})
      : _chatRepository = chatRepository;

  Future<ChatResponse?> sendMessage(
      String sessionId, String userMessage) async {
    try {
      print('Controller: Sending message to API...');
      final response =
          await _chatRepository.sendMessage(sessionId, userMessage);
      print('Controller: API response received');
      return response;
    } catch (error) {
      print('Controller: API call error - $error');
      // Handle or rethrow the error if necessary
      return null;
    }
  }
}
