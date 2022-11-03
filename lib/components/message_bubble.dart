import 'dart:io';

import 'package:conversinha/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key, required this.message, required this.belongsToCurrentUser})
      : super(key: key);

  final ChatMessage message;
  final bool belongsToCurrentUser;
  static const _defaultImage = 'assets/images/avatar.png';

  Widget _showUserImage(String imageIRL) {
    ImageProvider? provider;
    final uri = Uri.parse(imageIRL);

    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains("http")) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: belongsToCurrentUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Colors.grey.shade300
                    : Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: belongsToCurrentUser
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: belongsToCurrentUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Column(
                children: [
                  Text(
                    message.username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: belongsToCurrentUser ? Colors.black : Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(message.text,
                      style: TextStyle(
                          color: belongsToCurrentUser
                              ? Colors.black
                              : Colors.white),
                      textAlign: belongsToCurrentUser
                          ? TextAlign.right
                          : TextAlign.left),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 165,
          right: belongsToCurrentUser ? 165 : null,
          child: _showUserImage(message.userURL),
        ),
      ],
    );
  }
}
