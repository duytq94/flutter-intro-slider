import 'package:flutter/material.dart';

class IntroSlider extends StatefulWidget {
  /// An array of Slide object
  final List<Slide> slides;

  // SKIP button
  /// Render your own SKIP button
  final Widget renderSkipBtn;

  /// Fire when press SKIP button
  final Function onSkipPress;

  /// Change SKIP to any text you want
  final String nameSkipBtn;

  /// Style for text at SKIP button
  final TextStyle styleNameSkipBtn;

  /// Color for SKIP button
  final Color colorSkipBtn;

  /// Color for Skip button when press
  final Color highlightColorSkipBtn;

  /// Show or hide SKIP button
  final bool isShowSkipBtn;

  /// Rounded SKIP button
  final double borderRadiusSkipBtn;

  // NEXT, DONE button
  /// Render your own NEXT button
  final Widget renderNextBtn;

  /// Render your own DONE button
  final Widget renderDoneBtn;

  /// Fire when press DONE button
  final Function onDonePress;

  /// Change NEXT to any text you want
  final String nameNextBtn;

  /// Change DONE to any text you want
  final String nameDoneBtn;

  /// Style for text at DONE button
  final TextStyle styleNameDoneBtn;

  /// Color for DONE button
  final Color colorDoneBtn;

  /// Color for DONE button when press
  final Color highlightColorDoneBtn;

  /// Rounded NEXT button
  final double borderRadiusNextBtn;

  /// Rounded DONE button
  final double borderRadiusDoneBtn;

  // Dot indicator
  /// Show or hide dot indicator
  final bool isShowDotIndicator;

  /// Color for dot when passive
  final Color colorDot;

  /// Color for dot when active
  final Color colorActiveDot;

  /// Size of each dot
  final double sizeDot;

  // Constructor
  IntroSlider({
    @required this.slides,
    this.renderSkipBtn,
    this.onSkipPress,
    this.nameSkipBtn,
    this.styleNameSkipBtn,
    this.colorSkipBtn,
    this.highlightColorSkipBtn,
    this.isShowSkipBtn,
    this.borderRadiusSkipBtn,
    this.renderNextBtn,
    this.renderDoneBtn,
    this.onDonePress,
    this.nameNextBtn,
    this.nameDoneBtn,
    this.styleNameDoneBtn,
    this.colorDoneBtn,
    this.highlightColorDoneBtn,
    this.borderRadiusNextBtn,
    this.borderRadiusDoneBtn,
    this.isShowDotIndicator,
    this.colorDot,
    this.colorActiveDot,
    this.sizeDot,
  });

  @override
  IntroSliderState createState() => new IntroSliderState(
        slides: this.slides,
        renderSkipBtn: this.renderSkipBtn,
        onSkipPress: this.onSkipPress,
        nameSkipBtn: this.nameSkipBtn,
        styleNameSkipBtn: this.styleNameSkipBtn,
        colorSkipBtn: this.colorSkipBtn,
        highlightColorSkipBtn: this.highlightColorSkipBtn,
        isShowSkipBtn: this.isShowSkipBtn,
        borderRadiusSkipBtn: this.borderRadiusSkipBtn,
        renderNextBtn: this.renderNextBtn,
        renderDoneBtn: this.renderDoneBtn,
        onDonePress: this.onDonePress,
        nameNextBtn: this.nameNextBtn,
        nameDoneBtn: this.nameDoneBtn,
        styleNameDoneBtn: this.styleNameDoneBtn,
        colorDoneBtn: this.colorDoneBtn,
        highlightColorDoneBtn: this.highlightColorDoneBtn,
        borderRadiusNextBtn: this.borderRadiusNextBtn,
        borderRadiusDoneBtn: this.borderRadiusDoneBtn,
        isShowDotIndicator: this.isShowDotIndicator,
        colorDot: this.colorDot,
        colorActiveDot: this.colorActiveDot,
        sizeDot: this.sizeDot,
      );
}

