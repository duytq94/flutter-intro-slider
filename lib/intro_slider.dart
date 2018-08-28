import 'package:flutter/material.dart';

class IntroSlider extends StatefulWidget {
  // List slides
  final List<Slide> slides;

  // Skip button
  final Widget renderSkipBtn;
  final Function onSkipPress;
  final String nameSkipBtn;
  final TextStyle styleNameSkipBtn;
  final int colorSkipBtn;
  final int highlightColorSkipBtn;
  final bool isShowSkipBtn;

  // Next, Done button
  final Widget renderNextBtn;
  final Widget renderDoneBtn;
  final Function onDonePress;
  final String nameNextBtn;
  final String nameDoneBtn;
  final TextStyle styleNameDoneBtn;
  final int colorDoneBtn;
  final int highlightColorDoneBtn;

  // Dot indicator
  final bool isShowDotIndicator;
  final int colorDot;
  final int colorActiveDot;
  final double sizeDot;

  // Constructor
  IntroSlider({
    // List slides
    @required this.slides,

    // Skip button
    this.renderSkipBtn,
    this.onSkipPress,
    this.nameSkipBtn,
    this.styleNameSkipBtn,
    this.colorSkipBtn,
    this.highlightColorSkipBtn,
    this.isShowSkipBtn,

    // Done button
    this.renderNextBtn,
    this.renderDoneBtn,
    this.onDonePress,
    this.nameNextBtn,
    this.nameDoneBtn,
    this.styleNameDoneBtn,
    this.colorDoneBtn,
    this.highlightColorDoneBtn,

    // Dot indicator
    this.isShowDotIndicator,
    this.colorDot,
    this.colorActiveDot,
    this.sizeDot,
  });

  @override
  IntroSliderState createState() => new IntroSliderState(
        // List slides
        slides: this.slides,

        // Skip button
        renderSkipBtn: this.renderSkipBtn,
        onSkipPress: this.onSkipPress,
        nameSkipBtn: this.nameSkipBtn,
        styleNameSkipBtn: this.styleNameSkipBtn,
        colorSkipBtn: this.colorSkipBtn,
        highlightColorSkipBtn: this.highlightColorSkipBtn,
        isShowSkipBtn: this.isShowSkipBtn,

        // Done button
        renderNextBtn: this.renderNextBtn,
        renderDoneBtn: this.renderDoneBtn,
        onDonePress: this.onDonePress,
        nameNextBtn: this.nameNextBtn,
        nameDoneBtn: this.nameDoneBtn,
        styleNameDoneBtn: this.styleNameDoneBtn,
        colorDoneBtn: this.colorDoneBtn,
        highlightColorDoneBtn: this.highlightColorDoneBtn,

        // Dot indicator
        isShowDotIndicator: this.isShowDotIndicator,
        colorDot: this.colorDot,
        colorActiveDot: this.colorActiveDot,
        sizeDot: this.sizeDot,
      );
}

