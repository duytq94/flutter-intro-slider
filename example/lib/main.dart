import 'package:flutter/material.dart';
import 'package:intro_slider_example/intro_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IntroScreen(),
      // home: IntroScreenCustom(),
      // home: IntroScreenDefault(),
      debugShowCheckedModeBanner: false,
    );
  }
}
