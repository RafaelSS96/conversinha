import '/core/services/chat/chat_firebase_service.dart';

import '/core/models/chat_message.dart';
import '/core/models/chat_user.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messageStream();
  Future<ChatMessage?> save(String text, ChatUser user);

  factory ChatService () {
    return ChatFirebaseService();
  }
}
