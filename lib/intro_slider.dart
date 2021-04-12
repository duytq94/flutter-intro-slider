import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dot_animation_enum.dart';
import 'list_rtl_language.dart';
import 'scrollbar_behavior_enum.dart';
import 'slide_object.dart';

class IntroSlider extends StatefulWidget {
  // ---------- Slides ----------
  /// An array of Slide object
  final List<Slide>? slides;

  /// Background color for all slides
  final Color? backgroundColorAllSlides;

  // ---------- SKIP button ----------
  /// Render your own SKIP button
  final Widget? renderSkipBtn;

  /// Width of view wrapper SKIP button
  final double? widthSkipBtn;

  /// Fire when press SKIP button
  final Function? onSkipPress;

  /// Change SKIP to any text you want
  final String? nameSkipBtn;

  /// Style for text at SKIP button
  final TextStyle? styleSkipBtn;

  /// Color for SKIP button
  final Color? colorSkipBtn;

  /// Color for Skip button when press
  final Color? highlightColorSkipBtn;

  /// Show or hide SKIP button
  final bool? showSkipBtn;

  /// Rounded SKIP button
  final double? borderRadiusSkipBtn;

  // ---------- PREV button ----------
  /// Render your own PREV button
  final Widget? renderPrevBtn;

  /// Width of view wrapper PREV button
  final double? widthPrevBtn;

  /// Change PREV to any text you want
  final String? namePrevBtn;

  /// Style for text at PREV button
  final TextStyle? stylePrevBtn;

  /// Color for PREV button
  final Color? colorPrevBtn;

  /// Color for PREV button when press
  final Color? highlightColorPrevBtn;

  /// Show or hide PREV button (only visible if skip is hidden)
  final bool? showPrevBtn;

  /// Rounded PREV button
  final double? borderRadiusPrevBtn;

  // ---------- NEXT button ----------
  /// Render your own NEXT button
  final Widget? renderNextBtn;

  /// Change NEXT to any text you want
  final String? nameNextBtn;

  /// Show or hide NEXT button
  final bool? showNextBtn;

  // ---------- DONE button ----------
  /// Change DONE to any text you want
  final String? nameDoneBtn;

  /// Render your own DONE button
  final Widget? renderDoneBtn;

  /// Width of view wrapper DONE button
  final double? widthDoneBtn;

  /// Fire when press DONE button
  final Function? onDonePress;

  /// Style for text at DONE button
  final TextStyle? styleDoneBtn;

  /// Color for DONE button
  final Color? colorDoneBtn;

  /// Color for DONE button when press
  final Color? highlightColorDoneBtn;

  /// Rounded DONE button
  final double? borderRadiusDoneBtn;

  /// Show or hide DONE button
  final bool? showDoneBtn;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  final bool? showDotIndicator;

  /// Color for dot when passive
  final Color? colorDot;

  /// Color for dot when active
  final Color? colorActiveDot;

  /// Size of each dot
  final double? sizeDot;

  /// Type dots animation
  final dotSliderAnimation? typeDotAnimation;

  // ---------- Tabs ----------
  /// Render your own custom tabs
  final List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  final Function? onTabChangeCompleted;

  /// Ref function go to specific tab index
  final Function? refFuncGoToTab;

  // ---------- Behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool? isScrollable;
  final ScrollPhysics? scrollPhysics;

  /// Show or hide status bar
  final bool? hideStatusBar;

  /// The way the vertical scrollbar should behave
  final scrollbarBehavior? verticalScrollbarBehavior;

