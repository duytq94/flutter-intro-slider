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

class PairIndicatorMargin<T1, T2> {
  final double left;
  final double right;

  PairIndicatorMargin(this.left, this.right);
}

class PairIndicatorDecoration<T1, T2> {
  final List<double> size;
  final List<double> opacity;

  PairIndicatorDecoration(this.size, this.opacity);
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

class ContentConfig {
  // ---------- Title ----------
  /// Change text title at top
  final String? title;

  /// Set a custom widget as the title (ignore `title` if define both)
  final Widget? widgetTitle;

  /// Change max number of lines title at top
  final int? maxLineTitle;

  /// Style for text title
  final TextStyle? styleTitle;

  /// TextAlign for text title
  final TextAlign? textAlignTitle;

  /// TextOverflow for text title
  final TextOverflow? textOverFlowTitle;

  /// Margin for text title
  final EdgeInsets? marginTitle;

  // ---------- Image ----------
  /// Path to your local image
  final String? pathImage;

  /// Width of image
  final double? widthImage;

  /// Height of image
  final double? heightImage;

  /// Foreground image fit
  final BoxFit? foregroundImageFit;

  // ---------- Center Widget ----------
  /// Your custom's widget
  final Widget? centerWidget;

  /// Fire when press center image/widge
  final void Function()? onCenterItemPress;

  // ---------- Description ----------
  /// Change text description at bottom
  final String? description;

  ///  Set a custom widget as the description (ignore `description` if define both)
  final Widget? widgetDescription;

  /// Maximum line of text description
  final int? maxLineTextDescription;

  /// Style for text description
  final TextStyle? styleDescription;

  /// TextAlign for text description
  final TextAlign? textAlignDescription;

  /// TextOverflow for text description
  final TextOverflow? textOverFlowDescription;

  /// Margin for text description
  final EdgeInsets? marginDescription;

  // ---------- Background color ----------
  /// Background tab color (if set, will ignore gradient properties below)
  final Color? backgroundColor;

  /// Gradient tab color begin
  final Color? colorBegin;

  /// Gradient tab color end
  final Color? colorEnd;

  /// Direction color begin
  final AlignmentGeometry? directionColorBegin;

  /// Direction color end
  final AlignmentGeometry? directionColorEnd;

  // ---------- Background image ----------
  /// Set image for background (if set, will ignore all parameter at `Background Color` above)
  final String? backgroundImage;

  /// Set image (from network) for background
  final String? backgroundNetworkImage;

  /// Background image fit
  final BoxFit? backgroundImageFit;

  /// A color filter to apply to the image background before painting it
  final Color? backgroundFilterColor;

  /// Opacity for `backgroundFilterColor`
  final double? backgroundFilterOpacity;

  /// Background blend mode
  final BlendMode? backgroundBlendMode;

  /// Allow to specify how the vertical scrollbar should behave
  /// (scroll enable when content length is greater than screen length)
  final ScrollbarBehavior? verticalScrollbarBehavior;

  const ContentConfig({
    // ---------- Title ----------
    this.widgetTitle,
    this.title,
    this.maxLineTitle,
    this.styleTitle,
    this.textAlignTitle,
    this.textOverFlowTitle,
    this.marginTitle,

    // ---------- Image ----------
    this.pathImage,
    this.widthImage,
    this.heightImage,
    this.foregroundImageFit,

    // ---------- Center Widget ----------
    this.centerWidget,
    this.onCenterItemPress,

    // ---------- Description ----------
    this.widgetDescription,
    this.description,
    this.maxLineTextDescription,
    this.styleDescription,
    this.textAlignDescription,
    this.textOverFlowDescription,
    this.marginDescription,

    // ---------- Background color ----------
    this.backgroundColor,
    this.colorBegin,
    this.colorEnd,
    this.directionColorBegin,
    this.directionColorEnd,

    // ---------- Background image ----------
    this.backgroundImage,
    this.backgroundImageFit,
    this.backgroundNetworkImage,
    this.backgroundFilterOpacity,
    this.backgroundFilterColor,
    this.backgroundBlendMode,
    this.verticalScrollbarBehavior,
  });
}

class NavigationBarConfig {
  /// Padding
  EdgeInsets padding;

  /// Move navigation bar to top or bottom page
  NavPosition navPosition;

  /// Background color
  Color backgroundColor;

  NavigationBarConfig({
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.navPosition = NavPosition.bottom,
    this.backgroundColor = Colors.transparent,
  });
}
