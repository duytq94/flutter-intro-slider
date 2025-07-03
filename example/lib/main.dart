import 'package:flutter/material.dart';

import 'intro_screen_custom_config.dart';
import 'intro_screen_custom_layout.dart';
import 'intro_screen_default.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const type = IntroScreenType.customConfig;
    return MaterialApp(
      home: switch (type) {
        IntroScreenType.defaultConfig => const IntroScreenDefault(),
        IntroScreenType.customConfig => const IntroScreenCustomConfig(),
        IntroScreenType.customLayout => const IntroScreenCustomLayout(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

enum IntroScreenType {
  defaultConfig,
  customConfig,
  customLayout,
}
