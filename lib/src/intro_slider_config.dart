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
}

class ContentConfig {
  const ContentConfig({
    // Title
    this.widgetTitle,
    this.title,
    this.maxLineTitle,
    this.styleTitle,
    this.textAlignTitle,
    this.textOverFlowTitle,
    this.marginTitle,

    // Image
    this.pathImage,
    this.widthImage,
    this.heightImage,
    this.foregroundImageFit,

    // Center Widget
    this.centerWidget,
    this.onCenterItemPress,

    // Description
    this.widgetDescription,
    this.description,
    this.maxLineTextDescription,
    this.styleDescription,
    this.textAlignDescription,
    this.textOverFlowDescription,
    this.marginDescription,

    // Background color
    this.backgroundColor,
    this.colorBegin,
    this.colorEnd,
    this.directionColorBegin,
    this.directionColorEnd,

    // Background image
    this.backgroundImage,
    this.backgroundImageFit,
    this.backgroundNetworkImage,
    this.backgroundOpacity,
    this.backgroundOpacityColor,
    this.backgroundBlendMode,
    this.verticalScrollbarBehavior,
  });

  // Title
  final Widget? widgetTitle;
  final String? title;
  final int? maxLineTitle;
  final TextStyle? styleTitle;
  final TextAlign? textAlignTitle;
  final TextOverflow? textOverFlowTitle;
  final EdgeInsets? marginTitle;

  // Description
  final Widget? widgetDescription;
  final String? description;
  final int? maxLineTextDescription;
  final TextStyle? styleDescription;
  final TextAlign? textAlignDescription;
  final TextOverflow? textOverFlowDescription;
  final EdgeInsets? marginDescription;

  // Image
  final String? pathImage;
  final double? widthImage;
  final double? heightImage;
  final BoxFit? foregroundImageFit;

  // Center Widget
  final Widget? centerWidget;
  final void Function()? onCenterItemPress;

  // Background color
  final Color? backgroundColor;
  final Color? colorBegin;
  final Color? colorEnd;
  final AlignmentGeometry? directionColorBegin;
  final AlignmentGeometry? directionColorEnd;

  // Background image
  final String? backgroundImage;
  final BoxFit? backgroundImageFit;
  final String? backgroundNetworkImage;
  final double? backgroundOpacity;
  final Color? backgroundOpacityColor;
  final BlendMode? backgroundBlendMode;

  final ScrollbarBehavior? verticalScrollbarBehavior;
}

class NavigationBarConfig {
  EdgeInsets padding;
  NavPosition navPosition;
  Color backgroundColor;

  NavigationBarConfig({
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.navPosition = NavPosition.bottom,
    this.backgroundColor = Colors.transparent,
  });
}
