import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreenCustomLayout extends StatefulWidget {
  const IntroScreenCustomLayout({Key? key}) : super(key: key);

  @override
  IntroScreenCustomLayoutState createState() => IntroScreenCustomLayoutState();
}

// ------------------ Custom layout ------------------
class IntroScreenCustomLayoutState extends State<IntroScreenCustomLayout> {
  late Function goToTab;

  Color primaryColor = const Color(0xffffcc5c);
  Color secondColor = const Color(0xff3da4ab);

  void onDonePress() {
    goToTab(0);
  }

  void onTabChangeCompleted(index) {
    log("onTabChangeCompleted, index: $index");
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: primaryColor,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: primaryColor,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: primaryColor,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(const Color(0x33ffcc5c)),
      overlayColor: MaterialStateProperty.all<Color>(const Color(0x33ffcc5c)),
    );
  }

  List<Widget> generateListCustomTabs() {
    return List.generate(
      3,
      (index) => Container(
        color: Colors.black26,
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: DropdownButton<String>(
                value: index.toString(),
                icon: Icon(Icons.arrow_downward, color: secondColor, size: 20),
                elevation: 16,
                style: TextStyle(color: primaryColor),
                underline: Container(
                  height: 2,
                  color: secondColor,
                ),
                onChanged: (String? value) {},
                items: ["0", "1", "2"].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: secondColor, fontSize: 20)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Image.network(
              "https://picsum.photos/${300 + index}",
              width: 300.0,
              height: 300.0,
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Text(
                "Title at index $index",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondColor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
          ],
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
      indicatorConfig: const IndicatorConfig(
        colorIndicator: Color(0xffffcc5c),
        colorActiveIndicator: Colors.blue,
        sizeIndicator: 13.0,
        typeIndicatorAnimation: TypeIndicatorAnimation.sizeTransition,
      ),

      // Custom tabs
      listCustomTabs: generateListCustomTabs(),
      backgroundColorAllTabs: Colors.white,
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: const BouncingScrollPhysics(),
      onTabChangeCompleted: onTabChangeCompleted,
    );
  }
}
