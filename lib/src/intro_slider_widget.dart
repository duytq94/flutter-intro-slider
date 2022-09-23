import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';

import 'intro_slider_tab.dart';

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

  // ---------- Indicator ----------
  /// Show or hide indicator
  final bool? isShowIndicator;

  /// Color indicator when passive
  final Color? colorIndicator;

  /// Color indicator when active
  final Color? colorActiveIndicator;

  /// Size of each indicator
  final double? sizeIndicator;

  final double? spaceBetweenIndicator;

  /// Type indicator animation
  final TypeIndicatorAnimation? typeIndicatorAnimation;

  /// Custom indicator
  final Widget? indicatorWidget;

  /// Custom active indicator
  final Widget? activeIndicatorWidget;

  // ---------- Tabs ----------
  /// Render your own custom tabs
  final List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  final void Function(int index)? onTabChangeCompleted;

  /// Ref function go to specific tab index
  final void Function(Function function)? refFuncGoToTab;

  // ---------- Behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool? scrollable;
  final ScrollPhysics? scrollPhysics;
  final Curve? curveScroll;

  /// Enable auto scroll
  final bool? autoScroll;
  final bool? loopAutoScroll;
  final bool? pauseAutoPlayOnTouch;
  final Duration? autoScrollInterval;

  /// Show or hide status bar
  final bool? hideStatusBar;

  /// The way the vertical scrollbar should behave
  final ScrollbarBehavior? verticalScrollbarBehavior;

  /// location of the indicator and prev/next/done buttons
  final IntroSliderNavPosition navPosition;

  // Constructor
  const IntroSlider({
    super.key,
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

    // Indicator
    this.colorActiveIndicator,
    this.colorIndicator,
    this.isShowIndicator,
    this.sizeIndicator,
    this.spaceBetweenIndicator,
    this.typeIndicatorAnimation,
    this.indicatorWidget,
    this.activeIndicatorWidget,

    // Tabs
    this.listCustomTabs,
    this.onTabChangeCompleted,
    this.refFuncGoToTab,

    // Behavior
    this.scrollable,
    this.autoScroll,
    this.loopAutoScroll,
    this.pauseAutoPlayOnTouch,
    this.autoScrollInterval,
    this.curveScroll,
    this.scrollPhysics,
    this.hideStatusBar,
    this.verticalScrollbarBehavior,
    this.navPosition = IntroSliderNavPosition.bottom,
  })  : assert((slides?.length ?? 0) > 0 || (listCustomTabs?.length ?? 0) > 0),
        assert(sizeIndicator == null || sizeIndicator >= 0),
        assert(spaceBetweenIndicator == null || spaceBetweenIndicator >= 0);

  @override
  IntroSliderState createState() => IntroSliderState();
}

class IntroSliderState extends State<IntroSlider> with SingleTickerProviderStateMixin {
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

  // ---------- Indicator ----------
  /// Show or hide indicator
  late final bool isShowIndicator;

  /// Color indicator when passive
  late final Color colorIndicator;

  /// Color indicator when active
  late final Color colorActiveIndicator;

  /// Size of each indicator
  late final double sizeIndicator;

  late final double? spaceBetweenIndicator;

  /// Type indicator animation
  late final TypeIndicatorAnimation typeIndicatorAnimation;

  /// Custom indicator
  late final Widget? indicatorWidget;

  /// Custom active indicator
  late final Widget? activeIndicatorWidget;

  // ---------- Tabs ----------
  /// List custom tabs
  List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  Function? onTabChangeCompleted;

  // ---------- Behavior ----------
  /// Allow the slider to scroll
  late final bool scrollable;
  late final ScrollPhysics scrollPhysics;

  late final bool autoScroll;
  late final bool loopAutoScroll;
  late final bool pauseAutoPlayOnTouch;
  late final Duration autoScrollInterval;
  late final Curve curveScroll;

  /// The way the vertical scrollbar should behave
  late final ScrollbarBehavior verticalScrollbarBehavior;

  late TabController tabController;

  List<Widget> tabs = [];
  List<Widget> indicators = [];
  List<double> sizeIndicators = [];
  List<double> opacityIndicators = [];
  List<ScrollController> scrollControllers = [];

  // For indicator movement
  double marginLeftIndicatorFocused = 0;
  double marginRightIndicatorFocused = 0;

  // For indicator sizeTransition
  double currentAnimationValue = 0;
  int currentTabIndex = 0;

  late final int lengthSlide;
  Timer? timerAutoScroll;

