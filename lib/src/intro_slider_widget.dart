import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroSlider extends StatefulWidget {
  // ---------- Tabs ----------
  /// An array of ContentConfig
  final List<ContentConfig>? listContentConfig;

  /// Render your own widget list tabs
  final List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  final void Function(int index)? onTabChangeCompleted;

  /// Ref function go to specific tab index
  final void Function(Function function)? refFuncGoToTab;

  /// Background color for all tabs
  final Color? backgroundColorAllTabs;

  // ---------- SKIP button ----------
  /// Render your own widget SKIP button
  final Widget? renderSkipBtn;

  /// Render your own style SKIP button
  final ButtonStyle? skipButtonStyle;

  /// Fire when press SKIP button
  final void Function()? onSkipPress;

  /// Show or hide SKIP button
  final bool? showSkipBtn;

  /// Assign key to SKIP button
  final Key? skipButtonKey;

  // ---------- PREV button ----------
  /// Render your own widget PREV button
  final Widget? renderPrevBtn;

  /// Render your own style PREV button
  final ButtonStyle? prevButtonStyle;

  /// Show or hide PREV button (only visible if skip is hidden)
  final bool? showPrevBtn;

  /// Assign key to PREV button
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

  /// Assign key to NEXT button
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

  /// Assign key to DONE button
  final Key? doneButtonKey;

  // ---------- Indicator ----------
  /// Custom indicators
  final IndicatorConfig? indicatorConfig;

  // ---------- Navigation bar ----------
  /// Custom the position of navigation bar
  final NavigationBarConfig? navigationBarConfig;

  // ---------- Scroll behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool? scrollable;

  /// Determines the physics horizontal scroll for the slides
  final ScrollPhysics? scrollPhysics;

  /// Set transition animation curves (also effect to indicator when it's sliding)
  final Curve? curveScroll;

  /// Enable auto scroll slides
  final bool? autoScroll;

  /// Loop transition by go to first slide when reach the end
  final bool? loopAutoScroll;

  /// Auto scroll will be paused if user touch to slide
  final bool? pauseAutoPlayOnTouch;

  /// Sets duration to determine the frequency of slides
  final Duration? autoScrollInterval;

  // Constructor
  const IntroSlider({
    super.key,
    // Tabs
    this.listContentConfig,
    this.backgroundColorAllTabs,
    this.listCustomTabs,
    this.onTabChangeCompleted,
    this.refFuncGoToTab,

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
    this.indicatorConfig,

    // Navigation bar
    this.navigationBarConfig,

    // Scroll behavior
    this.scrollable,
    this.autoScroll,
    this.loopAutoScroll,
    this.pauseAutoPlayOnTouch,
    this.autoScrollInterval,
    this.curveScroll,
    this.scrollPhysics,
  }) : assert(
          (listContentConfig?.length ?? 0) > 0 || (listCustomTabs?.length ?? 0) > 0,
          "You must define at least listContentConfig or listCustomTabs",
        );

  @override
  IntroSliderState createState() => IntroSliderState();
}

class IntroSliderState extends State<IntroSlider> with SingleTickerProviderStateMixin {
  // ---------- Tabs ----------
  List<Widget>? listCustomTabs;
  Function? onTabChangeCompleted;

  // ---------- SKIP button ----------
  late final Widget renderSkipBtn;
  late final void Function()? onSkipPress;
  late final ButtonStyle skipButtonStyle;
  late final bool showSkipBtn;
  late final Key? skipButtonKey;

  // ---------- PREV button ----------
  late final Widget renderPrevBtn;
  late final ButtonStyle prevButtonStyle;
  late final bool showPrevBtn;
  late final Key? prevButtonKey;

  // ---------- DONE button ----------
  late final Widget renderDoneBtn;
  late final void Function()? onDonePress;
  late final ButtonStyle doneButtonStyle;
  late final bool showDoneBtn;
  late final Key? doneButtonKey;

  // ---------- NEXT button ----------
  late final Widget renderNextBtn;
  late final ButtonStyle nextButtonStyle;
  late final bool showNextBtn;
  late final void Function()? onNextPress;
  late final Key? nextButtonKey;

  // ---------- Indicator ----------
  late final bool isShowIndicator;
  late final Color colorIndicator;
  late final Color colorActiveIndicator;
  late final double sizeIndicator;
  late final double spaceBetweenIndicator;
  late final TypeIndicatorAnimation typeIndicatorAnimation;
  late final Widget? indicatorWidget;
  late final Widget? activeIndicatorWidget;

  // ---------- Scroll behavior ----------
  late final bool scrollable;
  late final ScrollPhysics scrollPhysics;
  late final bool autoScroll;
  late final bool loopAutoScroll;
  late final bool pauseAutoPlayOnTouch;
  late final Duration autoScrollInterval;
  late final Curve curveScroll;

  // ---------- Navigation bar ----------
  /// Custom the position of navigation bar
  late final NavigationBarConfig navigationBarConfig;

  late TabController tabController;

  List<Widget> tabs = [];
  List<Widget> indicators = [];
  List<double> sizeIndicators = [];
  List<double> opacityIndicators = [];

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
    skipButtonKey = widget.skipButtonKey;
    prevButtonKey = widget.prevButtonKey;
    doneButtonKey = widget.doneButtonKey;
    nextButtonKey = widget.nextButtonKey;

    lengthSlide = widget.listContentConfig?.length ?? widget.listCustomTabs?.length ?? 0;
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

