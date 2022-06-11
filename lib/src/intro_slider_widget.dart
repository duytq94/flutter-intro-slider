import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroSlider extends StatefulWidget {
  // ---------- Slides ----------
  /// An array of Slide object
  final List<Slide>? slides;

  /// Background color for all slides
  final Color? backgroundColorAllSlides;

  // ---------- SKIP button ----------
  /// Render your own widget SKIP button
  final Widget? renderSkipBtn;

  /// Render your own style SKIP button
  final ButtonStyle? skipButtonStyle;

  /// Fire when press SKIP button
  final void Function()? onSkipPress;

  /// Show or hide SKIP button
  final bool? showSkipBtn;

  /// Assign Key to SKIP button
  final Key? skipButtonKey;

  // ---------- PREV button ----------
  /// Render your own widget PREV button
  final Widget? renderPrevBtn;

  /// Render your own style PREV button
  final ButtonStyle? prevButtonStyle;

  /// Show or hide PREV button (only visible if skip is hidden)
  final bool? showPrevBtn;

  /// Assign Key to PREV button
  final Key? prevButtonKey;

  // ---------- NEXT button ----------
  /// Render your own widget NEXT button
  final Widget? renderNextBtn;

  /// Render your own style NEXT button
  final ButtonStyle? nextButtonStyle;

  /// Show or hide NEXT button
  final bool? showNextBtn;

  /// Fire when press NEXT button
  final Function()? onNextPress;

  /// Assign Key to NEXT button
  final Key? nextButtonKey;

  // ---------- DONE button ----------
  /// Render your own widget DONE button
  final Widget? renderDoneBtn;

  /// Render your own style NEXT button
  final ButtonStyle? doneButtonStyle;

  /// Fire when press DONE button
  final void Function()? onDonePress;

  /// Show or hide DONE button
  final bool? showDoneBtn;

  /// Assign Key to DONE button
  final Key? doneButtonKey;

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
  final DotSliderAnimation? typeDotAnimation;

  // ---------- Tabs ----------
  /// Render your own custom tabs
  final List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  final void Function(int index)? onTabChangeCompleted;

  /// Ref function go to specific tab index
  final void Function(Function function)? refFuncGoToTab;

  // ---------- Behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool? isScrollable;
  final ScrollPhysics? scrollPhysics;

  /// Show or hide status bar
  final bool? hideStatusBar;

  /// The way the vertical scrollbar should behave
  final ScrollbarBehavior? verticalScrollbarBehavior;

  /// location of the dots and prev/next/done buttons
  final IntroSliderNavPosition navPosition;

  // Constructor
  const IntroSlider({
    Key? key,
    // Slides
    this.slides,
    this.backgroundColorAllSlides,

    // Skip
    this.renderSkipBtn,
    this.skipButtonStyle,
    this.onSkipPress,
    this.showSkipBtn,
    this.skipButtonKey,

    // Prev
    this.renderPrevBtn,
    this.prevButtonStyle,
    this.showPrevBtn,
    this.prevButtonKey,

    // Done
    this.renderDoneBtn,
    this.onDonePress,
    this.doneButtonStyle,
    this.showDoneBtn,
    this.doneButtonKey,

    // Next
    this.renderNextBtn,
    this.nextButtonStyle,
    this.showNextBtn,
    this.onNextPress,
    this.nextButtonKey,

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
    this.navPosition = IntroSliderNavPosition.bottom,
  }) : super(key: key);

  @override
  IntroSliderState createState() => IntroSliderState();
}