class IntroSliderState extends State<IntroSlider>
    with SingleTickerProviderStateMixin {
  /// An array of Slide object
  final List<Slide> slides;

  // SKIP button
  /// Render your own SKIP button
  Widget renderSkipBtn;

  /// Fire when press SKIP button
  Function onSkipPress;

  /// Change SKIP to any text you want
  String nameSkipBtn;

  /// Style for text at SKIP button
  TextStyle styleNameSkipBtn;

  /// Color for SKIP button
  Color colorSkipBtn;

  /// Color for SKIP button when press
  Color highlightColorSkipBtn;

  /// Show or hide SKIP button
  bool isShowSkipBtn;

  /// Rounded SKIP button
  double borderRadiusSkipBtn;

  // DONE, NEXT button
  /// Render your own NEXT button
  Widget renderNextBtn;

  /// Render your own DONE button
  Widget renderDoneBtn;

  /// Fire when press DONE button
  Function onDonePress;

  /// Change NEXT to any text you want
  String nameNextBtn;

  /// Change DONE to any text you want
  String nameDoneBtn;

  /// Style for text at DONE button
  TextStyle styleNameDoneBtn;

  /// Color for DONE button
  Color colorDoneBtn;

  /// Color for DONE button when press
  Color highlightColorDoneBtn;

  /// Rounded NEXT button
  double borderRadiusNextBtn;

  /// Rounded DONE button
  double borderRadiusDoneBtn;

  // Dot indicator
  /// Show or hide dot indicator
  bool isShowDotIndicator = true;

  /// Color for dot when passive
  Color colorDot;

  /// Color for dot when active
  Color colorActiveDot;

  /// Size of each dot
  double sizeDot = 8.0;

  // Constructor
  IntroSliderState({
    // List slides
    @required this.slides,

    // Skip button
    @required this.renderSkipBtn,
    @required this.onSkipPress,
    @required this.nameSkipBtn,
    @required this.styleNameSkipBtn,
    @required this.colorSkipBtn,
    @required this.highlightColorSkipBtn,
    @required this.isShowSkipBtn,
    @required this.borderRadiusSkipBtn,

    // Done button
    @required this.renderNextBtn,
    @required this.renderDoneBtn,
    @required this.onDonePress,
    @required this.nameNextBtn,
    @required this.nameDoneBtn,
    @required this.styleNameDoneBtn,
    @required this.colorDoneBtn,
    @required this.highlightColorDoneBtn,
    @required this.borderRadiusNextBtn,
    @required this.borderRadiusDoneBtn,

    // Dot indicator
    @required this.isShowDotIndicator,
    @required this.colorDot,
    @required this.colorActiveDot,
    @required this.sizeDot,
  });

  TabController tabController;

  List<Widget> tabs = new List();
  List<Widget> dots = new List();

  @override
  void initState() {
    super.initState();

    tabController = new TabController(length: slides.length, vsync: this);
    tabController.addListener(() {
      // To change dot color
      this.setState(() {});
    });

    // Skip button
    if (onSkipPress == null) {
      onSkipPress = () {};
    }
    if (isShowSkipBtn == null) {
      isShowSkipBtn = true;
    }

    // Done button
    if (onDonePress == null) {
      onDonePress = () {};
    }

    // Dot indicator
    if (isShowDotIndicator == null) {
      isShowDotIndicator = true;
    }
    if (colorDot == null) {
      colorDot = Color(0x80000000);
    }
    if (colorActiveDot == null) {
      colorActiveDot = Color(0xffffffff);
    }
    if (sizeDot == null) {
      sizeDot = 8.0;
    }

    renderListTabs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: slides.length,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              TabBarView(
                children: tabs,
                controller: tabController,
              ),
              renderBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderBottom() {
    return Positioned(
      child: Row(
        children: <Widget>[
          // Skip button
          (tabController.index + 1 != slides.length && isShowSkipBtn)
              ? Container(
                  child: renderSkipBtn != null
                      ? FlatButton(
                          child: renderSkipBtn,
                          onPressed: onSkipPress,
                          color: colorSkipBtn != null
                              ? colorSkipBtn
                              : Colors.transparent,
                          highlightColor: highlightColorSkipBtn != null
                              ? highlightColorSkipBtn
                              : Colors.white.withOpacity(0.3),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  borderRadiusSkipBtn ?? 30.0)),
                        )
                      : FlatButton(
                          onPressed: onSkipPress,
                          child: Text(
                            nameSkipBtn ?? "SKIP",
                            style: styleNameSkipBtn ??
                                TextStyle(color: Colors.white),
                          ),
                          color: colorSkipBtn != null
                              ? colorSkipBtn
                              : Colors.transparent,
                          highlightColor: highlightColorSkipBtn != null
                              ? highlightColorSkipBtn
                              : Colors.white.withOpacity(0.3),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  borderRadiusSkipBtn ?? 30.0)),
                        ),
                  width: 70.0,
                  height: 70.0,
                )
              : Container(
                  width: 80.0,
                  height: 70.0,
                ),

          // Dot indicator
          Flexible(
            child: isShowDotIndicator
                ? Row(
                    children: renderListDots(),
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                : Container(),
          ),

          // Next, Done button
          Container(
            child: tabController.index + 1 == slides.length
                ? (renderDoneBtn != null
                    ? FlatButton(
                        child: renderDoneBtn,
                        onPressed: onDonePress,
                        color: colorDoneBtn != null
                            ? colorDoneBtn
                            : Colors.transparent,
                        highlightColor: highlightColorDoneBtn != null
                            ? highlightColorDoneBtn
                            : Colors.white.withOpacity(0.3),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                borderRadiusDoneBtn ?? 30.0)),
                      )
                    : FlatButton(
                        onPressed: onDonePress,
                        child: Text(
                          nameDoneBtn ?? "DONE",
                          style: styleNameDoneBtn ??
                              TextStyle(color: Colors.white),
                        ),
                        color: colorDoneBtn != null
                            ? colorDoneBtn
                            : Colors.transparent,
                        highlightColor: highlightColorDoneBtn != null
                            ? highlightColorDoneBtn
                            : Colors.white.withOpacity(0.3),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                borderRadiusDoneBtn ?? 30.0)),
                      ))
                : (renderNextBtn != null
                    ? FlatButton(
                        onPressed: () {
                          tabController.animateTo(tabController.index + 1);
                        },
                        child: renderNextBtn,
                        color: colorDoneBtn != null
                            ? colorDoneBtn
                            : Colors.transparent,
                        highlightColor: highlightColorDoneBtn != null
                            ? highlightColorDoneBtn
                            : Colors.white.withOpacity(0.3),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                borderRadiusNextBtn ?? 30.0)),
                      )
                    : FlatButton(
                        onPressed: () {
                          tabController.animateTo(tabController.index + 1);
                        },
                        child: Text(
                          nameNextBtn ?? "NEXT",
                          style: styleNameDoneBtn ??
                              TextStyle(color: Colors.white),
                        ),
                        color: colorDoneBtn != null
                            ? colorDoneBtn
                            : Colors.transparent,
                        highlightColor: highlightColorDoneBtn != null
                            ? highlightColorDoneBtn
                            : Colors.white.withOpacity(0.3),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                borderRadiusNextBtn ?? 30.0)),
                      )),
            width: 80.0,
            height: 70.0,
          ),
        ],
      ),
      bottom: 10.0,
      left: 10.0,
      right: 10.0,
      height: 50.0,
    );
  }

  List<Widget> renderListTabs() {
    for (int i = 0; i < slides.length; i++) {
      tabs.add(
        renderTab(
          slides[i].title,
          slides[i].maxLineTitle,
          slides[i].styleTitle,
          slides[i].marginTitle,
          slides[i].description,
          slides[i].maxLineTextDescription,
          slides[i].styleDescription,
          slides[i].marginDescription,
          slides[i].pathImage,
          slides[i].widthImage,
          slides[i].heightImage,
          slides[i].onCenterItemPress,
          slides[i].centerWidget,
          slides[i].backgroundColor,
          slides[i].colorBegin,
          slides[i].colorEnd,
          slides[i].directionColorBegin,
          slides[i].directionColorEnd,
        ),
      );
    }
    return tabs;
  }

  Widget renderTab(
    // Title
    String title,
    int maxLineTitle,
    TextStyle styleTitle,
    EdgeInsets marginTitle,

    // Description
    String description,
    int maxLineTextDescription,
    TextStyle styleDescription,
    EdgeInsets marginDescription,

    // Image
    String pathImage,
    double widthImage,
    double heightImage,
    Function onCenterItemPress,
    
    // Center Widget
    Widget centerWidget,
    
    // Background color
    Color backgroundColor,
    Color colorBegin,
    Color colorEnd,
    AlignmentGeometry directionColorBegin,
    AlignmentGeometry directionColorEnd,
  ) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundColor != null
              ? [backgroundColor, backgroundColor]
              : [colorBegin, colorEnd],
          begin: directionColorBegin ?? Alignment.topLeft,
          end: directionColorEnd ?? Alignment.bottomRight,
        ),
      ),
      child: ListView(
        children: <Widget>[
          Container(
            // Title
            child: Text(
              title ?? "",
              style: styleTitle ??
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
              maxLines: maxLineTitle != null ? maxLineTitle : 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            margin: marginTitle ??
                EdgeInsets.only(top: 70.0, bottom: 50.0, left: 20, right: 20),
          ),

          // Image or Center Widget
          GestureDetector(
            child: pathImage != null
                ? Image.asset(
                    pathImage,
                    width: widthImage ?? 250.0,
                    height: heightImage ?? 250.0,
                    fit: BoxFit.contain,
                  )
                : Center(child: centerWidget ?? ""),
            onTap: onCenterItemPress,
          ),

          // Description
          Container(
            child: Text(
              description ?? "",
              style: styleDescription ??
                  TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              maxLines:
                  maxLineTextDescription != null ? maxLineTextDescription : 100,
              overflow: TextOverflow.ellipsis,
            ),
            margin: marginDescription ??
                EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          ),
        ],
      ),
    );
  }

  List<Widget> renderListDots() {
    dots.clear();
    for (int i = 0; i < slides.length; i++) {
      Color currentColor;
      if (tabController.index == i) {
        currentColor = colorActiveDot;
      } else {
        currentColor = colorDot;
      }
      dots.add(renderDot(sizeDot, currentColor));
    }
    return dots;
  }

  Widget renderDot(double radius, Color color) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius / 2)),
      width: radius,
      height: radius,
      margin: EdgeInsets.all(radius / 2),
    );
  }
}

