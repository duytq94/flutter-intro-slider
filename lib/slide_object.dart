import 'package:flutter/material.dart';

class Slide {
  // Title widget
  /// If non-null, used instead of [title] and its relevant properties
  Widget? widgetTitle;

  // Title
  /// Change text title at top
  String? title;

  /// Change max number of lines title at top
  int? maxLineTitle;

  /// Style for text title
  TextStyle? styleTitle;

  /// Margin for text title
  EdgeInsets? marginTitle;

  // Image
  /// Path to your local image
  String? pathImage;

  /// Width of image
  double? widthImage;

  /// Height of image
  double? heightImage;

  /// Scale of image
  BoxFit? foregroundImageFit;

  /// Fire when press image or center widget
  Function? onCenterItemPress;

  // Custom center widget that replaces image
  Widget? centerWidget;

  // Description widget
  /// If non-null, used instead of [description] and its relevant properties
  Widget? widgetDescription;

  // Description
  /// Change text description at bottom
  String? description;

  /// Maximum line of text description
  int? maxLineTextDescription;

  /// Style for text description
  TextStyle? styleDescription;

  /// Margin for text description
  EdgeInsets? marginDescription;

  // Background color
  /// Background tab color
  Color? backgroundColor;

  /// Gradient tab color begin
  Color? colorBegin;

  /// Gradient tab color end
  Color? colorEnd;

  /// Direction color begin
  AlignmentGeometry? directionColorBegin;

  /// Direction color end
  AlignmentGeometry? directionColorEnd;

  // Background image
  String? backgroundImage;
  BoxFit? backgroundImageFit;
  double? backgroundOpacity;
  Color? backgroundOpacityColor;
  BlendMode? backgroundBlendMode;

  Slide({
    // Title
    this.widgetTitle,
    this.title,
    this.maxLineTitle,
    this.styleTitle,
    this.marginTitle,

    // Image
    this.pathImage,
    this.widthImage,
    this.heightImage,
    this.foregroundImageFit,

    // Center widget
    this.centerWidget,
    this.onCenterItemPress,

    // Description
    this.widgetDescription,
    this.description,
    this.maxLineTextDescription,
    this.styleDescription,
    this.marginDescription,

    // Background color
    this.backgroundColor,
    this.colorBegin,
    this.colorEnd,
    this.directionColorBegin,
    this.directionColorEnd,

    // background image
    this.backgroundImage,
    this.backgroundImageFit,
    this.backgroundOpacity,
    this.backgroundOpacityColor,
    this.backgroundBlendMode,
  });
}
