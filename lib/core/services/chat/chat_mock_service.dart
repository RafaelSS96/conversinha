import 'dart:math';
import 'dart:async';
import '/core/models/chat_message.dart';
import '/core/models/chat_user.dart';
import '/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msg = [
    ChatMessage(
      id: '1',
      text: 'BOM DIA SOCIEDADE DO ANEL',
      createdAt: DateTime.now(),
      userId: '123',
      username: 'Grande homossexual peludo',
      userURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'SAI COM UM ANJO ONTEM, MUITO BOM.',
      createdAt: DateTime.now().add(const Duration(seconds: 7)),
      userId: '1123',
      username: 'Timido demais pra se assumir',
      userURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'PAI, COMPRA LEITE PRA MIM HJ.',
      createdAt: DateTime.now().add(const Duration(seconds: 15)),
      userId: '4536',
      username: 'XX_SUPERMATADOR_VIMTECOMERSEUOTARIO_PEIDANXEREQUINHA_XX_33',
      userURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '4',
      text: 'Vcs são muito doentes.',
      createdAt: DateTime.now().add(const Duration(seconds: 20)),
      userId: '1',
      username: 'ADM?',
      userURL: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_msg);
  });

  Stream<List<ChatMessage>> messageStream() {
    return _msgStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      username: user.name,
      userURL: user.imageURL,
    );
    _msg.add(newMessage);
    _controller?.add(_msg.reversed.toList());
    return newMessage;
  }
}
