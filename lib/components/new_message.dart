import 'package:conversinha/core/services/auth/auth_service.dart';
import 'package:conversinha/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      // final teste = 
      await ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
                controller: _messageController,
                onChanged: (msg) => setState(() => _message = msg),
                decoration: const InputDecoration(
                  labelText: 'Enviar mensagem.',
                ),
                onSubmitted: (_) {
                  if (_message.trim().isNotEmpty) {
                    _sendMessage();
                  }
                }),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: _message.trim().isEmpty ? null : _sendMessage,
        ),
      ],
    );
  }
}
