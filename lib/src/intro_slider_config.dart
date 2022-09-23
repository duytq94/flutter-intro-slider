enum TypeIndicatorAnimation { sizeTransition, sliding }

enum ScrollbarBehavior { hide, show, alwaysShow }

// Indicators & next/done/skip buttons position
enum IntroSliderNavPosition { top, bottom }

abstract class IntroSliderConfig {
  IntroSliderConfig._();

  static const List<String> rtlLanguages = <String>[
    'ar', // Arabic
    'fa', // Farsi
    'he', // Hebrew
    'ps', // Pashto
    'ur', // Urdu
  ];
}
