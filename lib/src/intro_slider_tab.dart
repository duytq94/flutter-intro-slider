import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroSliderTab extends StatelessWidget {
  const IntroSliderTab({
    super.key,
    required this.scrollController,
    required this.navPosition,
    required this.verticalScrollbarBehavior,

    // Title
    this.widgetTitle,
    this.title,
    this.maxLineTitle,
    this.styleTitle,
    this.textAlignTitle,
    this.textOverFlowTitle,
    this.marginTitle,

    // Description
    this.widgetDescription,
    this.description,
    this.maxLineTextDescription,
    this.styleDescription,
    this.textAlignDescription,
    this.textOverFlowDescription,
    this.marginDescription,

    // Image
    this.pathImage,
    this.widthImage,
    this.heightImage,
    this.foregroundImageFit,

    // Center Widget
    this.centerWidget,
    this.onCenterItemPress,

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
  });

  final ScrollController scrollController;
  final IntroSliderNavPosition navPosition;
  final ScrollbarBehavior verticalScrollbarBehavior;

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

  @override
  Widget build(BuildContext context) {
    final listView = ListView(
      controller: scrollController,
      children: <Widget>[
        Container(
          // Title
          margin: marginTitle ?? const EdgeInsets.only(top: 70.0, bottom: 50.0, left: 20.0, right: 20.0),
          child: widgetTitle ??
              Text(
                title ?? '',
                style: styleTitle ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                maxLines: maxLineTitle ?? 1,
                textAlign: textAlignTitle ?? TextAlign.center,
                overflow: textOverFlowTitle ?? TextOverflow.ellipsis,
              ),
        ),

        // Image or Center widget
        GestureDetector(
          onTap: onCenterItemPress,
          child: pathImage != null
              ? Image.asset(
                  pathImage!,
                  width: widthImage ?? 200.0,
                  height: heightImage ?? 200.0,
                  fit: foregroundImageFit ?? BoxFit.contain,
                )
              : Center(child: centerWidget ?? const SizedBox.shrink()),
        ),

        // Description
        Container(
          margin: marginDescription ?? const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          child: widgetDescription ??
              Text(
                description ?? '',
                style: styleDescription ?? const TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: textAlignDescription ?? TextAlign.center,
                maxLines: maxLineTextDescription ?? 100,
                overflow: textOverFlowDescription ?? TextOverflow.ellipsis,
              ),
        ),
      ],
    );
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: backgroundImage == null && backgroundNetworkImage == null
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: backgroundColor != null
                    ? [backgroundColor!, backgroundColor!]
                    : [
                        colorBegin ?? Colors.transparent,
                        colorEnd ?? Colors.transparent,
                      ],
                begin: directionColorBegin ?? Alignment.topLeft,
                end: directionColorEnd ?? Alignment.bottomRight,
              ),
            )
          : BoxDecoration(
              image: DecorationImage(
              image: backgroundImage != null
                  ? AssetImage(backgroundImage!)
                  : NetworkImage(backgroundNetworkImage!) as ImageProvider,
              fit: backgroundImageFit ?? BoxFit.cover,
              colorFilter: ColorFilter.mode(
                backgroundOpacityColor != null
                    ? backgroundOpacityColor!.withOpacity(backgroundOpacity ?? 0.5)
                    : Colors.black.withOpacity(backgroundOpacity ?? 0.5),
                backgroundBlendMode ?? BlendMode.darken,
              ),
            )),
      child: Container(
        margin: EdgeInsets.only(
          top: navPosition == IntroSliderNavPosition.top ? 60 : 0,
          bottom: navPosition == IntroSliderNavPosition.bottom ? 60 : 0,
        ),
        child: verticalScrollbarBehavior != ScrollbarBehavior.hide
            ? Platform.isIOS
                ? CupertinoScrollbar(
                    controller: scrollController,
                    thumbVisibility: verticalScrollbarBehavior == ScrollbarBehavior.alwaysShow,
                    child: listView,
                  )
                : Scrollbar(
                    controller: scrollController,
                    thumbVisibility: verticalScrollbarBehavior == ScrollbarBehavior.alwaysShow,
                    child: listView,
                  )
            : listView,
      ),
    );
  }
}