  @override
  void initState() {
    super.initState();
    slides = widget.slides;

    skipButtonKey = widget.skipButtonKey;
    prevButtonKey = widget.prevButtonKey;
    doneButtonKey = widget.doneButtonKey;
    nextButtonKey = widget.nextButtonKey;

    lengthSlide = slides?.length ?? widget.listCustomTabs?.length ?? 0;
    autoScroll = widget.autoScroll ?? false;
    loopAutoScroll = widget.loopAutoScroll ?? false;
    pauseAutoPlayOnTouch = widget.pauseAutoPlayOnTouch ?? true;
    autoScrollInterval = widget.autoScrollInterval ?? const Duration(seconds: 4);
    curveScroll = widget.curveScroll ?? Curves.ease;

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

    if (autoScroll) {
      startTimerAutoScroll();
    }

    // Send reference function goToTab to parent
    widget.refFuncGoToTab?.call(goToTab);

    // Indicator animation
    sizeIndicator = widget.sizeIndicator ?? 8.0;
    spaceBetweenIndicator = widget.spaceBetweenIndicator;

    double initValueMarginRight = 0;
    if (spaceBetweenIndicator != null) {
      initValueMarginRight = (sizeIndicator + spaceBetweenIndicator!) * (lengthSlide - 1);
    } else {
      initValueMarginRight = (sizeIndicator * 2) * (lengthSlide - 1);
    }

    typeIndicatorAnimation = widget.typeIndicatorAnimation ?? TypeIndicatorAnimation.sliding;
    indicatorWidget = widget.indicatorWidget;
    activeIndicatorWidget = widget.activeIndicatorWidget;

    switch (typeIndicatorAnimation) {
      case TypeIndicatorAnimation.sliding:
        for (var i = 0; i < lengthSlide; i++) {
          sizeIndicators.add(sizeIndicator);
          opacityIndicators.add(1.0);
        }
        marginRightIndicatorFocused = initValueMarginRight;
        break;
      case TypeIndicatorAnimation.sizeTransition:
        for (var i = 0; i < lengthSlide; i++) {
          if (i == 0) {
            sizeIndicators.add(sizeIndicator * 1.5);
            opacityIndicators.add(1.0);
          } else {
            sizeIndicators.add(sizeIndicator);
            opacityIndicators.add(0.5);
          }
        }
    }

    tabController.animation?.addListener(() {
      if (tabController.animation == null) return;
      setState(() {
        double animationValue = tabController.animation!.value;
        switch (typeIndicatorAnimation) {
          case TypeIndicatorAnimation.sliding:
            double spaceAvg = 0;
            if (spaceBetweenIndicator != null) {
              spaceAvg = (sizeIndicator + spaceBetweenIndicator!) / 2;
            } else {
              spaceAvg = sizeIndicator;
            }
            marginLeftIndicatorFocused = animationValue * spaceAvg * 2;
            marginRightIndicatorFocused = initValueMarginRight - (animationValue * spaceAvg * 2);
            break;
          case TypeIndicatorAnimation.sizeTransition:
            if (animationValue == currentAnimationValue) {
              break;
            }

            var diffValueAnimation = (animationValue - currentAnimationValue).abs();
            final diffValueIndex = (currentTabIndex - tabController.index).abs();

            // When press skip button
            if (tabController.indexIsChanging && (tabController.index - tabController.previousIndex).abs() > 1) {
              if (diffValueAnimation < 1.0) {
                diffValueAnimation = 1.0;
              }
              sizeIndicators[currentTabIndex] =
                  sizeIndicator * 1.5 - (sizeIndicator / 2) * (1 - (diffValueIndex - diffValueAnimation));
              sizeIndicators[tabController.index] =
                  sizeIndicator + (sizeIndicator / 2) * (1 - (diffValueIndex - diffValueAnimation));
              opacityIndicators[currentTabIndex] = 1.0 - (diffValueAnimation / diffValueIndex) / 2;
              opacityIndicators[tabController.index] = 0.5 + (diffValueAnimation / diffValueIndex) / 2;
            } else {
              if (animationValue > currentAnimationValue) {
                // Swipe left
                sizeIndicators[currentTabIndex] = sizeIndicator * 1.5 - (sizeIndicator / 2) * diffValueAnimation;
                sizeIndicators[currentTabIndex + 1] = sizeIndicator + (sizeIndicator / 2) * diffValueAnimation;
                opacityIndicators[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityIndicators[currentTabIndex + 1] = 0.5 + diffValueAnimation / 2;
              } else {
                // Swipe right
                sizeIndicators[currentTabIndex] = sizeIndicator * 1.5 - (sizeIndicator / 2) * diffValueAnimation;
                sizeIndicators[currentTabIndex - 1] = sizeIndicator + (sizeIndicator / 2) * diffValueAnimation;
                opacityIndicators[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityIndicators[currentTabIndex - 1] = 0.5 + diffValueAnimation / 2;
              }
            }
            break;
        }
      });
    });

    // Indicator
    isShowIndicator = widget.isShowIndicator ?? true;
    colorIndicator = widget.colorIndicator ?? const Color(0x80000000);
    colorActiveIndicator = widget.colorActiveIndicator ?? colorIndicator;

    scrollable = widget.scrollable ?? true;
    scrollPhysics = widget.scrollPhysics ?? const ScrollPhysics();
    verticalScrollbarBehavior = widget.verticalScrollbarBehavior ?? ScrollbarBehavior.hide;

    setupButtonDefaultValues();

    if (widget.listCustomTabs == null) {
      renderListTabs();
    } else {
      tabs = widget.listCustomTabs!;
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    clearTimerAutoScroll();
    super.dispose();
  }

  void startTimerAutoScroll() {
    timerAutoScroll = Timer.periodic(autoScrollInterval, (Timer timer) {
      if (tabController.index < lengthSlide - 1) {
        if (!isAnimating()) {
          tabController.animateTo(tabController.index + 1, curve: curveScroll);
        }
      } else {
        if (loopAutoScroll) {
          if (!isAnimating()) {
            tabController.animateTo(0, curve: curveScroll);
          }
        }
      }
    });
  }

  void clearTimerAutoScroll() {
    timerAutoScroll?.cancel();
    timerAutoScroll = null;
  }

  void setupButtonDefaultValues() {
    // Skip button
    onSkipPress = widget.onSkipPress ??
        () {
          if (!isAnimating()) {
            if (lengthSlide > 0) {
              tabController.animateTo(lengthSlide - 1, curve: curveScroll);
            }
          }
        };

    showSkipBtn = widget.showSkipBtn ?? true;

    renderSkipBtn = widget.renderSkipBtn ?? const Text("SKIP");
    skipButtonStyle = widget.skipButtonStyle ?? const ButtonStyle();

    // Prev button
    if (showSkipBtn) {
      showPrevBtn = false;
    } else {
      showPrevBtn = widget.showPrevBtn ?? true;
    }

    renderPrevBtn = widget.renderPrevBtn ?? const Text("PREV");
    prevButtonStyle = widget.prevButtonStyle ?? const ButtonStyle();

    showNextBtn = widget.showNextBtn ?? true;

    // Done button
    onDonePress = widget.onDonePress ?? () {};
    renderDoneBtn = widget.renderDoneBtn ?? const Text("DONE");
    doneButtonStyle = widget.doneButtonStyle ?? const ButtonStyle();
    showDoneBtn = widget.showDoneBtn ?? true;

    // Next button
    onNextPress = widget.onNextPress ?? () {};
    renderNextBtn = widget.renderNextBtn ?? const Text("NEXT");
    nextButtonStyle = widget.nextButtonStyle ?? const ButtonStyle();
  }

  void goToTab(int index) {
    if (index < tabController.length) {
      tabController.animateTo(index, curve: curveScroll);
    }
  }

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
            GestureDetector(
              onTapDown: (a) {
                clearTimerAutoScroll();
              },
              onTapUp: (a) {
                if (autoScroll) {
                  startTimerAutoScroll();
                }
              },
              onTapCancel: () {
                if (autoScroll) {
                  startTimerAutoScroll();
                }
              },
              child: TabBarView(
                controller: tabController,
                physics: scrollable ? scrollPhysics : const NeverScrollableScrollPhysics(),
                children: tabs,
              ),
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
            tabController.animateTo(tabController.index - 1, curve: curveScroll);
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
          tabController.animateTo(tabController.index + 1, curve: curveScroll);
        }
      },
      style: nextButtonStyle,
      child: renderNextBtn,
    );
  }

