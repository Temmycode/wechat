import 'package:flutter/material.dart';

class WeChat extends StatelessWidget {
  const WeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WEChat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Container(),
    );
  }
}
