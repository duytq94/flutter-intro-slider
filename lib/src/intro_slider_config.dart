import 'package:flutter/material.dart';

enum TypeIndicatorAnimation { sizeTransition, sliding }

enum ScrollbarBehavior { hide, show, alwaysShow }

enum NavPosition { top, bottom }

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

class IndicatorConfig {
  /// Show or hide indicator
  final bool? isShowIndicator;

  /// Color indicator when passive
  final Color? colorIndicator;

  /// Color indicator when active (focusing)
  final Color? colorActiveIndicator;

  /// Size of each indicator
  final double? sizeIndicator;

  /// Space between every indicator
  final double? spaceBetweenIndicator;

  /// Type indicator animation
  final TypeIndicatorAnimation? typeIndicatorAnimation;

  /// Custom indicator
  final Widget? indicatorWidget;

  /// Custom active (focusing) indicator
  final Widget? activeIndicatorWidget;

  const IndicatorConfig({
    this.isShowIndicator,
    this.colorIndicator,
    this.colorActiveIndicator,
    this.sizeIndicator,
    this.spaceBetweenIndicator,
    this.typeIndicatorAnimation,
    this.indicatorWidget,
    this.activeIndicatorWidget,
  })  : assert(sizeIndicator == null || sizeIndicator >= 0),
        assert(spaceBetweenIndicator == null || spaceBetweenIndicator >= 0);
}
