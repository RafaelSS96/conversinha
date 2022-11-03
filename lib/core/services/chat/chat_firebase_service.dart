import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/core/models/chat_message.dart';
import '/core/models/chat_user.dart';
import '/core/services/chat/chat_service.dart';

class ChatFirebaseService implements ChatService {
  Stream<List<ChatMessage>> messageStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .orderBy("createdAt", descending: true)
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final msg = ChatMessage(
      id: "",
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      username: user.name,
      userURL: user.imageURL,
    );

    final chatRef = await store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(msg);

    final doc = await chatRef.get();
    return doc.data()!;
  }

  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    // print(" doc.id : ${doc["userId"]}");
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      username: doc['username'],
      userURL: doc['userURL'],
    );
  }

  Map<String, dynamic> _toFirestore(
    ChatMessage msg,
    SetOptions? options,
  ) {
    return {
      'text': msg.text,
      'createdAt': msg.createdAt.toIso8601String(),
      'userId': msg.userId,
      'username': msg.username,
      'userURL': msg.userURL,
    };
  }
}
