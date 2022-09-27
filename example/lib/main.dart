import 'package:flutter/material.dart';

import 'intro_screen_custom_config.dart';
import 'intro_screen_custom_layout.dart';
import 'intro_screen_default.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IntroScreenCustomConfig(),
      // home: IntroScreenCustomLayout(),
      // home: IntroScreenDefault(),
      debugShowCheckedModeBanner: false,
    );
  }
}