  Widget renderNav() {
    return Positioned(
      top: widget.navPosition == IntroSliderNavPosition.top ? MediaQuery.of(context).viewPadding.top : null,
      bottom: widget.navPosition == IntroSliderNavPosition.bottom ? 10.0 : null,
      left: 10.0,
      right: 10.0,
      child: Row(
        children: <Widget>[
          // Skip button
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 4,
            child: showSkipBtn ? buildSkipButton() : (showPrevBtn ? buildPrevButton() : const SizedBox.shrink()),
          ),

          // Indicator
          Flexible(
            child: isShowIndicator
                ? Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: renderListIndicator(),
                      ),
                      typeIndicatorAnimation == TypeIndicatorAnimation.sliding
                          ? renderActiveIndicator()
                          : const SizedBox.shrink()
                    ],
                  )
                : const SizedBox.shrink(),
          ),

          // Next, Done button
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 4,
            height: 50,
            child: tabController.index + 1 == lengthSlide
                ? showDoneBtn
                    ? buildDoneButton()
                    : const SizedBox.shrink()
                : showNextBtn
                    ? buildNextButton()
                    : const SizedBox.shrink(),
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
        IntroSliderTab(
          scrollController: scrollController,
          navPosition: widget.navPosition,
          verticalScrollbarBehavior: verticalScrollbarBehavior,
          widgetTitle: slides?[i].widgetTitle,
          title: slides?[i].title,
          maxLineTitle: slides?[i].maxLineTitle,
          styleTitle: slides?[i].styleTitle,
          textAlignTitle: slides?[i].textAlignTitle,
          textOverFlowTitle: slides?[i].textOverFlowTitle,
          marginTitle: slides?[i].marginTitle,
          widgetDescription: slides?[i].widgetDescription,
          description: slides?[i].description,
          maxLineTextDescription: slides?[i].maxLineTextDescription,
          styleDescription: slides?[i].styleDescription,
          textAlignDescription: slides?[i].textAlignDescription,
          textOverFlowDescription: slides?[i].textOverFlowDescription,
          marginDescription: slides?[i].marginDescription,
          pathImage: slides?[i].pathImage,
          widthImage: slides?[i].widthImage,
          heightImage: slides?[i].heightImage,
          foregroundImageFit: slides?[i].foregroundImageFit,
          centerWidget: slides?[i].centerWidget,
          onCenterItemPress: slides?[i].onCenterItemPress,
          backgroundColor: slides?[i].backgroundColor,
          colorBegin: slides?[i].colorBegin,
          colorEnd: slides?[i].colorEnd,
          directionColorBegin: slides?[i].directionColorBegin,
          directionColorEnd: slides?[i].directionColorEnd,
          backgroundImage: slides?[i].backgroundImage,
          backgroundImageFit: slides?[i].backgroundImageFit,
          backgroundNetworkImage: slides?[i].backgroundNetworkImage,
          backgroundOpacity: slides?[i].backgroundOpacity,
          backgroundOpacityColor: slides?[i].backgroundOpacityColor,
          backgroundBlendMode: slides?[i].backgroundBlendMode,
        ),
      );
    }
    return tabs;
  }

  Widget renderActiveIndicator() {
    return Container(
      margin: EdgeInsets.only(
        left: isRTLLanguage(Localizations.localeOf(context).languageCode)
            ? marginRightIndicatorFocused
            : marginLeftIndicatorFocused,
        right: isRTLLanguage(Localizations.localeOf(context).languageCode)
            ? marginLeftIndicatorFocused
            : marginRightIndicatorFocused,
      ),
      child: activeIndicatorWidget ?? indicatorWidget ?? renderDefaultDot(sizeIndicator, colorActiveIndicator),
    );
  }

  List<Widget> renderListIndicator() {
    indicators.clear();
    for (var i = 0; i < lengthSlide; i++) {
      double opacityCurrentIndicator = opacityIndicators[i];
      if (opacityCurrentIndicator >= 0 && opacityCurrentIndicator <= 1) {
        indicators.add(renderIndicator(sizeIndicators[i], colorIndicator, opacityIndicators[i], i));
      } else {
        indicators.add(renderIndicator(sizeIndicators[i], colorIndicator, 1, i));
      }
    }
    return indicators;
  }

  Widget renderIndicator(double size, Color? color, double opacity, int index) {
    double space = (spaceBetweenIndicator ?? size) / 2;
    return Container(
      margin: EdgeInsets.only(left: space, right: space),
      child: GestureDetector(
        onTap: () {
          tabController.animateTo(index, curve: curveScroll);
        },
        child: Opacity(
          opacity: opacity,
          child: indicatorWidget ?? renderDefaultDot(size, color),
        ),
      ),
    );
  }

  Widget renderDefaultDot(double size, Color? color) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size / 2)),
      width: size,
      height: size,
    );
  }
}
