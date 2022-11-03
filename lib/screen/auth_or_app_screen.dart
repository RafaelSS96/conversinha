import 'package:conversinha/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '../core/models/chat_user.dart';
import '../core/services/auth/auth_service.dart';
import '../screen/auth_screen.dart';
import '../screen/chat_page.dart';
import '../screen/loading_screen.dart';

class AuthOrAppScreen extends StatelessWidget {
  const AuthOrAppScreen({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
    await Provider.of<ChatNotificationService>(
      context,
      listen: false,
    ).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else {
          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              } else {
                return snapshot.hasData ? const ChatPage() : const AuthScreen();
              }
            },
          );
        }
      },
    );
  }
}