  // Constructor
  IntroSlider({
    // Slides
    this.slides,
    this.backgroundColorAllSlides,

    // Skip
    this.renderSkipBtn,
    this.widthSkipBtn,
    this.onSkipPress,
    this.nameSkipBtn,
    this.styleSkipBtn,
    this.colorSkipBtn,
    this.highlightColorSkipBtn,
    this.showSkipBtn,
    this.borderRadiusSkipBtn,

    // Prev
    this.renderPrevBtn,
    this.widthPrevBtn,
    this.namePrevBtn,
    this.showPrevBtn,
    this.stylePrevBtn,
    this.colorPrevBtn,
    this.highlightColorPrevBtn,
    this.borderRadiusPrevBtn,

    // Done
    this.renderDoneBtn,
    this.widthDoneBtn,
    this.onDonePress,
    this.nameDoneBtn,
    this.colorDoneBtn,
    this.highlightColorDoneBtn,
    this.borderRadiusDoneBtn,
    this.styleDoneBtn,
    this.showDoneBtn,

    // Next
    this.renderNextBtn,
    this.nameNextBtn,
    this.showNextBtn,

    // Dots
    this.colorActiveDot,
    this.colorDot,
    this.showDotIndicator,
    this.sizeDot,
    this.typeDotAnimation,

    // Tabs
    this.listCustomTabs,
    this.onTabChangeCompleted,
    this.refFuncGoToTab,

    // Behavior
    this.isScrollable,
    this.scrollPhysics,
    this.hideStatusBar,
    this.verticalScrollbarBehavior,
  });

  @override
  IntroSliderState createState() => IntroSliderState();
}

