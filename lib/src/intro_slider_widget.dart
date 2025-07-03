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
  final bool? isShowSkipBtn;

  /// Assign key to SKIP button
  final Key? skipButtonKey;

  // ---------- PREV button ----------
  /// Render your own widget PREV button
  final Widget? renderPrevBtn;

  /// Render your own style PREV button
  final ButtonStyle? prevButtonStyle;

  /// Show or hide PREV button (only visible if skip is hidden)
  final bool? isShowPrevBtn;

  /// Fire when press PREV button
  final void Function(int index)? onPrevPress;

  /// Assign key to PREV button
  final Key? prevButtonKey;

  // ---------- NEXT button ----------
  /// Render your own widget NEXT button
  final Widget? renderNextBtn;

  /// Render your own style NEXT button
  final ButtonStyle? nextButtonStyle;

  /// Show or hide NEXT button
  final bool? isShowNextBtn;

  /// Fire when press NEXT button
  final Function(int index)? onNextPress;

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
  final bool? isShowDoneBtn;

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
  final bool? isScrollable;

  /// Determines the physics horizontal scroll for the slides
  final ScrollPhysics? scrollPhysics;

  /// Set transition animation curves (also effect to indicator when it's sliding)
  final Curve? curveScroll;

  /// Enable auto scroll slides
  final bool? isAutoScroll;

  /// Loop transition by go to first slide when reach the end
  final bool? isLoopAutoScroll;

  /// Auto scroll will be paused if user touch to slide
  final bool? isPauseAutoPlayOnTouch;

  /// Sets duration to determine the frequency of slides
  final Duration? autoScrollInterval;

  /// Fire when user swipes between slides
  final void Function(int previousIndex, int currentIndex, String direction)?
      onSwipeCompleted;

  // Constructor
  const IntroSlider({
    super.key,
    // Tabs
    this.listContentConfig,
    this.backgroundColorAllTabs,
    this.listCustomTabs,
    this.onTabChangeCompleted,
    this.onSwipeCompleted,
    this.refFuncGoToTab,

    // Skip
    this.renderSkipBtn,
    this.skipButtonStyle,
    this.onSkipPress,
    this.isShowSkipBtn,
    this.skipButtonKey,

    // Prev
    this.renderPrevBtn,
    this.prevButtonStyle,
    this.isShowPrevBtn,
    this.onPrevPress,
    this.prevButtonKey,

    // Done
    this.renderDoneBtn,
    this.onDonePress,
    this.doneButtonStyle,
    this.isShowDoneBtn,
    this.doneButtonKey,

    // Next
    this.renderNextBtn,
    this.nextButtonStyle,
    this.isShowNextBtn,
    this.onNextPress,
    this.nextButtonKey,

    // Indicator
    this.indicatorConfig,

    // Navigation bar
    this.navigationBarConfig,

    // Scroll behavior
    this.isScrollable,
    this.isAutoScroll,
    this.isLoopAutoScroll,
    this.isPauseAutoPlayOnTouch,
    this.autoScrollInterval,
    this.curveScroll,
    this.scrollPhysics,
  }) : assert(
          (listContentConfig?.length ?? 0) > 0 ||
              (listCustomTabs?.length ?? 0) > 0,
          "You must define at least listContentConfig or listCustomTabs",
        );

  @override
  IntroSliderState createState() => IntroSliderState();
}

