import 'package:flutter/material.dart';
import 'package:intro_slider_example/intro_screen_custom_config.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IntroScreenCustomConfig(),
      // home: IntroScreenCustomTab(),
      // home: IntroScreenDefault(),
      debugShowCheckedModeBanner: false,
    );
  }
}