class IntroSliderState extends State<IntroSlider>
    with SingleTickerProviderStateMixin {
  /// Default values
  static TextStyle defaultBtnNameTextStyle =
      const TextStyle(color: Colors.white);

  static double defaultBtnBorderRadius = 30.0;

  static Color defaultBtnColor = Colors.transparent;

  // ---------- Slides ----------
  /// An array of Slide object
  late final List<Slide>? slides;

  // ---------- SKIP button ----------
  /// Render your own SKIP button
  late final Widget renderSkipBtn;

  /// Fire when press SKIP button
  late final Function onSkipPress;

  /// Change SKIP to any text you want
  late final String nameSkipBtn;

  /// Style for text at SKIP button
  late final TextStyle styleSkipBtn;

  /// Color for SKIP button
  late final Color colorSkipBtn;

  /// Show or hide SKIP button
  late final bool showSkipBtn;

  /// Rounded SKIP button
  late final double borderRadiusSkipBtn;

  // ---------- PREV button ----------
  /// Render your own PREV button
  late final Widget renderPrevBtn;

  /// Change PREV to any text you want
  late final String namePrevBtn;

  /// Style for text at PREV button
  late final TextStyle stylePrevBtn;

  /// Color for PREV button
  late final Color colorPrevBtn;

  /// Show or hide PREV button
  bool showPrevBtn = true;

  /// Rounded PREV button
  late final double borderRadiusPrevBtn;

  // ---------- DONE button ----------
  /// Render your own DONE button
  late final Widget renderDoneBtn;

  /// Fire when press DONE button
  late final Function onDonePress;

  /// Change DONE to any text you want
  late final String nameDoneBtn;

  /// Style for text at DONE button
  late final TextStyle styleDoneBtn;

  /// Color for DONE button
  late final Color colorDoneBtn;

  /// Rounded DONE button
  late final double borderRadiusDoneBtn;

  /// Show or hide DONE button
  late final bool showDoneBtn;

  // ---------- NEXT button ----------
  /// Render your own NEXT button
  late final Widget renderNextBtn;

  /// Change NEXT to any text you want
  late final String nameNextBtn;

  /// Show or hide NEXT button
  late final bool showNextBtn;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  late final bool showDotIndicator;

  /// Color for dot when passive
  late final Color colorDot;

  /// Color for dot when active
  late final Color colorActiveDot;

  /// Size of each dot
  late final double? sizeDot;

  /// Type dots animation
  dotSliderAnimation? typeDotAnimation;

  // ---------- Tabs ----------
  /// List custom tabs
  List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  Function? onTabChangeCompleted;

  // ---------- Behavior ----------
  /// Allow the slider to scroll
  late final bool isScrollable;
  late final ScrollPhysics scrollPhysics;

  /// The way the vertical scrollbar should behave
  late final scrollbarBehavior verticalScrollbarBehavior;

  late TabController tabController;

  List<Widget>? tabs = [];
  List<Widget> dots = [];
  List<double?> sizeDots = [];
  List<double> opacityDots = [];
  List<ScrollController> scrollControllers = [];

  // For DOT_MOVEMENT
  double marginLeftDotFocused = 0;
  double marginRightDotFocused = 0;

  // For SIZE_TRANSITION
  double currentAnimationValue = 0;
  int currentTabIndex = 0;

  late final int lengthSlide;

  @override
  void initState() {
    super.initState();
    slides = widget.slides;

    lengthSlide = slides?.length ?? widget.listCustomTabs?.length ?? 0;

    tabController = TabController(length: lengthSlide, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        currentTabIndex = tabController.previousIndex;
      } else {
        currentTabIndex = tabController.index;
      }
      currentAnimationValue = tabController.animation!.value;
      if (onTabChangeCompleted != null) {
        onTabChangeCompleted!(tabController.index);
      }
    });

    // Send reference function goToTab to parent
    if (widget.refFuncGoToTab != null) {
      widget.refFuncGoToTab!(goToTab);
    }

    // Dot animation
    sizeDot = widget.sizeDot ?? 8.0;

    final initValueMarginRight = (sizeDot! * 2) * (lengthSlide - 1);
    typeDotAnimation =
        widget.typeDotAnimation ?? dotSliderAnimation.DOT_MOVEMENT;

    switch (typeDotAnimation!) {
      case dotSliderAnimation.DOT_MOVEMENT:
        for (var i = 0; i < lengthSlide; i++) {
          sizeDots.add(sizeDot);
          opacityDots.add(1.0);
        }
        marginRightDotFocused = initValueMarginRight;
        break;
      case dotSliderAnimation.SIZE_TRANSITION:
        for (var i = 0; i < lengthSlide; i++) {
          if (i == 0) {
            sizeDots.add(sizeDot! * 1.5);
            opacityDots.add(1.0);
          } else {
            sizeDots.add(sizeDot);
            opacityDots.add(0.5);
          }
        }
    }

    tabController.animation!.addListener(() {
      setState(() {
        switch (typeDotAnimation!) {
          case dotSliderAnimation.DOT_MOVEMENT:
            marginLeftDotFocused =
                tabController.animation!.value * sizeDot! * 2;
            marginRightDotFocused = initValueMarginRight -
                tabController.animation!.value * sizeDot! * 2;
            break;
          case dotSliderAnimation.SIZE_TRANSITION:
            if (tabController.animation!.value == currentAnimationValue) {
              break;
            }

            var diffValueAnimation =
                (tabController.animation!.value - currentAnimationValue).abs();
            final diffValueIndex =
                (currentTabIndex - tabController.index).abs();

            // When press skip button
            if (tabController.indexIsChanging &&
                (tabController.index - tabController.previousIndex).abs() > 1) {
              if (diffValueAnimation < 1.0) {
                diffValueAnimation = 1.0;
              }
              sizeDots[currentTabIndex] = sizeDot! * 1.5 -
                  (sizeDot! / 2) * (1 - (diffValueIndex - diffValueAnimation));
              sizeDots[tabController.index] = sizeDot! +
                  (sizeDot! / 2) * (1 - (diffValueIndex - diffValueAnimation));
              opacityDots[currentTabIndex] =
                  1.0 - (diffValueAnimation / diffValueIndex) / 2;
              opacityDots[tabController.index] =
                  0.5 + (diffValueAnimation / diffValueIndex) / 2;
            } else {
              if (tabController.animation!.value > currentAnimationValue) {
                // Swipe left
                sizeDots[currentTabIndex] =
                    sizeDot! * 1.5 - (sizeDot! / 2) * diffValueAnimation;
                sizeDots[currentTabIndex + 1] =
                    sizeDot! + (sizeDot! / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex + 1] = 0.5 + diffValueAnimation / 2;
              } else {
                // Swipe right
                sizeDots[currentTabIndex] =
                    sizeDot! * 1.5 - (sizeDot! / 2) * diffValueAnimation;
                sizeDots[currentTabIndex - 1] =
                    sizeDot! + (sizeDot! / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex - 1] = 0.5 + diffValueAnimation / 2;
              }
            }
            break;
        }
      });
    });

    // Dot indicator
    showDotIndicator = widget.showDotIndicator ?? true;

    colorDot = widget.colorDot ?? const Color(0x80000000);

    colorActiveDot = widget.colorActiveDot ?? colorDot;

    isScrollable = widget.isScrollable ?? true;

    scrollPhysics = widget.scrollPhysics ?? const ScrollPhysics();

    verticalScrollbarBehavior =
        widget.verticalScrollbarBehavior ?? scrollbarBehavior.HIDE;

    setupButtonDefaultValues();

    if (widget.listCustomTabs == null) {
      renderListTabs();
    } else {
      tabs = widget.listCustomTabs;
    }
  }

  void setupButtonDefaultValues() {
    // Skip button
    onSkipPress = widget.onSkipPress ??
        () {
          if (!isAnimating(tabController.animation!.value)) {
            if (lengthSlide > 0) {
              tabController.animateTo(lengthSlide - 1);
            }
          }
        };

    showSkipBtn = widget.showSkipBtn ?? true;

    styleSkipBtn = widget.styleSkipBtn ?? defaultBtnNameTextStyle;

    nameSkipBtn = widget.nameSkipBtn ?? 'SKIP';

    renderSkipBtn = widget.renderSkipBtn ??
        Text(
          nameSkipBtn,
          style: styleSkipBtn,
        );
    colorSkipBtn = widget.colorSkipBtn ?? defaultBtnColor;

    borderRadiusSkipBtn = widget.borderRadiusSkipBtn ?? defaultBtnBorderRadius;

    // Prev button
    if (widget.showPrevBtn == null || showSkipBtn) {
      showPrevBtn = false;
    }

    stylePrevBtn = widget.stylePrevBtn ?? defaultBtnNameTextStyle;

    namePrevBtn = widget.namePrevBtn ?? 'PREV';

    renderPrevBtn = widget.renderPrevBtn ??
        Text(
          namePrevBtn,
          style: stylePrevBtn,
        );

    colorPrevBtn = widget.colorPrevBtn ?? defaultBtnColor;

    borderRadiusPrevBtn = widget.borderRadiusPrevBtn ?? defaultBtnBorderRadius;

    showDoneBtn = widget.showDoneBtn ?? true;

    showNextBtn = widget.showNextBtn ?? true;

    // Done button
    onDonePress = widget.onDonePress ?? () {};

    styleDoneBtn = widget.styleDoneBtn ?? defaultBtnNameTextStyle;

    nameDoneBtn = widget.nameDoneBtn ?? 'DONE';

    renderDoneBtn = widget.renderDoneBtn ??
        Text(
          nameDoneBtn,
          style: styleDoneBtn,
        );

    colorDoneBtn = widget.colorDoneBtn ?? defaultBtnColor;

    borderRadiusDoneBtn = widget.borderRadiusDoneBtn ?? defaultBtnBorderRadius;

    // Next button
    nameNextBtn = widget.nameNextBtn ?? 'NEXT';

    renderNextBtn = widget.renderNextBtn ??
        Text(
          nameNextBtn,
          style: styleDoneBtn,
        );
  }

  void goToTab(int index) {
    if (index < tabController.length) {
      tabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  // Checking if tab is animating
  bool isAnimating(double value) {
    return tabController.animation!.value -
            tabController.animation!.value.truncate() !=
        0;
  }

  bool isRTLLanguage(String language) {
    return rtlLanguages.contains(language);
  }

  @override
  Widget build(BuildContext context) {
    // Full screen view
    if (widget.hideStatusBar == true) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    }

    return Scaffold(
      body: DefaultTabController(
        length: lengthSlide,
        child: Stack(
          children: <Widget>[
            TabBarView(
              controller: tabController,
              physics: isScrollable
                  ? scrollPhysics
                  : const NeverScrollableScrollPhysics(),
              children: tabs!,
            ),
            renderBottom(),
          ],
        ),
      ),
      backgroundColor: widget.backgroundColorAllSlides ?? Colors.transparent,
    );
  }

  Widget buildSkipButton() {
    if (tabController.index + 1 == lengthSlide) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return TextButton(
        onPressed: onSkipPress as void Function(),
        style: TextButton.styleFrom(
          primary: colorSkipBtn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusSkipBtn)),
        ),
        child: renderSkipBtn,
      );
    }
  }

  Widget buildDoneButton() {
    return TextButton(
      onPressed: onDonePress as void Function()?,
      style: TextButton.styleFrom(
        primary: colorDoneBtn,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusDoneBtn)),
      ),
      child: renderDoneBtn,
    );
  }

  Widget buildPrevButton() {
    if (tabController.index == 0) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return TextButton(
        onPressed: () {
          if (!isAnimating(tabController.animation!.value)) {
            tabController.animateTo(tabController.index - 1);
          }
        },
        style: TextButton.styleFrom(
          primary: colorPrevBtn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusPrevBtn)),
        ),
        child: renderPrevBtn,
      );
    }
  }

  Widget buildNextButton() {
    return TextButton(
      onPressed: () {
        if (!isAnimating(tabController.animation!.value)) {
          tabController.animateTo(tabController.index + 1);
        }
      },
      style: TextButton.styleFrom(
        primary: colorDoneBtn,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusDoneBtn)),
      ),
      child: renderNextBtn,
    );
  }

  Widget renderBottom() {
    return Positioned(
      bottom: 10.0,
      left: 10.0,
      right: 10.0,
      child: Row(
        children: <Widget>[
          // Skip button
          Container(
            alignment: Alignment.center,
            width: showSkipBtn
                ? widget.widthSkipBtn ?? MediaQuery.of(context).size.width / 4
                : (showPrevBtn
                    ? widget.widthPrevBtn
                    : MediaQuery.of(context).size.width / 4),
            child: showSkipBtn
                ? buildSkipButton()
                : (showPrevBtn ? buildPrevButton() : Container()),
          ),

          // Dot indicator
          Flexible(
            child: showDotIndicator
                ? Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: renderListDots(),
                      ),
                      if (typeDotAnimation == dotSliderAnimation.DOT_MOVEMENT)
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: colorActiveDot,
                                borderRadius:
                                    BorderRadius.circular(sizeDot! / 2)),
                            width: sizeDot,
                            height: sizeDot,
                            margin: EdgeInsets.only(
                                left: isRTLLanguage(
                                        Localizations.localeOf(context)
                                            .languageCode)
                                    ? marginRightDotFocused
                                    : marginLeftDotFocused,
                                right: isRTLLanguage(
                                        Localizations.localeOf(context)
                                            .languageCode)
                                    ? marginLeftDotFocused
                                    : marginRightDotFocused),
                          ),
                        )
                      else
                        Container()
                    ],
                  )
                : Container(),
          ),

          // Next, Done button
          Container(
            alignment: Alignment.center,
            width: widget.widthDoneBtn ?? MediaQuery.of(context).size.width / 4,
            height: 50,
            child: tabController.index + 1 == lengthSlide
                ? showDoneBtn
                    ? buildDoneButton()
                    : Container()
                : showNextBtn
                    ? buildNextButton()
                    : Container(),
          ),
        ],
      ),
    );
  }

  List<Widget>? renderListTabs() {
    for (var i = 0; i < lengthSlide; i++) {
      final scrollController = ScrollController();
      scrollControllers.add(scrollController);
      tabs!.add(
        renderTab(
          scrollController,
          slides?[i].widgetTitle,
          slides?[i].title,
          slides?[i].maxLineTitle,
          slides?[i].styleTitle,
          slides?[i].marginTitle,
          slides?[i].widgetDescription,
          slides?[i].description,
          slides?[i].maxLineTextDescription,
          slides?[i].styleDescription,
          slides?[i].marginDescription,
          slides?[i].pathImage,
          slides?[i].widthImage,
          slides?[i].heightImage,
          slides?[i].foregroundImageFit,
          slides?[i].centerWidget,
          slides?[i].onCenterItemPress,
          slides?[i].backgroundColor,
          slides?[i].colorBegin,
          slides?[i].colorEnd,
          slides?[i].directionColorBegin,
          slides?[i].directionColorEnd,
          slides?[i].backgroundImage,
          slides?[i].backgroundImageFit,
          slides?[i].backgroundOpacity,
          slides?[i].backgroundOpacityColor,
          slides?[i].backgroundBlendMode,
        ),
      );
    }
    return tabs;
  }

  Widget renderTab(
    ScrollController scrollController,

    // Title
    Widget? widgetTitle,
    String? title,
    int? maxLineTitle,
    TextStyle? styleTitle,
    EdgeInsets? marginTitle,

    // Description
    Widget? widgetDescription,
    String? description,
    int? maxLineTextDescription,
    TextStyle? styleDescription,
    EdgeInsets? marginDescription,

    // Image
    String? pathImage,
    double? widthImage,
    double? heightImage,
    BoxFit? foregroundImageFit,

    // Center Widget
    Widget? centerWidget,
    Function? onCenterItemPress,

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
  ) {
    final listView = ListView(
      controller: scrollController,
      children: <Widget>[
        Container(
          // Title
          margin: marginTitle ??
              const EdgeInsets.only(
                  top: 70.0, bottom: 50.0, left: 20.0, right: 20.0),
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
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
        ),

        // Image or Center widget
        GestureDetector(
          onTap: onCenterItemPress as void Function()?,
          child: pathImage != null
              ? Image.asset(
                  pathImage,
                  width: widthImage ?? 200.0,
                  height: heightImage ?? 200.0,
                  fit: foregroundImageFit ?? BoxFit.contain,
                )
              : Center(child: centerWidget ?? Container()),
        ),

        // Description
        Container(
          margin: marginDescription ??
              const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          child: widgetDescription ??
              Text(
                description ?? '',
                style: styleDescription ??
                    const TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
                maxLines: maxLineTextDescription ?? 100,
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ],
    );
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: backgroundImage != null
          ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: backgroundImageFit ?? BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  backgroundOpacityColor != null
                      ? backgroundOpacityColor
                          .withOpacity(backgroundOpacity ?? 0.5)
                      : Colors.black.withOpacity(backgroundOpacity ?? 0.5),
                  backgroundBlendMode ?? BlendMode.darken,
                ),
              ),
            )
          : BoxDecoration(
              gradient: LinearGradient(
                colors: backgroundColor != null
                    ? [backgroundColor, backgroundColor]
                    : [
                        colorBegin ?? Colors.amberAccent,
                        colorEnd ?? Colors.amberAccent
                      ],
                begin: directionColorBegin ?? Alignment.topLeft,
                end: directionColorEnd ?? Alignment.bottomRight,
              ),
            ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 60.0),
        child: verticalScrollbarBehavior != scrollbarBehavior.HIDE
            ? Platform.isIOS
                ? CupertinoScrollbar(
                    controller: scrollController,
                    isAlwaysShown: verticalScrollbarBehavior ==
                        scrollbarBehavior.SHOW_ALWAYS,
                    child: listView,
                  )
                : Scrollbar(
                    controller: scrollController,
                    isAlwaysShown: verticalScrollbarBehavior ==
                        scrollbarBehavior.SHOW_ALWAYS,
                    child: listView,
                  )
            : listView,
      ),
    );
  }

  List<Widget> renderListDots() {
    dots.clear();
    for (var i = 0; i < lengthSlide; i++) {
      dots.add(renderDot(sizeDots[i]!, colorDot, opacityDots[i]));
    }
    return dots;
  }

  Widget renderDot(double radius, Color? color, double opacity) {
    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(radius / 2)),
        width: radius,
        height: radius,
        margin: EdgeInsets.only(left: radius / 2, right: radius / 2),
      ),
    );
  }
}
