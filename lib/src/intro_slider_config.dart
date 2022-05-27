// Type dots animation
enum DotSliderAnimation { SIZE_TRANSITION, DOT_MOVEMENT }

// Scrollbar behavior values
enum ScrollbarBehavior { HIDE, SHOW, SHOW_ALWAYS }

// Dots and next/done/skip buttons position
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