class IntroSliderState extends State<IntroSlider>
    with SingleTickerProviderStateMixin {
  // ---------- Slides ----------
  /// An array of Slide object
  late final List<Slide>? slides;

  // ---------- SKIP button ----------
  /// Render your own widget SKIP button
  late final Widget renderSkipBtn;

  /// Fire when press SKIP button
  late final void Function()? onSkipPress;

  /// Render your own style SKIP button
  late final ButtonStyle skipButtonStyle;

  /// Show or hide SKIP button
  late final bool showSkipBtn;

  /// Assign Key to SKIP button
  late final Key? skipButtonKey;

  // ---------- PREV button ----------
  /// Render your own widget PREV button
  late final Widget renderPrevBtn;

  /// Render your own style PREV button
  late final ButtonStyle prevButtonStyle;

  /// Show or hide PREV button
  late final bool showPrevBtn;

  /// Assign Key to PREV button
  late final Key? prevButtonKey;

  // ---------- DONE button ----------
  /// Render your own widget DONE button
  late final Widget renderDoneBtn;

  /// Fire when press DONE button
  late final void Function()? onDonePress;

  /// Render your own style DONE button
  late final ButtonStyle doneButtonStyle;

  /// Show or hide DONE button
  late final bool showDoneBtn;

  /// Assign Key to DONE button
  late final Key? doneButtonKey;

  // ---------- NEXT button ----------
  /// Render your own widget NEXT button
  late final Widget renderNextBtn;

  /// Render your own style NEXT button
  late final ButtonStyle nextButtonStyle;

  /// Show or hide NEXT button
  late final bool showNextBtn;

  /// Fire when press NEXT button
  late final void Function()? onNextPress;

  /// Assign Key to NEXT button
  late final Key? nextButtonKey;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  late final bool showDotIndicator;

  /// Color for dot when passive
  late final Color colorDot;

  /// Color for dot when active
  late final Color colorActiveDot;

  /// Size of each dot
  late final double sizeDot;

  /// Type dots animation
  late final DotSliderAnimation typeDotAnimation;

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
  late final ScrollbarBehavior verticalScrollbarBehavior;

  late TabController tabController;

  List<Widget> tabs = [];
  List<Widget> dots = [];
  List<double> sizeDots = [];
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

    skipButtonKey = widget.skipButtonKey;
    prevButtonKey = widget.prevButtonKey;
    doneButtonKey = widget.doneButtonKey;
    nextButtonKey = widget.nextButtonKey;

    lengthSlide = slides?.length ?? widget.listCustomTabs?.length ?? 0;

    onTabChangeCompleted = widget.onTabChangeCompleted;
    tabController = TabController(length: lengthSlide, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        currentTabIndex = tabController.previousIndex;
      } else {
        currentTabIndex = tabController.index;
        onTabChangeCompleted?.call(tabController.index);
      }
      currentAnimationValue = tabController.animation?.value ?? 0;
    });

    // Send reference function goToTab to parent
    widget.refFuncGoToTab?.call(goToTab);

    // Dot animation
    sizeDot = widget.sizeDot ?? 8.0;

    final initValueMarginRight = (sizeDot * 2) * (lengthSlide - 1);
    typeDotAnimation =
        widget.typeDotAnimation ?? DotSliderAnimation.DOT_MOVEMENT;

    switch (typeDotAnimation) {
      case DotSliderAnimation.DOT_MOVEMENT:
        for (var i = 0; i < lengthSlide; i++) {
          sizeDots.add(sizeDot);
          opacityDots.add(1.0);
        }
        marginRightDotFocused = initValueMarginRight;
        break;
      case DotSliderAnimation.SIZE_TRANSITION:
        for (var i = 0; i < lengthSlide; i++) {
          if (i == 0) {
            sizeDots.add(sizeDot * 1.5);
            opacityDots.add(1.0);
          } else {
            sizeDots.add(sizeDot);
            opacityDots.add(0.5);
          }
        }
    }

    tabController.animation?.addListener(() {
      setState(() {
        switch (typeDotAnimation) {
          case DotSliderAnimation.DOT_MOVEMENT:
            marginLeftDotFocused = tabController.animation!.value * sizeDot * 2;
            marginRightDotFocused = initValueMarginRight -
                tabController.animation!.value * sizeDot * 2;
            break;
          case DotSliderAnimation.SIZE_TRANSITION:
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
              sizeDots[currentTabIndex] = sizeDot * 1.5 -
                  (sizeDot / 2) * (1 - (diffValueIndex - diffValueAnimation));
              sizeDots[tabController.index] = sizeDot +
                  (sizeDot / 2) * (1 - (diffValueIndex - diffValueAnimation));
              opacityDots[currentTabIndex] =
                  1.0 - (diffValueAnimation / diffValueIndex) / 2;
              opacityDots[tabController.index] =
                  0.5 + (diffValueAnimation / diffValueIndex) / 2;
            } else {
              if (tabController.animation!.value > currentAnimationValue) {
                // Swipe left
                sizeDots[currentTabIndex] =
                    sizeDot * 1.5 - (sizeDot / 2) * diffValueAnimation;
                sizeDots[currentTabIndex + 1] =
                    sizeDot + (sizeDot / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex + 1] = 0.5 + diffValueAnimation / 2;
              } else {
                // Swipe right
                sizeDots[currentTabIndex] =
                    sizeDot * 1.5 - (sizeDot / 2) * diffValueAnimation;
                sizeDots[currentTabIndex - 1] =
                    sizeDot + (sizeDot / 2) * diffValueAnimation;
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
        widget.verticalScrollbarBehavior ?? ScrollbarBehavior.HIDE;

    setupButtonDefaultValues();

    if (widget.listCustomTabs == null) {
      renderListTabs();
    } else {
      tabs = widget.listCustomTabs!;
    }
  }

  void setupButtonDefaultValues() {
    // Skip button
    onSkipPress = widget.onSkipPress ??
        () {
          if (!isAnimating()) {
            if (lengthSlide > 0) {
              tabController.animateTo(lengthSlide - 1);
            }
          }
        };

    showSkipBtn = widget.showSkipBtn ?? true;

    renderSkipBtn = widget.renderSkipBtn ??
        const Text(
          "SKIP",
          style: TextStyle(color: Colors.white),
        );
    skipButtonStyle = widget.skipButtonStyle ?? const ButtonStyle();

    // Prev button
    if (showSkipBtn) {
      showPrevBtn = false;
    } else {
      showPrevBtn = widget.showPrevBtn ?? true;
    }

    renderPrevBtn = widget.renderPrevBtn ??
        const Text(
          "PREV",
          style: TextStyle(color: Colors.white),
        );
    prevButtonStyle = widget.prevButtonStyle ?? const ButtonStyle();

    showNextBtn = widget.showNextBtn ?? true;

    // Done button
    onDonePress = widget.onDonePress ?? () {};
    renderDoneBtn = widget.renderDoneBtn ??
        const Text(
          "DONE",
          style: TextStyle(color: Colors.white),
        );
    doneButtonStyle = widget.doneButtonStyle ?? const ButtonStyle();
    showDoneBtn = widget.showDoneBtn ?? true;

    // Next button
    onNextPress = widget.onNextPress ?? () {};
    renderNextBtn = widget.renderNextBtn ??
        const Text(
          "NEXT",
          style: TextStyle(color: Colors.white),
        );
    nextButtonStyle = widget.nextButtonStyle ?? const ButtonStyle();
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
  bool isAnimating() {
    Animation<double>? animation = tabController.animation;
    if (animation != null) {
      return animation.value - animation.value.truncate() != 0;
    } else {
      return false;
    }
  }

  bool isRTLLanguage(String language) {
    return IntroSliderConfig.rtlLanguages.contains(language);
  }

  @override
  Widget build(BuildContext context) {
    // Full screen view
    if (widget.hideStatusBar == true) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
              children: tabs,
            ),
            renderNav(),
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
        key: skipButtonKey,
        onPressed: onSkipPress,
        style: skipButtonStyle,
        child: renderSkipBtn,
      );
    }
  }

  Widget buildDoneButton() {
    return TextButton(
      key: doneButtonKey,
      onPressed: onDonePress,
      style: doneButtonStyle,
      child: renderDoneBtn,
    );
  }

  Widget buildPrevButton() {
    if (tabController.index == 0) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return TextButton(
        key: prevButtonKey,
        onPressed: () {
          if (!isAnimating()) {
            tabController.animateTo(tabController.index - 1);
          }
        },
        style: prevButtonStyle,
        child: renderPrevBtn,
      );
    }
  }

  Widget buildNextButton() {
    return TextButton(
      key: nextButtonKey,
      onPressed: () {
        onNextPress?.call();
        if (!isAnimating()) {
          tabController.animateTo(tabController.index + 1);
        }
      },
      style: nextButtonStyle,
      child: renderNextBtn,
    );
  }

  Widget renderNav() {
    return Positioned(
      top: widget.navPosition == IntroSliderNavPosition.top
          ? MediaQuery.of(context).viewPadding.top
          : null,
      bottom: widget.navPosition == IntroSliderNavPosition.bottom ? 10.0 : null,
      left: 10.0,
      right: 10.0,
      child: Row(
        children: <Widget>[
          // Skip button
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 4,
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
                      if (typeDotAnimation == DotSliderAnimation.DOT_MOVEMENT)
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorActiveDot,
                              borderRadius: BorderRadius.circular(sizeDot / 2),
                            ),
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
                                  : marginRightDotFocused,
                            ),
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
            width: MediaQuery.of(context).size.width / 4,
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
      tabs.add(
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
          slides?[i].backgroundNetworkImage,
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
    void Function()? onCenterItemPress,

    // Background color
    Color? backgroundColor,
    Color? colorBegin,
    Color? colorEnd,
    AlignmentGeometry? directionColorBegin,
    AlignmentGeometry? directionColorEnd,

    // Background image
    String? backgroundImage,
    BoxFit? backgroundImageFit,
    String? backgroundNetworkImage,
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
          onTap: onCenterItemPress,
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
      decoration: backgroundImage == null && backgroundNetworkImage == null
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: backgroundColor != null
                    ? [backgroundColor, backgroundColor]
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
                  ? AssetImage(backgroundImage)
                  : NetworkImage(backgroundNetworkImage!) as ImageProvider,
              fit: backgroundImageFit ?? BoxFit.cover,
              colorFilter: ColorFilter.mode(
                backgroundOpacityColor != null
                    ? backgroundOpacityColor
                        .withOpacity(backgroundOpacity ?? 0.5)
                    : Colors.black.withOpacity(backgroundOpacity ?? 0.5),
                backgroundBlendMode ?? BlendMode.darken,
              ),
            )),
      child: Container(
        margin: EdgeInsets.only(
          top: widget.navPosition == IntroSliderNavPosition.top ? 60 : 0,
          bottom: widget.navPosition == IntroSliderNavPosition.bottom ? 60 : 0,
        ),
        child: verticalScrollbarBehavior != ScrollbarBehavior.HIDE
            ? Platform.isIOS
                ? CupertinoScrollbar(
                    controller: scrollController,
                    thumbVisibility: verticalScrollbarBehavior ==
                        ScrollbarBehavior.SHOW_ALWAYS,
                    child: listView,
                  )
                : Scrollbar(
                    controller: scrollController,
                    thumbVisibility: verticalScrollbarBehavior ==
                        ScrollbarBehavior.SHOW_ALWAYS,
                    child: listView,
                  )
            : listView,
      ),
    );
  }

  List<Widget> renderListDots() {
    dots.clear();
    for (var i = 0; i < lengthSlide; i++) {
      dots.add(renderDot(sizeDots[i], colorDot, opacityDots[i], i));
    }
    return dots;
  }

  Widget renderDot(double radius, Color? color, double opacity, int index) {
    return GestureDetector(
      onTap: () {
        tabController.animateTo(index);
      },
      child: Opacity(
        opacity: opacity,
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(radius / 2)),
          width: radius,
          height: radius,
          margin: EdgeInsets.only(left: radius / 2, right: radius / 2),
        ),
      ),
    );
  }
}
