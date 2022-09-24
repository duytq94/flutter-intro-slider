<h1 align="center">FLUTTER INTRO SLIDER</h1>

<p align="center">Flutter Intro Slider is a flutter plugin that helps you make a cool intro for your app. Create intro has never been easier and faster</p>

## Table of Contents

- [Installing](#installing) - How to install
- [Demo](#demo) - How this plugin works
- [Code example](#code-example) - How to use
  - [Default config](#default-config)
  - [Custom config](#custom-config)
  - [Custom tab](#custom-tab)
- [IntroSlider parameter](#introslider-parameter) - Modifying frame slider (next, done btn, scroll behavior...)
- [IntroSliderTab parameter](#introslidertab-parameter) - Modifying tabs (content show to user, e.g. title, image, description...)
- [IndicatorConfig parameter](#indicatorconfig-parameter) - Modifying indicators (e.g. dot indicator)

## Installing

Add to pubspec.yaml file

```sh
dependencies:
  intro_slider: ^3.0.10
```

Import

```sh
import 'package:intro_slider/intro_slider.dart';
```

## Demo

![default](screenshots/default.gif) ![custom 1](screenshots/custom.gif) ![custom 2](screenshots/custom2.gif)

## Code example

### Default config

![default config image](screenshots/default.png)

<details>
  <summary>Code example (click to expand)</summary>
  
```dart
class IntroScreenDefaultState extends State<IntroScreenDefault> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "ERASER",
        description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "images/photo_eraser.png",
        backgroundColor: const Color(0xfff5a623),
      ),
    );
    slides.add(
      Slide(
        title: "PENCIL",
        description: "Ye indulgence unreserved connection alteration appearance",
        pathImage: "images/photo_pencil.png",
        backgroundColor: const Color(0xff203152),
      ),
    );
    slides.add(
      Slide(
        title: "RULER",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "images/photo_ruler.png",
        backgroundColor: const Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    log("End of slides");
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      slides: slides,
      onDonePress: onDonePress,
    );
  }
}
````

</details>

### Custom config

![custom config image](screenshots/custom.png)
<details>
  <summary>Code example (click to expand)</summary>

```dart
class IntroScreenCustomConfigState extends State<IntroScreenCustomConfig> {
  List<Slide> slides = [];
  Color activeColor = const Color(0xff0BEEF9);
  Color inactiveColor = const Color(0xff03838b);
  double sizeIndicator = 20;

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title:
            "A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE",
        maxLineTitle: 2,
        styleTitle: const TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
        styleDescription: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
        ),
        marginDescription: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 70.0,
        ),
        centerWidget: const Text(
          "Replace this with a custom widget",
          style: TextStyle(color: Colors.white),
        ),
        backgroundNetworkImage: "https://picsum.photos/600/900",
        onCenterItemPress: () {},
      ),
    );
    slides.add(
      Slide(
        title: "CITY",
        styleTitle: const TextStyle(
          color: Color(0xff7FFFD4),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description: "Ye indulgence unreserved connection alteration appearance",
        styleDescription: const TextStyle(
          color: Color(0xff7FFFD4),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
        ),
        colorBegin: const Color(0xff89D4CF),
        colorEnd: const Color(0xff734AE8),
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
    slides.add(
      Slide(
        title: "BEACH",
        styleTitle: const TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: const TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
        ),
        backgroundImage: "images/beach.jpeg",
        maxLineTextDescription: 3,
      ),
    );
  }

  void onDonePress() {
    log("onDonePress caught");
  }

  void onNextPress() {
    log("onNextPress caught");
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      size: 25,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      size: 25,
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      size: 25,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      foregroundColor: MaterialStateProperty.all<Color>(activeColor),
      backgroundColor: MaterialStateProperty.all<Color>(inactiveColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      // List slides
      slides: slides,

      // Skip button
      renderSkipBtn: renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: renderNextBtn(),
      onNextPress: onNextPress,
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Indicator
      sizeIndicator: sizeIndicator,
      indicatorWidget: Container(
        width: sizeIndicator,
        height: 10,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: inactiveColor),
      ),
      activeIndicatorWidget: Container(
        width: sizeIndicator,
        height: 10,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: activeColor),
      ),
      spaceBetweenIndicator: 10,

      // Behavior
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,
      verticalScrollbarBehavior: ScrollbarBehavior.alwaysShow,
      // autoScroll: true,
      loopAutoScroll: true,
      curveScroll: Curves.bounceIn,
    );
  }
}
````

</details>

### Custom tab

![custom config image](screenshots/custom2.png)

<details>
  <summary>Code example (click to expand)</summary>

```dart
class IntroScreenCustomTabState extends State<IntroScreenCustomTab> {
  List<Slide> slides = [];

  late Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "SCHOOL",
        styleTitle: const TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
        styleDescription: const TextStyle(
          color: Color(0xfffe9c8f),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
        ),
        pathImage: "images/photo_school.png",
      ),
    );
    slides.add(
      Slide(
        title: "MUSEUM",
        styleTitle: const TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description: "Ye indulgence unreserved connection alteration appearance",
        styleDescription: const TextStyle(
          color: Color(0xfffe9c8f),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
        ),
        pathImage: "images/photo_museum.png",
      ),
    );
    slides.add(
      Slide(
        title: "COFFEE SHOP",
        styleTitle: const TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: const TextStyle(
          color: Color(0xfffe9c8f),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
        ),
        pathImage: "images/photo_coffee_shop.png",
      ),
    );
  }

  void onDonePress() {
    // Back to the first tab
    goToTab(0);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
    log("onTabChangeCompleted, index: $index");
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(const Color(0x33ffcc5c)),
      overlayColor: MaterialStateProperty.all<Color>(const Color(0x33ffcc5c)),
    );
  }

  List<Widget> renderListCustomTabs() {
    return List.generate(
      slides.length,
      (index) => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                child: Image.asset(
                  slides[index].pathImage!,
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Text(
                  slides[index].title!,
                  style: slides[index].styleTitle,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Text(
                  slides[index].description ?? '',
                  style: slides[index].styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      // Skip button
      renderSkipBtn: renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Indicator
      colorIndicator: const Color(0xffffcc5c),
      sizeIndicator: 13.0,
      typeIndicatorAnimation: TypeIndicatorAnimation.sizeTransition,

      // Tabs
      listCustomTabs: renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: const BouncingScrollPhysics(),
      hideStatusBar: true,
      onTabChangeCompleted: onTabChangeCompleted,
    );
  }
}
```

</details>

## IntroSlider parameter

| Name                   | Type                                | Default                                      | Description                                                                                        |
| ---------------------- | ----------------------------------- | -------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| <b>Tab</b>             |                                     |                                              |                                                                                                    |
| tabs                   | `List<IntroSliderTab>?`             | [View details](#introslidertab-parameter)    | An array of IntroSliderTab widget, require if *listCustomTabs* not defined                         |
| listCustomTabs         | `List<Widget>?`                     | Require if *tabs* not defined                | Render your own widget list tabs (meaning you can put your custom widget to in the prebuilt frame) |
| refFuncGoToTab         | `void Function(Function function)?` | Do nothing                                   | Send the reference of change tab's function, then we can move to any tab index programmatically    |
| onTabChangeCompleted   | `void Function(int index)?`         | Do nothing                                   | Callback when tab change comleted, return the current tab's index                                  |
| backgroundColorAllTabs | `Color?`                            | Transparent                                  | Background color for all tabs (if backgroundColor on each tab not set)                             |
| <b>Skip Button</b>     |                                     |                                              |                                                                                                    |
| renderSkipBtn          | `Widget?`                           | Button with white text SKIP                  | Render your own widget SKIP button                                                                 |
| skipButtonStyle        | `ButtonStyle?`                      | ButtonStyle()                                | Style for SKIP button                                                                              |
| onSkipPress            | `void Function()?`                  | Go to last page                              | Fire when press SKIP button                                                                        |
| showSkipBtn            | `bool?`                             | true                                         | Show or hide SKIP button                                                                           |
| skipButtonKey          | `Key?`                              |                                              | Assign key to SKIP button                                                                          |
| <b>Previous Button</b> |                                     |                                              |                                                                                                    |
| renderPrevBtn          | `Widget?`                           | Button with white text PREV                  | Render your own PREV button                                                                        |
| prevButtonStyle        | `ButtonStyle?`                      | ButtonStyle()                                | Style for PREV button                                                                              |
| showPrevBtn            | `bool?`                             | false                                        | Show or hide PREV, have to set showSkipBtn to false at first if you want to show this button       |
| prevButtonKey          | `Key?`                              |                                              | Assign key to PREV button                                                                          |
| <b>Done Button</b>     |                                     |                                              |                                                                                                    |
| renderDoneBtn          | `Widget?`                           | Button with white text DONE                  | Render your own DONE button                                                                        |
| doneButtonStyle        | `ButtonStyle?`                      | ButtonStyle()                                | Style for DONE button                                                                              |
| onDonePress            | `void Function()?`                  | Do nothing                                   | Fire when press DONE button                                                                        |
| showDoneBtn            | `bool?`                             | true                                         | Show or hide DONE button                                                                           |
| doneButtonKey          | `Key?`                              |                                              | Assign key to NEXT button                                                                          |
| <b>Next Button</b>     |                                     |                                              |                                                                                                    |
| renderNextBtn          | `Widget?`                           | Button with white text NEXT                  | Render your own NEXT button                                                                        |
| nextButtonStyle        | `ButtonStyle?`                      | ButtonStyle()                                | Style for NEXT button                                                                              |
| onNextPress            | `void Function()?`                  | Do nothing                                   | Fire when press NEXT button                                                                        |
| showNextBtn            | `bool?`                             | true                                         | Show or hide NEXT button                                                                           |
| nextButtonKey          | `Key?`                              |                                              | Assign key to NEXT button                                                                          |
| <b>Indicator</b>       |                                     |                                              |                                                                                                    |
| indicatorConfig        | `IndicatorConfig?`                  | [View details](#indicatorconfig-parameter)   |
| <b>Scroll behavior</b> |                                     |                                              |                                                                                                    |
| scrollable             | `bool?`                             | true                                         | If false, user only scroll by tap nav button                                                       |
| autoScroll             | `bool?`                             | false                                        | Enable auto scroll slides                                                                          |
| loopAutoScroll         | `bool?`                             | false                                        | Loop transition by go to first slide when reach the end                                            |
| pauseAutoPlayOnTouch   | `bool?`                             | true                                         | Auto scroll will be paused if user touch to slide                                                  |
| autoScrollInterval     | `Duration?`                         | 4 seconds                                    | Sets duration to determine the frequency of slides                                                 |
| curveScroll            | `Curve?`                            | Curves.ease                                  | Set transition animation curves.                                                                   |
| scrollPhysics          | `ScrollPhysics?`                    | ScrollPhysics()                              | Determines the physics horizontal scroll for the slides                                            |
| <b>Others</b>          |                                     |                                              |                                                                                                    |
| hideStatusBar          | `bool?`                             | false                                        | Show or hide the status bar                                                                        |
| navPosition            | `NavPosition?`                      | NavPosition.bottom                           | Customize the position of navigation bar to the top or bottom of the screen                        |
| navMargin              | `double?`                           | Max (MediaQuery.of(context).viewPadding, 10) | Distance of navigation bar from edge screen (top or bottom)                                        |
| key                    | `Key?`                              |                                              | Assign key to IntroSlider widget                                                                   |

## IntroSliderTab parameter

| Name                      | Type                      | Default                                 | Description                                                                                                                      |
| ------------------------- | ------------------------- | --------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| <b>Title</b>              |                           |                                         |                                                                                                                                  |
| title                     | `String?`                 | ""                                      | Change text title at top                                                                                                         |
| widgetTitle               | `Widget?`                 | null                                    | Set a custom widget as the title (ignore `title` if define both)                                                                 |
| maxLineTitle              | `int?`                    | 1                                       | Change max number of lines title at top                                                                                          |
| styleTitle                | `TextStyle?`              | White color, bold and font size is 30.0 | Style for text title                                                                                                             |
| textAlignTitle            | `TextAlign?`              | TextAlign.center                        | TextAlign for text title                                                                                                         |
| textOverFlowTitle         | `TextOverflow?`           | TextOverflow.ellipsis                   | TextOverflow for text title                                                                                                      |
| marginTitle               | `EdgeInsets?`             | top: 70.0, bottom: 50.0                 | Margin for text title                                                                                                            |
| <b>Image</b>              |                           |                                         |                                                                                                                                  |
| pathImage                 | `String?`                 | ""                                      | Path to your local image                                                                                                         |
| widthImage                | `double?`                 | 250.0                                   | Width of image                                                                                                                   |
| heightImage               | `double?`                 | 250.0                                   | Height of image                                                                                                                  |
| foregroundImageFit        | `BoxFit?`                 | BoxFit.contain                          | Foreground image fit                                                                                                             |
| <b>Center widget</b>      |                           |                                         |                                                                                                                                  |
| centerWidget              | `Widget?`                 | null                                    | Your custom's widget                                                                                                             |
| onCenterItemPress         | `Function()?`             | Do nothing                              | Fire when press center image/widget                                                                                              |
| <b>Description</b>        |                           |                                         |                                                                                                                                  |
| description               | `String?`                 | ""                                      | Change text description at bottom                                                                                                |
| widgetDescription         | `Widget?`                 | null                                    | Set a custom widget as the description (ignore `description` if define both)                                                     |
| maxLineTextDescription    | `int?`                    | 100                                     | Maximum line of text description                                                                                                 |
| styleDescription          | `TextStyle?`              | White and font size is 18.0             | Style for text description                                                                                                       |
| textAlignDescription      | `TextAlign?`              | TextAlign.center                        | TextAlign for text description                                                                                                   |
| textOverFlowDescription   | `TextOverflow?`           | TextOverflow.ellipsis                   | TextOverflow for text description                                                                                                |
| marginDescription         | `EdgeInsets?`             | left, right = 20.0, top, bottom = 50.0  | Margin for text description                                                                                                      |
| <b>Background Color</b>   |                           |                                         |                                                                                                                                  |
| backgroundColor           | `Color?`                  | Colors.amberAccent                      | Background tab color (if set, will ignore gradient properties below)                                                             |
| colorBegin                | `Color?`                  | Colors.amberAccent                      | Gradient tab color begin                                                                                                         |
| colorEnd                  | `Color?`                  | Colors.amberAccent                      | Gradient tab color end                                                                                                           |
| directionColorBegin       | `AlignmentGeometry?`      | Alignment.topLeft                       | Direction color begin                                                                                                            |
| directionColorEnd         | `AlignmentGeometry?`      | Alignment.bottomRight                   | Direction color end                                                                                                              |
| <b>Background Image</b>   |                           |                                         |                                                                                                                                  |
| backgroundImage           | `String?`                 | null                                    | Background tab image                                                                                                             |
| backgroundNetworkImage    | `String?`                 | null                                    | Background tab image (from network)                                                                                              |
| backgroundImageFit        | `BoxFit?`                 | BoxFit.cover                            | Background tab image fit                                                                                                         |
| backgroundOpacity         | `double?`                 | 0.5                                     | Background tab image filter opacity                                                                                              |
| backgroundOpacityColor    | `Color?`                  | Colors.black                            | Background tab image filter color                                                                                                |
| backgroundBlendMode       | `BlendMode?`              | BlendMode.darken                        | Background tab image filter blend mode                                                                                           |
| <b>Others</b>             |                           |                                         |                                                                                                                                  |
| verticalScrollbarBehavior | `enum ScrollbarBehavior?` | ScrollbarBehavior.HIDE                  | Allow to specify how the vertical scrollbar should behave <br>(scroll enable when content length is greater than screen length ) |
| navPosition               | `NavPosition?`            | NavPosition.bottom                      | This should be the same navPosition value at *IntroSlider* (so I can set right padding content)                                  |
| navMargin                 | `double?`                 | 60                                      | This should be sum of navMargin value at *IntroSlider* & navigation bar height                                                   |
| key                       | `Key?`                    |                                         | Assign key to IntroSliderTab widget                                                                                              |

## IndicatorConfig parameter
| Name                   | Type                           | Default                         | Description                                                                                                                 |
| ---------------------- | ------------------------------ | ------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| isShowIndicator        | `bool?`                        | true                            | Show or hide indicator                                                                                                      |
| colorIndicator         | `Color?`                       | Color(0x80000000)               | Color indicator when passive, note: ignore if using custom indicator                                                        |
| colorActiveIndicator   | `Color?`                       | Color(0xffffffff)               | Color indicator when active (focusing), note: ignore if using custom indicator or TypeIndicatorAnimation.sizeTransition     |
| sizeIndicator          | `double?`                      | 8.0                             | Size of each indicator                                                                                                      |
| spaceBetweenIndicator  | `double?`                      | The same value of sizeIndicator | Space between every indicator (if using custom indicator, please set this value the same width value of your custom widget) |
| typeIndicatorAnimation | `enum TypeIndicatorAnimation?` | TypeIndicatorAnimation.sliding  | Type indicator animation                                                                                                    |
| indicatorWidget        | `Widget?`                      | Default dot                     | Your custom indicator widget                                                                                                |
| activeIndicatorWidget  | `Widget?`                      | Default dot                     | Your custom active (focusing) indicator widget, note: ignore if using TypeIndicatorAnimation.sizeTransition                 |

## Pull request and feedback are always appreciated
