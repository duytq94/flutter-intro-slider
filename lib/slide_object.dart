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

  // Custom your center widget instead of image (if this widget exist, center image will hide)
  Widget? centerWidget;

  //endregion

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
    Widget? widgetTitle,
    String? title,
    int? maxLineTitle,
    TextStyle? styleTitle,
    EdgeInsets? marginTitle,

    // Image (if specified centerWidget is not displayed)
    String? pathImage,
    double? widthImage,
    double? heightImage,
    BoxFit? foregroundImageFit,

    // Center widget
    Widget? centerWidget,
    Function? onCenterItemPress,

    // Description
    Widget? widgetDescription,
    String? description,
    int? maxLineTextDescription,
    TextStyle? styleDescription,
    EdgeInsets? marginDescription,

    // Background color
    Color? backgroundColor,
    Color? colorBegin,
    Color? colorEnd,
    AlignmentGeometry? directionColorBegin,
    AlignmentGeometry? directionColorEnd,

    // Background image
    String? backgroundImage,
    BoxFit? backgroundImageFit,
    double? backgroundOpacity,
    Color? backgroundOpacityColor,
    BlendMode? backgroundBlendMode,
  }) {
    // Title
    this.widgetTitle = widgetTitle;
    this.title = title;
    this.maxLineTitle = maxLineTitle;
    this.styleTitle = styleTitle;
    this.marginTitle = marginTitle;

    // Image
    this.pathImage = pathImage;
    this.widthImage = widthImage;
    this.heightImage = heightImage;
    this.foregroundImageFit = foregroundImageFit;

    // Center widget
    this.centerWidget = centerWidget;
    this.onCenterItemPress = onCenterItemPress;

    // Description
    this.widgetDescription = widgetDescription;
    this.description = description;
    this.maxLineTextDescription = maxLineTextDescription;
    this.styleDescription = styleDescription;
    this.marginDescription = marginDescription;

    // Background color
    this.backgroundColor = backgroundColor;
    this.colorBegin = colorBegin;
    this.colorEnd = colorEnd;
    this.directionColorBegin = directionColorBegin;
    this.directionColorEnd = directionColorEnd;

    // background image
    this.backgroundImage = backgroundImage;
    this.backgroundImageFit = backgroundImageFit;
    this.backgroundOpacity = backgroundOpacity;
    this.backgroundOpacityColor = backgroundOpacityColor;
    this.backgroundBlendMode = backgroundBlendMode;
  }
}