class Slide {
  // Title
  /// Change text title at top
  String title;

  /// Change max number of lines title at top
  int maxLineTitle;

  /// Style for text title
  TextStyle styleTitle;

  /// Margin for text title
  EdgeInsets marginTitle;

  // Image
  /// Path to your local image
  String pathImage;

  /// Width of image
  double widthImage;

  /// Height of image
  double heightImage;

  /// Fire when press image
  Function onCenterItemPress;

  //region Center Widget
  Widget centerWidget;

  //endregion

  // Description
  /// Change text description at bottom
  String description;

  /// Maximum line of text description
  int maxLineTextDescription;

  /// Style for text description
  TextStyle styleDescription;

  /// Margin for text description
  EdgeInsets marginDescription;

  // Background color
  /// Background tab color
  Color backgroundColor;

  /// Gradient tab color begin
  Color colorBegin;

  /// Gradient tab color end
  Color colorEnd;

  /// Direction color begin
  AlignmentGeometry directionColorBegin;

  /// Direction color end
  AlignmentGeometry directionColorEnd;

  Slide({
    // Title
    String title,
    int maxLineTitle,
    TextStyle styleTitle,
    EdgeInsets marginTitle,

    // Image (if specified centerWidget is not displayed)
    String pathImage,
    double widthImage,
    double heightImage,
    Function onCenterItemPress,

    //Center Widget
    Widget centerWidget,

    // Description
    String description,
    int maxLineTextDescription,
    TextStyle styleDescription,
    EdgeInsets marginDescription,

    // Background color
    Color backgroundColor,
    Color colorBegin,
    Color colorEnd,
    AlignmentGeometry directionColorBegin,
    AlignmentGeometry directionColorEnd,
  }) {
    // Title
    this.title = title;
    this.maxLineTitle = maxLineTitle;
    this.styleTitle = styleTitle;
    this.marginTitle = marginTitle;

    // Image
    this.pathImage = pathImage;
    this.widthImage = widthImage;
    this.heightImage = heightImage;
    this.onCenterItemPress = onCenterItemPress;

    //Center Widget
    this.centerWidget = centerWidget;

    // Description
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
  }
}
