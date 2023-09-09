## 4.2.1
* Make able to use colorActiveIndicator when using TypeIndicatorAnimation.sizeTransition

## 4.2.0
* Optimize render
* Remove some unnecessary code
* Fix some wrong info from docs

## 4.1.0
* Add support web
* Fix some wrong parameter at readme
* Remove hideStatusBar (should be config by main page, not by this widget)

## 4.0.0
* Restructure some parameter to make clearer
* Customizable indicator
* Customizable position navigation bar
* Optimize code flow

## 3.0.10
* Fix disable auto scroll not working
* Fix can not set text color navigate buttons

## 3.0.9
* Add auto scroll

## 3.0.8
* Add TextAlign & TextOverFlow fot title & description

## 3.0.7
* Fixing FlutterError (IntroSliderState#c8edc(ticker active) was disposed with an active Ticker.

## 3.0.6
* Add IntroSliderNavPosition
* Fixing some conflict properties & update docs

## 3.0.5
* Updated package to Flutter 3 and Dart 2.17
* Updated example to Flutter 3 and Dart 2.17
* BREAKING: only package:intro_slider/flutter_intro_slider.dart has to be imported now to get access to the whole feature
* BREAKING: "dotSliderAnimation" is now "DotSliderAnimation" to match enum guidelines
* BREAKING: "scrollbarBehavior" is now "ScrollbarBehavior" to match enum guidelines
* Internal: Project structure cleanup
* Internal: Example cleanup
* Internal: Added flutter_lints
* Internal: Renamed files to match the class name
* Internal: Removed home.dart from example

## 3.0.4
* Add backgroundNetworkImage

## 3.0.3
* Add onNextPress method

## 3.0.2
* Add keys for some buttons (skip, next, prev, done) for support testing

## 3.0.1
* Update some null safety syntax and example

## 3.0.0
* Revamp PREV, NEXT, SKIP, DONE buttons
* Fix wrong and missing docs

## 2.4.3
* Change slide on dot click

## 2.4.2
* Fixing onTabChangeCompleted is never called

## 2.4.1
* Fixing set button colors don't working properly

## 2.4.0
* Migrating to null safety

## 2.3.4
* Allow custom the physics horizontal scroll for the slide
* `slides` not require when using `listCustomTabs`

## 2.3.3
* Update scrollbar

## 2.3.2
* Add scrollbar for tab content

## 2.3.1
* Update example (migrate to AndroidX)

## 2.3.0
* Add isShowNextBtn

## 2.2.9
* Dispose tabController/animations.

## 2.2.8
* Allow supplying a custom title and/or description widgets.

## 2.2.7
* Set backgroundColor to Colors.amberAccent when not define

## 2.2.6
* Remove some unnecessary files

## 2.2.5
* Update docs

## 2.2.4
* Update docs

## 2.2.3
* Fix dot animation don't working properly on RTL language

## 2.2.2
* Add refFuncGoToTab, then we can move to any tab index programmatically

## 2.2.1
* Fix color dots displaced to the right on last slide

## 2.2.0
* Add more dots animation 

## 2.1.1
* Add can set background color for all slides
* Add can hide DONE button

## 2.1.0
* Add animation when dot indicator is moving

## 2.0.3
* Fix error when onTabChangeCompleted not defined

## 2.0.2
* Add callback onTabChangeCompleted

## 2.0.1
* Add custom boxfit to foreground image

## 2.0.0
* Add custom your own tabs

## 1.2.3
* Update

## 1.2.2
* Remove MaterialApp and replacing it by a Scaffold since should only be one MaterialApp() per application
* Remove locale since it should handle by primary application (and it is configured by MaterialApp), not by the plugin.

## 1.2.1
* Add optional onSkipPress

## 1.2.0
* Add PREV button and optimize code

## 1.1.9
* Add default go to last page at onSkipPress

## 1.1.8
* Add configuration able to scroll

## 1.1.7
* Fix content scroll overlain bottom view
* Add set width of done, next button

## 1.1.6
* Add option show or hide the status bar
* Adding locale feature, adjust bottom navigation

## 1.1.5
* Fix margin not a type of double

## 1.1.4
* Format code

## 1.1.3
* Add background image

## 1.1.2
* Add custom center widget

## 1.1.1
* Update docs and remove redundant attributes at slide

## 1.1.0
* Add set max number of lines at title

## 1.0.9
* Fix navigate example

## 1.0.8
* Change color options to be instances of `Color` instead `int`

## 1.0.7
* Add onCLickImage and maxLines text description

## 1.0.6
* Add gradient background color

## 1.0.5
* Add more attribute

## 1.0.4
* Update info

## 1.0.3
* Update info

## 1.0.2
* Update info

## 1.0.1
* Update

## 1.0.0
* Update

## 0.0.1
* Initial Release