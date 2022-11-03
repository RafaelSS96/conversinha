import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Carregando...",
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headline6?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