    // Indicator
    isShowIndicator = widget.indicatorConfig?.isShowIndicator ?? true;
    colorIndicator = widget.indicatorConfig?.colorIndicator ?? const Color(0x80000000);
    colorActiveIndicator = widget.indicatorConfig?.colorActiveIndicator ?? colorIndicator;
    sizeIndicator = widget.indicatorConfig?.sizeIndicator ?? 8;
    spaceBetweenIndicator = widget.indicatorConfig?.spaceBetweenIndicator ?? sizeIndicator;
    typeIndicatorAnimation = widget.indicatorConfig?.typeIndicatorAnimation ?? TypeIndicatorAnimation.sliding;
    indicatorWidget = widget.indicatorConfig?.indicatorWidget;
    activeIndicatorWidget = widget.indicatorConfig?.activeIndicatorWidget;

    // Navigation bar
    NavigationBarConfig? tempNavigationBarConfig = widget.navigationBarConfig;
    if (tempNavigationBarConfig != null) {
      navigationBarConfig = tempNavigationBarConfig;
    } else {
      navigationBarConfig = NavigationBarConfig();
    }

    double initValueMarginRight = (sizeIndicator + spaceBetweenIndicator) * (lengthSlide - 1);

    switch (typeIndicatorAnimation) {
      case TypeIndicatorAnimation.sliding:
        for (var i = 0; i < lengthSlide; i++) {
          sizeIndicators.add(sizeIndicator);
          opacityIndicators.add(1);
        }
        marginRightIndicatorFocused = initValueMarginRight;
        break;
      case TypeIndicatorAnimation.sizeTransition:
        for (var i = 0; i < lengthSlide; i++) {
          if (i == 0) {
            sizeIndicators.add(sizeIndicator * 1.5);
            opacityIndicators.add(1);
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
            double spaceAvg = (sizeIndicator + spaceBetweenIndicator) / 2;

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
              if (diffValueAnimation < 1) {
                diffValueAnimation = 1;
              }
              sizeIndicators[currentTabIndex] =
                  sizeIndicator * 1.5 - (sizeIndicator / 2) * (1 - (diffValueIndex - diffValueAnimation));
              sizeIndicators[tabController.index] =
                  sizeIndicator + (sizeIndicator / 2) * (1 - (diffValueIndex - diffValueAnimation));
              opacityIndicators[currentTabIndex] = 1 - (diffValueAnimation / diffValueIndex) / 2;
              opacityIndicators[tabController.index] = 0.5 + (diffValueAnimation / diffValueIndex) / 2;
            } else {
              if (animationValue > currentAnimationValue) {
                // Swipe left
                sizeIndicators[currentTabIndex] = sizeIndicator * 1.5 - (sizeIndicator / 2) * diffValueAnimation;
                sizeIndicators[currentTabIndex + 1] = sizeIndicator + (sizeIndicator / 2) * diffValueAnimation;
                opacityIndicators[currentTabIndex] = 1 - diffValueAnimation / 2;
                opacityIndicators[currentTabIndex + 1] = 0.5 + diffValueAnimation / 2;
              } else {
                // Swipe right
                sizeIndicators[currentTabIndex] = sizeIndicator * 1.5 - (sizeIndicator / 2) * diffValueAnimation;
                sizeIndicators[currentTabIndex - 1] = sizeIndicator + (sizeIndicator / 2) * diffValueAnimation;
                opacityIndicators[currentTabIndex] = 1 - diffValueAnimation / 2;
                opacityIndicators[currentTabIndex - 1] = 0.5 + diffValueAnimation / 2;
              }
            }
            break;
        }
      });
    });

    scrollable = widget.scrollable ?? true;
    scrollPhysics = widget.scrollPhysics ?? const ScrollPhysics();

    setupButtonDefaultValues();

    tabs = widget.listCustomTabs ?? renderTabsFromContentConfig(widget.listContentConfig!);
  }

  @override
  void dispose() {
    tabController.dispose();
    clearTimerAutoScroll();
    super.dispose();
  }

  List<Widget> renderTabsFromContentConfig(List<ContentConfig> listContentConfig) {
    List<Widget> tempTabs = [];
    for (var element in listContentConfig) {
      tempTabs.add(
        IntroSliderTab(
          navigationBarConfig: navigationBarConfig,
          contentConfig: element,
        ),
      );
    }
    return tempTabs;
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
            renderNavigationBar(),
          ],
        ),
      ),
      backgroundColor: widget.backgroundColorAllTabs ?? Colors.transparent,
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

  Widget renderNavigationBar() {
    return Positioned(
      top: navigationBarConfig.navPosition == NavPosition.top ? 0 : null,
      bottom: navigationBarConfig.navPosition == NavPosition.bottom ? 0 : null,
      left: 0,
      right: 0,
      child: Container(
        padding: navigationBarConfig.padding,
        color: navigationBarConfig.backgroundColor,
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
      ),
    );
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
        indicators.add(renderIndicators(sizeIndicators[i], colorIndicator, opacityIndicators[i], i));
      } else {
        indicators.add(renderIndicators(sizeIndicators[i], colorIndicator, 1, i));
      }
    }
    return indicators;
  }

  Widget renderIndicators(double size, Color? color, double opacity, int index) {
    double space = spaceBetweenIndicator / 2;
    return Container(
      margin: EdgeInsets.only(left: space, right: space),
      child: GestureDetector(
        onTap: () {
          tabController.animateTo(index, curve: curveScroll);
        },
        child: Opacity(
          opacity: opacity,
          child: indicatorWidget != null ? renderCustomIndicator(size) : renderDefaultDot(size, color),
        ),
      ),
    );
  }

  Widget renderCustomIndicator(double size) {
    return Transform.scale(
      scale: size / sizeIndicator,
      child: indicatorWidget,
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