class IntroSliderState extends State<IntroSlider>
    with TickerProviderStateMixin {
  // ---------- Tabs ----------
  List<ContentConfig>? _listContentConfig;
  List<Widget>? _listCustomTabs;
  Function? _onTabChangeCompleted;
  Function(int previousIndex, int currentIndex, String direction)? _onSwipe;

  // ---------- SKIP button ----------
  late Widget _renderSkipBtn;
  late void Function()? _onSkipPress;
  late ButtonStyle _skipButtonStyle;
  late bool _isShowSkipBtn;
  late final Key? _skipButtonKey;

  // ---------- PREV button ----------
  late Widget _renderPrevBtn;
  late ButtonStyle _prevButtonStyle;
  late bool _isShowPrevBtn;
  late Function(int index)? _onPrevPress;
  late final Key? _prevButtonKey;

  // ---------- DONE button ----------
  late Widget _renderDoneBtn;
  late void Function()? _onDonePress;
  late ButtonStyle _doneButtonStyle;
  late bool _isShowDoneBtn;
  late final Key? _doneButtonKey;

  // ---------- NEXT button ----------
  late Widget _renderNextBtn;
  late ButtonStyle _nextButtonStyle;
  late bool _isShowNextBtn;
  late Function(int index)? _onNextPress;
  late final Key? _nextButtonKey;

  // ---------- Indicator ----------
  late bool _isShowIndicator;
  late Color _colorIndicator;
  late Color _colorActiveIndicator;
  late double _sizeIndicator;
  late double _spaceBetweenIndicator;
  late TypeIndicatorAnimation _typeIndicatorAnimation;
  late Widget? _indicatorWidget;
  late Widget? _activeIndicatorWidget;

  // ---------- Scroll behavior ----------
  late bool _isScrollable;
  late ScrollPhysics _scrollPhysics;
  late bool _isAutoScroll;
  late bool _isLoopAutoScroll;
  late bool _isPauseAutoPlayOnTouch;
  late Duration _autoScrollInterval;
  late Curve _curveScroll;

  // ---------- Navigation bar ----------
  late NavigationBarConfig _navigationBarConfig;

  // ---------- Internal variable  ----------
  late TabController _tabController;

  List<Widget> tabs = [];

  final _streamDecorIndicator = StreamController<TripIndicatorDecoration>();
  final _streamMarginIndicatorFocusing =
      StreamController<PairIndicatorMargin>();
  final _streamCurrentTabIndex = StreamController<int>.broadcast();

  double _currentAnimationValue = 0;
  int _currentTabIndex = 0;
  int _previousTabIndex = 0;
  bool _isProgrammaticNavigation = false;

  late int _lengthSlide;
  late double _widthDevice;
  Timer? _timerAutoScroll;

  @override
  void initState() {
    super.initState();
    _skipButtonKey = widget.skipButtonKey;
    _prevButtonKey = widget.prevButtonKey;
    _doneButtonKey = widget.doneButtonKey;
    _nextButtonKey = widget.nextButtonKey;

    _listContentConfig = widget.listContentConfig != null
        ? [...widget.listContentConfig!]
        : null;
    _listCustomTabs =
        widget.listCustomTabs != null ? [...widget.listCustomTabs!] : null;

    _lengthSlide = _listContentConfig?.length ?? _listCustomTabs?.length ?? 0;
    _isAutoScroll = widget.isAutoScroll ?? false;
    _isLoopAutoScroll = widget.isLoopAutoScroll ?? false;
    _isPauseAutoPlayOnTouch = widget.isPauseAutoPlayOnTouch ?? true;
    _autoScrollInterval =
        widget.autoScrollInterval ?? const Duration(seconds: 4);
    _curveScroll = widget.curveScroll ?? Curves.ease;

    _streamCurrentTabIndex.add(0);
    _onTabChangeCompleted = widget.onTabChangeCompleted;
    _onSwipe = widget.onSwipeCompleted;
    _tabController = TabController(length: _lengthSlide, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _previousTabIndex = _currentTabIndex;
        _currentTabIndex = _tabController.index;
        _streamCurrentTabIndex.add(_currentTabIndex);
        _onTabChangeCompleted?.call(_tabController.index);

        // Detect swipe vs programmatic navigation
        if (!_isProgrammaticNavigation &&
            _previousTabIndex != _currentTabIndex) {
          String direction =
              _currentTabIndex > _previousTabIndex ? 'left' : 'right';
          _onSwipe?.call(_previousTabIndex, _currentTabIndex, direction);
        }

        // Reset programmatic navigation flag
        _isProgrammaticNavigation = false;
      }
      _currentAnimationValue = _tabController.animation?.value ?? 0;
    });

    if (_isAutoScroll) {
      _startTimerAutoScroll();
    }

    // Send reference function goToTab to parent
    widget.refFuncGoToTab?.call(_goToTab);

    // Indicator
    _isShowIndicator = widget.indicatorConfig?.isShowIndicator ?? true;
    _colorIndicator = widget.indicatorConfig?.colorIndicator ?? Colors.black54;
    _colorActiveIndicator =
        widget.indicatorConfig?.colorActiveIndicator ?? _colorIndicator;
    _sizeIndicator = widget.indicatorConfig?.sizeIndicator ?? 8;
    _spaceBetweenIndicator =
        widget.indicatorConfig?.spaceBetweenIndicator ?? _sizeIndicator;
    _typeIndicatorAnimation = widget.indicatorConfig?.typeIndicatorAnimation ??
        TypeIndicatorAnimation.sliding;
    _indicatorWidget = widget.indicatorConfig?.indicatorWidget;
    _activeIndicatorWidget = widget.indicatorConfig?.activeIndicatorWidget;

    // Navigation bar
    NavigationBarConfig? tempNavigationBarConfig = widget.navigationBarConfig;
    if (tempNavigationBarConfig != null) {
      _navigationBarConfig = tempNavigationBarConfig;
    } else {
      _navigationBarConfig = NavigationBarConfig();
    }

    double initValueMarginRight =
        (_sizeIndicator + _spaceBetweenIndicator) * (_lengthSlide - 1);
    List<double> sizeIndicators = [];
    List<double> opacityIndicators = [];
    List<bool> isActives = [];

    switch (_typeIndicatorAnimation) {
      case TypeIndicatorAnimation.sliding:
        for (var i = 0; i < _lengthSlide; i++) {
          sizeIndicators.add(_sizeIndicator);
          opacityIndicators.add(1);
          isActives.add(false);
        }
        _streamMarginIndicatorFocusing
            .add(PairIndicatorMargin(0.0, initValueMarginRight));
        break;
      case TypeIndicatorAnimation.sizeTransition:
        for (var i = 0; i < _lengthSlide; i++) {
          if (i == 0) {
            sizeIndicators.add(_sizeIndicator * 1.5);
            opacityIndicators.add(1);
            isActives.add(true);
          } else {
            sizeIndicators.add(_sizeIndicator);
            opacityIndicators.add(0.5);
            isActives.add(false);
          }
        }
        break;
    }
    _streamDecorIndicator.add(
        TripIndicatorDecoration(sizeIndicators, opacityIndicators, isActives));

    _tabController.animation?.addListener(() {
      if (_tabController.animation == null) return;
      double animationValue = _tabController.animation!.value;
      switch (_typeIndicatorAnimation) {
        case TypeIndicatorAnimation.sliding:
          double spaceAvg = (_sizeIndicator + _spaceBetweenIndicator) / 2;
          double marginLeft = animationValue * spaceAvg * 2;
          double marginRight =
              initValueMarginRight - (animationValue * spaceAvg * 2);
          _streamMarginIndicatorFocusing
              .add(PairIndicatorMargin(marginLeft, marginRight));
          break;
        case TypeIndicatorAnimation.sizeTransition:
          if (animationValue == _currentAnimationValue) {
            break;
          }
          double diffValueAnimation =
              (animationValue - _currentAnimationValue).abs();
          final diffValueIndex =
              (_currentTabIndex - _tabController.index).abs();
          if (_tabController.indexIsChanging &&
              (_tabController.index - _tabController.previousIndex).abs() > 1) {
            // When press skip button
            if (diffValueAnimation < 1) {
              diffValueAnimation = 1;
            }
            sizeIndicators[_currentTabIndex] = _sizeIndicator * 1.5 -
                (_sizeIndicator / 2) *
                    (1 - (diffValueIndex - diffValueAnimation));
            sizeIndicators[_tabController.index] = _sizeIndicator +
                (_sizeIndicator / 2) *
                    (1 - (diffValueIndex - diffValueAnimation));
            opacityIndicators[_currentTabIndex] =
                1 - (diffValueAnimation / diffValueIndex) / 2;
            opacityIndicators[_tabController.index] =
                0.5 + (diffValueAnimation / diffValueIndex) / 2;
            isActives[_currentTabIndex] = false;
            isActives[_tabController.index] = true;
          } else {
            if (animationValue > _currentAnimationValue) {
              // Swipe left
              sizeIndicators[_currentTabIndex] = _sizeIndicator * 1.5 -
                  (_sizeIndicator / 2) * diffValueAnimation;
              sizeIndicators[_currentTabIndex + 1] =
                  _sizeIndicator + (_sizeIndicator / 2) * diffValueAnimation;
              opacityIndicators[_currentTabIndex] = 1 - diffValueAnimation / 2;
              opacityIndicators[_currentTabIndex + 1] =
                  0.5 + diffValueAnimation / 2;
              isActives[_currentTabIndex] = false;
              isActives[_tabController.index] = true;
            } else {
              // Swipe right
              sizeIndicators[_currentTabIndex] = _sizeIndicator * 1.5 -
                  (_sizeIndicator / 2) * diffValueAnimation;
              sizeIndicators[_currentTabIndex - 1] =
                  _sizeIndicator + (_sizeIndicator / 2) * diffValueAnimation;
              opacityIndicators[_currentTabIndex] = 1 - diffValueAnimation / 2;
              opacityIndicators[_currentTabIndex - 1] =
                  0.5 + diffValueAnimation / 2;
              isActives[_currentTabIndex] = false;
              isActives[_tabController.index] = true;
            }
          }
          _streamDecorIndicator.add(TripIndicatorDecoration(
              sizeIndicators, opacityIndicators, isActives));
          break;
      }
    });

    _isScrollable = widget.isScrollable ?? true;
    _scrollPhysics = widget.scrollPhysics ?? const ScrollPhysics();

    _setupButtonDefaultValues();

    tabs = _listCustomTabs ?? _renderTabsFromContentConfig();
  }

  List<Widget> _renderTabsFromContentConfig() {
    List<Widget> tempTabs = [];
    for (var element in _listContentConfig!) {
      tempTabs.add(
        IntroSliderTab(
          navigationBarConfig: _navigationBarConfig,
          contentConfig: element,
        ),
      );
    }
    return tempTabs;
  }

  void _startTimerAutoScroll() {
    _timerAutoScroll = Timer.periodic(_autoScrollInterval, (Timer timer) {
      if (_tabController.index < _lengthSlide - 1) {
        if (!_checkIsAnimating()) {
          _isProgrammaticNavigation = true;
          _tabController.animateTo(_tabController.index + 1,
              curve: _curveScroll);
        }
      } else {
        if (_isLoopAutoScroll) {
          if (!_checkIsAnimating()) {
            _isProgrammaticNavigation = true;
            _tabController.animateTo(0, curve: _curveScroll);
          }
        }
      }
    });
  }

  void _clearTimerAutoScroll() {
    _timerAutoScroll?.cancel();
    _timerAutoScroll = null;
  }

  void _setupButtonDefaultValues() {
    // Skip button
    _onSkipPress = widget.onSkipPress ??
        () {
          if (!_checkIsAnimating()) {
            if (_lengthSlide > 0) {
              _isProgrammaticNavigation = true;
              _tabController.animateTo(_lengthSlide - 1, curve: _curveScroll);
            }
          }
        };
    _isShowSkipBtn = widget.isShowSkipBtn ?? true;
    _renderSkipBtn = widget.renderSkipBtn ?? const Text("SKIP");
    _skipButtonStyle = widget.skipButtonStyle ?? const ButtonStyle();

    // Prev button
    if (_isShowSkipBtn) {
      _isShowPrevBtn = false;
    } else {
      _isShowPrevBtn = widget.isShowPrevBtn ?? true;
    }

    _onPrevPress = widget.onPrevPress ?? (index) {};
    _renderPrevBtn = widget.renderPrevBtn ?? const Text("PREV");
    _prevButtonStyle = widget.prevButtonStyle ?? const ButtonStyle();

    _isShowNextBtn = widget.isShowNextBtn ?? true;

    // Done button
    _onDonePress = widget.onDonePress ?? () {};
    _renderDoneBtn = widget.renderDoneBtn ?? const Text("DONE");
    _doneButtonStyle = widget.doneButtonStyle ?? const ButtonStyle();
    _isShowDoneBtn = widget.isShowDoneBtn ?? true;

    // Next button
    _onNextPress = widget.onNextPress ?? (index) {};
    _renderNextBtn = widget.renderNextBtn ?? const Text("NEXT");
    _nextButtonStyle = widget.nextButtonStyle ?? const ButtonStyle();
  }

  void _goToTab(int index) {
    if (index < _tabController.length) {
      _isProgrammaticNavigation = true;
      _tabController.animateTo(index, curve: _curveScroll);
    }
  }

  bool _checkIsAnimating() {
    Animation<double>? animation = _tabController.animation;
    if (animation != null) {
      return animation.value - animation.value.truncate() != 0;
    } else {
      return false;
    }
  }

  bool _checkIsRTLLanguage(String language) {
    return IntroSliderConfig.rtlLanguages.contains(language);
  }

  void _reinitializeIndicatorStreams() {
    double initValueMarginRight =
        (_sizeIndicator + _spaceBetweenIndicator) * (_lengthSlide - 1);
    List<double> sizeIndicators = [];
    List<double> opacityIndicators = [];
    List<bool> isActives = [];

    switch (_typeIndicatorAnimation) {
      case TypeIndicatorAnimation.sliding:
        for (var i = 0; i < _lengthSlide; i++) {
          sizeIndicators.add(_sizeIndicator);
          opacityIndicators.add(1);
          isActives.add(false);
        }
        _streamMarginIndicatorFocusing
            .add(PairIndicatorMargin(0.0, initValueMarginRight));
        break;
      case TypeIndicatorAnimation.sizeTransition:
        for (var i = 0; i < _lengthSlide; i++) {
          if (i == 0) {
            sizeIndicators.add(_sizeIndicator * 1.5);
            opacityIndicators.add(1);
            isActives.add(true);
          } else {
            sizeIndicators.add(_sizeIndicator);
            opacityIndicators.add(0.5);
            isActives.add(false);
          }
        }
        break;
    }
    _streamDecorIndicator.add(
        TripIndicatorDecoration(sizeIndicators, opacityIndicators, isActives));
  }

  @override
  Widget build(BuildContext context) {
    _widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DefaultTabController(
        length: _lengthSlide,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTapDown: (a) {
                if (_isPauseAutoPlayOnTouch) {
                  _clearTimerAutoScroll();
                }
              },
              onTapUp: (a) {
                if (_isAutoScroll && _isPauseAutoPlayOnTouch) {
                  _startTimerAutoScroll();
                }
              },
              onTapCancel: () {
                if (_isAutoScroll && _isPauseAutoPlayOnTouch) {
                  _startTimerAutoScroll();
                }
              },
              child: TabBarView(
                controller: _tabController,
                physics: _isScrollable
                    ? _scrollPhysics
                    : const NeverScrollableScrollPhysics(),
                children: tabs,
              ),
            ),
            _buildNavigationBar(),
          ],
        ),
      ),
      backgroundColor: widget.backgroundColorAllTabs ?? Colors.transparent,
    );
  }

  Widget _buildNavigationBar() {
    return Positioned(
      top: _navigationBarConfig.navPosition == NavPosition.top ? 0 : null,
      bottom: _navigationBarConfig.navPosition == NavPosition.bottom ? 0 : null,
      left: 0,
      right: 0,
      child: Container(
        padding: _navigationBarConfig.padding,
        color: _navigationBarConfig.backgroundColor,
        child: Row(
          children: <Widget>[
            // Skip button
            StreamBuilder<int>(
                stream: _streamCurrentTabIndex.stream,
                builder: (context, snapshot) {
                  int currentTabIndex = snapshot.data ?? 0;
                  return Container(
                    alignment: Alignment.center,
                    width: _widthDevice / 4,
                    child: _isShowSkipBtn
                        ? _buildSkipButton(currentTabIndex)
                        : (_isShowPrevBtn
                            ? _buildPrevButton(currentTabIndex)
                            : const SizedBox.shrink()),
                  );
                }),

            // Indicator
            Flexible(
              child: _isShowIndicator
                  ? Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        _buildListIndicator(),
                        _typeIndicatorAnimation ==
                                TypeIndicatorAnimation.sliding
                            ? _buildActiveIndicator()
                            : const SizedBox.shrink()
                      ],
                    )
                  : const SizedBox.shrink(),
            ),

            // Next, Done button
            StreamBuilder<int>(
                stream: _streamCurrentTabIndex.stream,
                builder: (context, snapshot) {
                  int currentTabIndex = snapshot.data ?? 0;
                  return Container(
                    alignment: Alignment.center,
                    width: _widthDevice / 4,
                    height: 50,
                    child: currentTabIndex + 1 == _lengthSlide
                        ? _isShowDoneBtn
                            ? _buildDoneButton()
                            : const SizedBox.shrink()
                        : _isShowNextBtn
                            ? _buildNextButton()
                            : const SizedBox.shrink(),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton(currentTabIndex) {
    if (currentTabIndex + 1 == _lengthSlide) {
      return Container(width: _widthDevice / 4);
    } else {
      return TextButton(
        key: _skipButtonKey,
        onPressed: _onSkipPress,
        style: _skipButtonStyle,
        child: _renderSkipBtn,
      );
    }
  }

  Widget _buildPrevButton(currentTabIndex) {
    if (currentTabIndex == 0) {
      return Container(width: _widthDevice / 4);
    } else {
      return TextButton(
        key: _prevButtonKey,
        onPressed: () {
          if (_checkIsAnimating()) return;
          final targetIndex = _tabController.index - 1;
          _onPrevPress?.call(targetIndex);
          _isProgrammaticNavigation = true;
          _tabController.animateTo(targetIndex, curve: _curveScroll);
        },
        style: _prevButtonStyle,
        child: _renderPrevBtn,
      );
    }
  }

  Widget _buildDoneButton() {
    return TextButton(
      key: _doneButtonKey,
      onPressed: _onDonePress,
      style: _doneButtonStyle,
      child: _renderDoneBtn,
    );
  }

  Widget _buildNextButton() {
    return TextButton(
      key: _nextButtonKey,
      onPressed: () {
        if (_checkIsAnimating()) return;
        final targetIndex = _tabController.index + 1;
        _onNextPress?.call(targetIndex);
        _isProgrammaticNavigation = true;
        _tabController.animateTo(targetIndex, curve: _curveScroll);
      },
      style: _nextButtonStyle,
      child: _renderNextBtn,
    );
  }

  Widget _buildActiveIndicator() {
    return StreamBuilder<PairIndicatorMargin>(
      stream: _streamMarginIndicatorFocusing.stream,
      builder: (context, snapshot) {
        var pairIndicatorMargin = snapshot.data;
        if (pairIndicatorMargin == null) return const SizedBox.shrink();
        return Container(
          margin: EdgeInsets.only(
            left: _checkIsRTLLanguage(
                    Localizations.localeOf(context).languageCode)
                ? pairIndicatorMargin.right
                : pairIndicatorMargin.left,
            right: _checkIsRTLLanguage(
                    Localizations.localeOf(context).languageCode)
                ? pairIndicatorMargin.left
                : pairIndicatorMargin.right,
          ),
          child: _activeIndicatorWidget ??
              _indicatorWidget ??
              _buildDefaultDot(
                  size: _sizeIndicator, color: _colorActiveIndicator),
        );
      },
    );
  }

  Widget _buildListIndicator() {
    return StreamBuilder<TripIndicatorDecoration>(
      stream: _streamDecorIndicator.stream,
      builder: (context, snapshot) {
        var tripIndicatorDecoration = snapshot.data;
        if (tripIndicatorDecoration == null) return const SizedBox.shrink();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _generateListIndicator(
            tripIndicatorDecoration.opacities,
            tripIndicatorDecoration.sizes,
            tripIndicatorDecoration.isActives,
          ),
        );
      },
    );
  }

  List<Widget> _generateListIndicator(
    List<double> opacityIndicators,
    List<double> sizeIndicators,
    List<bool> isActiveIndicators,
  ) {
    List<Widget> indicators = [];
    for (var i = 0; i < _lengthSlide; i++) {
      double opacityCurrentIndicator = opacityIndicators[i];
      if (opacityCurrentIndicator >= 0 &&
          opacityCurrentIndicator <= 1 &&
          _colorActiveIndicator == _colorIndicator) {
        indicators.add(
          _buildOpacityIndicator(
            size: sizeIndicators[i],
            color: _colorIndicator,
            opacity: opacityIndicators[i],
            index: i,
          ),
        );
      } else {
        indicators.add(
          _buildIndicator(
            size: sizeIndicators[i],
            color: _colorIndicator,
            colorActive: _colorActiveIndicator,
            isActive: isActiveIndicators[i],
            index: i,
          ),
        );
      }
    }
    return indicators;
  }

  Widget _buildIndicator({
    required double size,
    required Color color,
    required Color colorActive,
    required bool isActive,
    required int index,
  }) {
    double space = _spaceBetweenIndicator / 2;
    return Container(
      margin: EdgeInsets.only(left: space, right: space),
      child: GestureDetector(
        onTap: () {
          _isProgrammaticNavigation = true;
          _tabController.animateTo(index, curve: _curveScroll);
        },
        child: _indicatorWidget != null
            ? _buildCustomIndicator(
                currentSize: size,
                originSize: _sizeIndicator,
                child: _indicatorWidget!)
            : _buildDefaultDot(
                size: size, color: isActive ? colorActive : color),
      ),
    );
  }

  Widget _buildOpacityIndicator({
    required double size,
    required Color color,
    required double opacity,
    required int index,
  }) {
    double space = _spaceBetweenIndicator / 2;
    return Container(
      margin: EdgeInsets.only(left: space, right: space),
      child: GestureDetector(
        onTap: () {
          _isProgrammaticNavigation = true;
          _tabController.animateTo(index, curve: _curveScroll);
        },
        child: Opacity(
          opacity: opacity,
          child: _indicatorWidget != null
              ? _buildCustomIndicator(
                  currentSize: size,
                  originSize: _sizeIndicator,
                  child: _indicatorWidget!)
              : _buildDefaultDot(size: size, color: color),
        ),
      ),
    );
  }

  Widget _buildCustomIndicator(
      {required double currentSize,
      required double originSize,
      required Widget child}) {
    return Transform.scale(
      scale: currentSize / originSize,
      child: child,
    );
  }

  Widget _buildDefaultDot({required double size, Color? color}) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(size / 2)),
      width: size,
      height: size,
    );
  }

  @override
  void didUpdateWidget(covariant IntroSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    bool needsRebuild = false;

    // Check if tabs content changed
    if (_listContentConfig != widget.listContentConfig ||
        _listCustomTabs != widget.listCustomTabs) {
      _listContentConfig = widget.listContentConfig != null
          ? [...widget.listContentConfig!]
          : null;
      _listCustomTabs =
          widget.listCustomTabs != null ? [...widget.listCustomTabs!] : null;

      // Update length if it changed
      int newLengthSlide = widget.listContentConfig?.length ??
          widget.listCustomTabs?.length ??
          0;
      if (newLengthSlide != _lengthSlide) {
        _lengthSlide = newLengthSlide;

        // Recreate tab controller with new length
        _tabController.dispose();
        _tabController = TabController(length: _lengthSlide, vsync: this);
        _tabController.addListener(() {
          if (!_tabController.indexIsChanging) {
            _previousTabIndex = _currentTabIndex;
            _currentTabIndex = _tabController.index;
            _streamCurrentTabIndex.add(_currentTabIndex);
            _onTabChangeCompleted?.call(_tabController.index);

            // Detect swipe vs programmatic navigation
            if (!_isProgrammaticNavigation &&
                _previousTabIndex != _currentTabIndex) {
              String direction =
                  _currentTabIndex > _previousTabIndex ? 'left' : 'right';
              _onSwipe?.call(_previousTabIndex, _currentTabIndex, direction);
            }

            // Reset programmatic navigation flag
            _isProgrammaticNavigation = false;
          }
          _currentAnimationValue = _tabController.animation?.value ?? 0;
        });

        // Add animation listener for indicators
        _tabController.animation?.addListener(() {
          if (_tabController.animation == null) return;
          double animationValue = _tabController.animation!.value;
          switch (_typeIndicatorAnimation) {
            case TypeIndicatorAnimation.sliding:
              double spaceAvg = (_sizeIndicator + _spaceBetweenIndicator) / 2;
              double marginLeft = animationValue * spaceAvg * 2;
              double marginRight = (_sizeIndicator + _spaceBetweenIndicator) *
                      (_lengthSlide - 1) -
                  (animationValue * spaceAvg * 2);
              _streamMarginIndicatorFocusing
                  .add(PairIndicatorMargin(marginLeft, marginRight));
              break;
            case TypeIndicatorAnimation.sizeTransition:
              if (animationValue == _currentAnimationValue) {
                break;
              }
              double diffValueAnimation =
                  (animationValue - _currentAnimationValue).abs();
              final diffValueIndex =
                  (_currentTabIndex - _tabController.index).abs();
              List<double> sizeIndicators =
                  List.generate(_lengthSlide, (index) => _sizeIndicator);
              List<double> opacityIndicators =
                  List.generate(_lengthSlide, (index) => 0.5);
              List<bool> isActives =
                  List.generate(_lengthSlide, (index) => false);

              if (_tabController.indexIsChanging &&
                  (_tabController.index - _tabController.previousIndex).abs() >
                      1) {
                // When press skip button
                if (diffValueAnimation < 1) {
                  diffValueAnimation = 1;
                }
                sizeIndicators[_currentTabIndex] = _sizeIndicator * 1.5 -
                    (_sizeIndicator / 2) *
                        (1 - (diffValueIndex - diffValueAnimation));
                sizeIndicators[_tabController.index] = _sizeIndicator +
                    (_sizeIndicator / 2) *
                        (1 - (diffValueIndex - diffValueAnimation));
                opacityIndicators[_currentTabIndex] =
                    1 - (diffValueAnimation / diffValueIndex) / 2;
                opacityIndicators[_tabController.index] =
                    0.5 + (diffValueAnimation / diffValueIndex) / 2;
                isActives[_currentTabIndex] = false;
                isActives[_tabController.index] = true;
              } else {
                if (animationValue > _currentAnimationValue) {
                  // Swipe left
                  if (_currentTabIndex + 1 < _lengthSlide) {
                    sizeIndicators[_currentTabIndex] = _sizeIndicator * 1.5 -
                        (_sizeIndicator / 2) * diffValueAnimation;
                    sizeIndicators[_currentTabIndex + 1] = _sizeIndicator +
                        (_sizeIndicator / 2) * diffValueAnimation;
                    opacityIndicators[_currentTabIndex] =
                        1 - diffValueAnimation / 2;
                    opacityIndicators[_currentTabIndex + 1] =
                        0.5 + diffValueAnimation / 2;
                    isActives[_currentTabIndex] = false;
                    isActives[_tabController.index] = true;
                  }
                } else {
                  // Swipe right
                  if (_currentTabIndex - 1 >= 0) {
                    sizeIndicators[_currentTabIndex] = _sizeIndicator * 1.5 -
                        (_sizeIndicator / 2) * diffValueAnimation;
                    sizeIndicators[_currentTabIndex - 1] = _sizeIndicator +
                        (_sizeIndicator / 2) * diffValueAnimation;
                    opacityIndicators[_currentTabIndex] =
                        1 - diffValueAnimation / 2;
                    opacityIndicators[_currentTabIndex - 1] =
                        0.5 + diffValueAnimation / 2;
                    isActives[_currentTabIndex] = false;
                    isActives[_tabController.index] = true;
                  }
                }
              }
              _streamDecorIndicator.add(TripIndicatorDecoration(
                  sizeIndicators, opacityIndicators, isActives));
              break;
          }
        });

        // Reset current tab index if it's out of bounds
        if (_currentTabIndex >= _lengthSlide) {
          _currentTabIndex = _lengthSlide > 0 ? _lengthSlide - 1 : 0;
          _streamCurrentTabIndex.add(_currentTabIndex);
        }

        // Reinitialize indicator streams with new length
        _reinitializeIndicatorStreams();
      }

      tabs = _listCustomTabs ?? _renderTabsFromContentConfig();
      needsRebuild = true;
    }

    // Update button configurations
    if (oldWidget.renderSkipBtn != widget.renderSkipBtn ||
        oldWidget.skipButtonStyle != widget.skipButtonStyle ||
        oldWidget.onSkipPress != widget.onSkipPress ||
        oldWidget.isShowSkipBtn != widget.isShowSkipBtn ||
        oldWidget.renderPrevBtn != widget.renderPrevBtn ||
        oldWidget.prevButtonStyle != widget.prevButtonStyle ||
        oldWidget.onPrevPress != widget.onPrevPress ||
        oldWidget.isShowPrevBtn != widget.isShowPrevBtn ||
        oldWidget.renderNextBtn != widget.renderNextBtn ||
        oldWidget.nextButtonStyle != widget.nextButtonStyle ||
        oldWidget.onNextPress != widget.onNextPress ||
        oldWidget.isShowNextBtn != widget.isShowNextBtn ||
        oldWidget.renderDoneBtn != widget.renderDoneBtn ||
        oldWidget.doneButtonStyle != widget.doneButtonStyle ||
        oldWidget.onDonePress != widget.onDonePress ||
        oldWidget.isShowDoneBtn != widget.isShowDoneBtn) {
      _setupButtonDefaultValues();
      needsRebuild = true;
    }

    // Update auto scroll behavior
    if (oldWidget.isAutoScroll != widget.isAutoScroll ||
        oldWidget.isLoopAutoScroll != widget.isLoopAutoScroll ||
        oldWidget.isPauseAutoPlayOnTouch != widget.isPauseAutoPlayOnTouch ||
        oldWidget.autoScrollInterval != widget.autoScrollInterval) {
      _clearTimerAutoScroll();

      // Update auto scroll properties (need to make these non-final)
      _isAutoScroll = widget.isAutoScroll ?? false;
      _isLoopAutoScroll = widget.isLoopAutoScroll ?? false;
      _isPauseAutoPlayOnTouch = widget.isPauseAutoPlayOnTouch ?? true;
      _autoScrollInterval =
          widget.autoScrollInterval ?? const Duration(seconds: 4);

      if (_isAutoScroll) {
        _startTimerAutoScroll();
      }
      needsRebuild = true;
    }

    // Update scroll behavior
    if (oldWidget.isScrollable != widget.isScrollable ||
        oldWidget.scrollPhysics != widget.scrollPhysics ||
        oldWidget.curveScroll != widget.curveScroll) {
      _isScrollable = widget.isScrollable ?? true;
      _scrollPhysics = widget.scrollPhysics ?? const ScrollPhysics();
      _curveScroll = widget.curveScroll ?? Curves.ease;
      needsRebuild = true;
    }

    // Update indicator configuration
    if (oldWidget.indicatorConfig != widget.indicatorConfig) {
      _isShowIndicator = widget.indicatorConfig?.isShowIndicator ?? true;
      _colorIndicator =
          widget.indicatorConfig?.colorIndicator ?? Colors.black54;
      _colorActiveIndicator =
          widget.indicatorConfig?.colorActiveIndicator ?? _colorIndicator;
      _sizeIndicator = widget.indicatorConfig?.sizeIndicator ?? 8;
      _spaceBetweenIndicator =
          widget.indicatorConfig?.spaceBetweenIndicator ?? _sizeIndicator;
      _typeIndicatorAnimation =
          widget.indicatorConfig?.typeIndicatorAnimation ??
              TypeIndicatorAnimation.sliding;
      _indicatorWidget = widget.indicatorConfig?.indicatorWidget;
      _activeIndicatorWidget = widget.indicatorConfig?.activeIndicatorWidget;
      needsRebuild = true;
    }

    // Update navigation bar configuration
    if (oldWidget.navigationBarConfig != widget.navigationBarConfig) {
      NavigationBarConfig? tempNavigationBarConfig = widget.navigationBarConfig;
      if (tempNavigationBarConfig != null) {
        _navigationBarConfig = tempNavigationBarConfig;
      } else {
        _navigationBarConfig = NavigationBarConfig();
      }
      needsRebuild = true;
    }

    // Update callback
    if (oldWidget.onTabChangeCompleted != widget.onTabChangeCompleted) {
      _onTabChangeCompleted = widget.onTabChangeCompleted;
      needsRebuild = true;
    }

    // Update swipe callback
    if (oldWidget.onSwipeCompleted != widget.onSwipeCompleted) {
      _onSwipe = widget.onSwipeCompleted;
      needsRebuild = true;
    }

    // Update reference function
    if (oldWidget.refFuncGoToTab != widget.refFuncGoToTab) {
      widget.refFuncGoToTab?.call(_goToTab);
    }

    // Trigger rebuild if any changes detected
    if (needsRebuild ||
        oldWidget.backgroundColorAllTabs != widget.backgroundColorAllTabs) {
      setState(() {
        // State is updated in the logic above
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _streamDecorIndicator.close();
    _streamMarginIndicatorFocusing.close();
    _streamCurrentTabIndex.close();
    _clearTimerAutoScroll();
    super.dispose();
  }
}