class IntroSliderState extends State<IntroSlider>
    with SingleTickerProviderStateMixin {
  // List slides
  final List<Slide> slides;

  // Skip button
  Widget renderSkipBtn;
  Function onSkipPress;
  String nameSkipBtn;
  TextStyle styleNameSkipBtn;
  int colorSkipBtn;
  int highlightColorSkipBtn;
  bool isShowSkipBtn;

  // Done button
  Widget renderNextBtn;
  Widget renderDoneBtn;
  Function onDonePress;
  String nameNextBtn;
  String nameDoneBtn;
  TextStyle styleNameDoneBtn;
  int colorDoneBtn;
  int highlightColorDoneBtn;

  // Dot indicator
  bool isShowDotIndicator = true;
  int colorDot;
  int colorActiveDot;
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

    // Done button
    @required this.renderNextBtn,
    @required this.renderDoneBtn,
    @required this.onDonePress,
    @required this.nameNextBtn,
    @required this.nameDoneBtn,
    @required this.styleNameDoneBtn,
    @required this.colorDoneBtn,
    @required this.highlightColorDoneBtn,

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
      colorDot = 0x80000000;
    }
    if (colorActiveDot == null) {
      colorActiveDot = 0xffffffff;
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
                              ? Color(colorSkipBtn)
                              : Colors.transparent,
                          highlightColor: highlightColorSkipBtn != null
                              ? Color(highlightColorSkipBtn)
                              : Colors.white.withOpacity(0.3),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                        )
                      : FlatButton(
                          onPressed: onSkipPress,
                          child: Text(
                            nameSkipBtn ?? "SKIP",
                            style: styleNameSkipBtn ??
                                TextStyle(color: Colors.white),
                          ),
                          color: colorSkipBtn != null
                              ? Color(colorSkipBtn)
                              : Colors.transparent,
                          highlightColor: highlightColorSkipBtn != null
                              ? Color(highlightColorSkipBtn)
                              : Colors.white.withOpacity(0.3),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
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
                            ? Color(colorDoneBtn)
                            : Colors.transparent,
                        highlightColor: highlightColorDoneBtn != null
                            ? Color(highlightColorDoneBtn)
                            : Colors.white.withOpacity(0.3),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      )
                    : FlatButton(
                        onPressed: onDonePress,
                        child: Text(
                          nameDoneBtn ?? "DONE",
                          style: styleNameDoneBtn ??
                              TextStyle(color: Colors.white),
                        ),
                        color: colorDoneBtn != null
                            ? Color(colorDoneBtn)
                            : Colors.transparent,
                        highlightColor: highlightColorDoneBtn != null
                            ? Color(highlightColorDoneBtn)
                            : Colors.white.withOpacity(0.3),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      ))
                : (renderNextBtn != null
                    ? FlatButton(
                        onPressed: () {
                          tabController.animateTo(tabController.index + 1);
                        },
                        child: renderNextBtn,
                        color: colorDoneBtn != null
                            ? Color(colorDoneBtn)
                            : Colors.transparent,
                        highlightColor: highlightColorDoneBtn != null
                            ? Color(highlightColorDoneBtn)
                            : Colors.white.withOpacity(0.3),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
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
                            ? Color(colorDoneBtn)
                            : Colors.transparent,
                        highlightColor: highlightColorDoneBtn != null
                            ? Color(highlightColorDoneBtn)
                            : Colors.white.withOpacity(0.3),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
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
          slides[i].styleTitle,
          slides[i].marginTitle,
          slides[i].description,
          slides[i].styleDescription,
          slides[i].marginDescription,
          slides[i].pathImage,
          slides[i].widthImage,
          slides[i].heightImage,
          slides[i].backgroundColor,
        ),
      );
    }
    return tabs;
  }

  Widget renderTab(
    String title,
    TextStyle styleTitle,
    EdgeInsets marginTitle,
    String description,
    TextStyle styleDescription,
    EdgeInsets marginDescription,
    String pathImage,
    double widthImage,
    double heightImage,
    int backgroundColor,
  ) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(backgroundColor ?? 0xfff5a623),
      child: Column(
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
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            margin: marginTitle ?? EdgeInsets.only(top: 70.0, bottom: 50.0),
          ),

          // Image
          Image.asset(
            pathImage ?? "",
            width: widthImage ?? 250.0,
            height: heightImage ?? 250.0,
            fit: BoxFit.contain,
          ),

          // Description
          Container(
            child: Text(
              description ?? "",
              style: styleDescription ??
                  TextStyle(color: Colors.white, fontSize: 18.0),
              maxLines: 3,
              textAlign: TextAlign.center,
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
      int currentColor;
      if (tabController.index == i) {
        currentColor = colorActiveDot;
      } else {
        currentColor = colorDot;
      }
      dots.add(renderDot(sizeDot, currentColor));
    }
    return dots;
  }

  Widget renderDot(double radius, int color) {
    return Container(
      decoration: BoxDecoration(
          color: Color(color), borderRadius: BorderRadius.circular(radius / 2)),
      width: radius,
      height: radius,
      margin: EdgeInsets.all(radius / 2),
    );
  }
}

class Slide {
  // Title
  String title;
  TextStyle styleTitle;
  EdgeInsets marginTitle;

  // Image
  String pathImage;
  double widthImage;
  double heightImage;

  // Description
  String description;
  TextStyle styleDescription;
  EdgeInsets marginDescription;

  // Background color
  int backgroundColor;

  // Skip button
  String nameSkipBtn;
  TextStyle styleNameSkipBtn;
  int colorSkipBtn;
  int highlightColorSkipBtn;

  // Done button
  String nameDoneBtn;
  TextStyle styleNameDoneBtn;
  int colorDoneBtn;
  int highlightColorDoneBtn;

  Slide({
    // Title
    String title,
    TextStyle styleTitle,
    EdgeInsets marginTitle,

    // Image
    String pathImage,
    double widthImage,
    double heightImage,

    // Description
    String description,
    TextStyle styleDescription,
    EdgeInsets marginDescription,

    // Background color
    int backgroundColor,
  }) {
    // Title
    this.title = title;
    this.styleTitle = styleTitle;
    this.marginTitle = marginTitle;

    // Image
    this.pathImage = pathImage;
    this.widthImage = widthImage;
    this.heightImage = heightImage;

    // Description
    this.description = description;
    this.styleDescription = styleDescription;
    this.marginDescription = marginDescription;

    // Background color
    this.backgroundColor = backgroundColor;

    // Skip button
    this.nameSkipBtn = nameSkipBtn;
    this.styleNameSkipBtn = styleNameSkipBtn;
    this.colorSkipBtn = colorSkipBtn;
    this.highlightColorSkipBtn = highlightColorSkipBtn;

    // Done button
    this.nameDoneBtn = nameDoneBtn;
    this.styleNameDoneBtn = styleNameDoneBtn;
    this.colorDoneBtn = colorDoneBtn;
    this.highlightColorDoneBtn = highlightColorDoneBtn;
  }
}
